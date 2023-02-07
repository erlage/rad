// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/abstract/router_render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/options/router_options.dart';
import 'package:rad/src/core/interface/window/window.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/router/router_link.dart';
import 'package:rad/src/core/services/router/router_request.dart';
import 'package:rad/src/core/services/router/router_stack.dart';
import 'package:rad/src/core/services/router/router_stack_entry.dart';

/// Router service.
///
@internal
class RouterService extends Service {
  final RouterOptions options;

  final _routerStack = RouterStack();

  /// Registered [RouterRenderElement]s.
  ///
  /// [RouterRenderElement]: [RouterLink]
  ///
  final _routerElements = <RouterRenderElement, RouterLink>{};

  /// Router request stream.
  ///
  /// Router services uses this stream, internally, to linearize all calls
  /// made to pushState, pushReplacements methods.
  ///
  StreamController<RouterRequest>? _routerRequestsStream;

  RouterService(RootRenderElement rootElement, this.options)
      : super(rootElement);

  @override
  startService() {
    Window.delegate.addPopStateListener(
      rootElement: rootElement,
      callback: _onPopState,
    );

    _routerRequestsStream = StreamController<RouterRequest>();
    _routerRequestsStream?.stream.listen(_processRouterRequest);
  }

  @override
  stopService() {
    _routerRequestsStream?.close();

    _routerElements.clear();
    _routerStack.clear();

    Window.delegate.removePopStateListener(rootElement);
  }

  /// Register [RouterRenderElement].
  ///
  void register(RouterRenderElement routerElement) {
    assert(
      !_routerElements.containsKey(routerElement),
      'Node: $routerElement is already registered',
    );

    _register(routerElement);
  }

  void unRegister(RouterRenderElement routerElement) {
    _routerElements.remove(routerElement)?.disbandLink();

    _routerStack.remove(routerElement);
  }

  /// Push page entry.
  ///
  void pushEntry({
    required String path,
    required Map<String, String> values,
    required RouterRenderElement routerElement,
    required bool updateHistory,
  }) {
    _routerRequestsStream?.sink.add(
      RouterRequest(
        path: path,
        values: values,
        routerElement: routerElement,
        updateHistory: updateHistory,
        isReplacement: false,
      ),
    );
  }

  /// Push page entry as replacement.
  ///
  /// This allows nested [RouterRenderElement] to do initial linking.
  ///
  void pushReplacement({
    required String path,
    required Map<String, String> values,
    required RouterRenderElement routerElement,
  }) {
    _routerRequestsStream?.sink.add(
      RouterRequest(
        path: path,
        values: values,
        routerElement: routerElement,
        isReplacement: true,
        updateHistory: true, // irrelevant if is replacement
      ),
    );
  }

  /// Manually dispatch a back action.
  ///
  void dispatchBackAction() {
    Window.delegate.historyBack(rootElement: rootElement);
  }

  /// Get [RouterLink] object.
  ///
  RouterLink getRouterLink(RouterRenderElement routerElement) {
    var linkObject = _routerElements[routerElement];

    assert(null != linkObject, 'Router has gone wild');
    return linkObject as RouterLink;
  }

  /// Get current path based on [RouterRenderElement]'s access.
  ///
  /// Returns empty string, if matches nothing. [RouterRenderElement]s should
  /// display default page when [getCurrentPath] returns empty string.
  ///
  String getCurrentPath(RouterRenderElement routerElement) {
    var segments = accessibleSegments(routerElement);

    var matchedPathSegment = '';
    for (final segment in segments) {
      if (routerElement.isRoutePathExists(path: segment)) {
        matchedPathSegment = segment;

        break;
      }
    }

    if (DEBUG_BUILD) {
      if (services.debug.routerLogs) {
        print(
          'Router Element(#$routerElement) matched: '
          "'$matchedPathSegment' from '${segments.join("/")} < "
          " (${_getCurrentSegments()})'",
        );
      }
    }

    return matchedPathSegment;
  }

  /// Get value following the provided segment in URL.
  ///
  String getValue(RouterRenderElement routerElement, String segment) {
    var encodedSegment = fnEncodeValue(segment);

    var path = accessibleSegments(routerElement).join('/');

    // try to find a value that's following the provided segment in path

    var match = RegExp(encodedSegment + r'\/+([^\/]+)').firstMatch(path);

    return (null == match) ? '' : fnDecodeValue(match.group(1) ?? '');
  }

  void ensureRouterElementIsVisible(RouterLink linkObject) {
    var parentLinkObject = linkObject.parentLink;

    if (null != parentLinkObject) {
      ensureRouterElementIsVisible(parentLinkObject);

      var parentRouterElement = parentLinkObject.routerElement;
      var parentRoutePathToOpen = linkObject.segments.last;

      parentRouterElement.openPath(
        path: parentRoutePathToOpen,
        updateHistory: false,
      );
    }
  }

  /// Part of path(Window.delegate.locationPathName) that current
  /// [RouterRenderElement] can access.
  ///
  List<String> accessibleSegments(RouterRenderElement routerElement) {
    var routerLink = getRouterLink(routerElement);
    var currentSegments = _getCurrentSegments();

    // if root RouterRenderElement, all segments are available

    if (null == routerLink.parentLink) {
      return currentSegments;
    }

    // else limit part of path that's visible to current RouterRenderElement

    var matcher = '';

    if (routerLink.segments.length < 3) {
      matcher = r'^\/*.*(' + routerLink.segments.last + r'.*)';
    } else {
      matcher = r'^\/*' +
          routerLink.segments[1] +
          r'.*(' +
          routerLink.segments.last +
          r'.*)';
    }

    var path = currentSegments.join('/');

    var match = RegExp(matcher).firstMatch(path);

    if (null == match) return [];

    var group = match.group(1);

    if (null == group) return [];

    return group.split('/');
  }

  /// Part of path(Window.delegate.locationPathName) that current
  /// [RouterRenderElement] can't change.
  ///
  /// Note that, [RouterRenderElement] still can access **some parts** of
  /// protected segments using [accessibleSegments]
  ///
  List<String> protectedSegments(RouterRenderElement routerElement) {
    var routerLink = getRouterLink(routerElement);

    // if root, no segments are protected

    if (null == routerLink.parentLink) {
      return _getRoutingPath().split('/');
    }

    // else find protected part

    var matcher = '';

    var matchRoutes = routerElement.getPathList().join(r'|\/');

    if (routerLink.segments.length < 3) {
      matcher = r'(^\/*.*' +
          routerLink.segments.last +
          r'.*(?=\/' +
          matchRoutes +
          r'))';
    } else {
      matcher = r'(^\/*' +
          routerLink.segments[1] +
          r'.*' +
          routerLink.segments.last +
          r'.*(?=\/' +
          matchRoutes +
          r'))';
    }

    var currentSegments = _getCurrentSegments();

    var path = currentSegments.join('/');

    var match = RegExp(matcher).firstMatch(path);

    if (null == match) return currentSegments;

    var group = match.group(1);

    if (null == group) return currentSegments;

    return group.split('/');
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  void _onPopState(PopStateEvent event) {
    try {
      var location = Window.delegate.locationHref;

      if (DEBUG_BUILD) {
        if (services.debug.routerLogs) {
          print('Router: onPopState: location: $location');
        }
      }

      // find or manage user history entry

      var entry = _routerStack.find(location);

      // user is traversing passive history.

      if (null == entry) {
        //
        // passive history is 'state' that browser kept after user had left the
        // site. this is to allow user navigate between sites using back button.
        //
        // since at this point, our state is lost, our entries are lost too.
        // and reloading window will build the correct interface.

        if (DEBUG_BUILD) {
          if (services.debug.routerLogs) {
            print("Router: onPopState: entry doesn't exists: $entry");
          }
        }

        Window.delegate.locationReload();

        // for active history, our implementation is ready, see below.

      } else {
        var routerElement = entry.routerElement;
        var routerLink = getRouterLink(routerElement);

        ensureRouterElementIsVisible(routerLink);

        if (DEBUG_BUILD) {
          if (services.debug.routerLogs) {
            print('Router: onPopState: open: ${entry.path}');
          }
        }

        routerElement.openPath(
          path: entry.path,
          values: entry.values,
          updateHistory: false,
        );
      }
    } catch (e) {
      // reload window if anything goes wrong

      Window.delegate.locationReload();
    }
  }

  /// Associate [RouterRenderElement] with a [RouterLink] object.
  ///
  void _setRouterLink({
    required RouterRenderElement routerElement,
    required RouterLink routerLink,
  }) {
    _routerElements[routerElement] = routerLink;
  }

  /// Get routing path.
  ///
  String _getRoutingPath() => options.path;

  /// Get current location.
  ///
  String _getCurrentPath() {
    var currentPath = Window.delegate.locationPathName;

    if (options.enableHashBasedRouting) {
      var hashPart = Window.delegate.locationHash;

      // remove leading hash
      if (hashPart.startsWith('#')) {
        hashPart = hashPart.substring(1);
      }

      currentPath += hashPart;
    }

    return currentPath;
  }

  List<String> _getCurrentSegments() {
    return _getCurrentPath().split('/')
      ..removeWhere((segment) => segment.trim().isEmpty);
  }

  /// Prepare router segments.
  ///
  List<String> _prepareSegments(List<String> segments) {
    var preparedSegs = <String>[];

    // Insert hash if hash based routing is enabled

    if (options.enableHashBasedRouting) {
      var routingPath = _getRoutingPath();

      if (routingPath.isEmpty) {
        segments.insert(0, '#');
      } else {
        segments = segments
            .join('/')
            .replaceRange(0, routingPath.length, '$routingPath/#/')
            .split('/');
      }
    }

    for (final segment in segments) {
      if (segment.isNotEmpty) {
        preparedSegs.add(segment);
      }
    }

    return preparedSegs;
  }

  void _processRouterRequest(RouterRequest request) {
    var path = request.path;
    var values = request.values;
    var routerElement = request.routerElement;
    var updateHistory = request.updateHistory;

    if (request.isReplacement) {
      var currentLocation = Window.delegate.locationHref;

      _routerStack.entries.remove(currentLocation);

      var preparedSegs = _prepareSegments(protectedSegments(routerElement));

      var encodedValues = fnEncodeKeyValueMap(values);
      if (encodedValues.isNotEmpty) {
        encodedValues = '/$encodedValues';
      }

      var historyEntry = "${preparedSegs.join("/")}/$path$encodedValues";

      var currentPath = _getCurrentPath();

      if (currentPath.isNotEmpty) {
        if (!historyEntry.startsWith('/')) {
          historyEntry = '/$historyEntry';
        }
      }

      Window.delegate.historyReplaceState(
        title: '',
        url: historyEntry,
        rootElement: rootElement,
      );

      var entry = RouterStackEntry(
        path: path,
        values: values,
        routerElement: routerElement,
        location: Window.delegate.locationHref,
      );

      _routerStack.push(entry);
    } else {
      if (updateHistory) {
        var preparedSegs = _prepareSegments(protectedSegments(routerElement));

        var encodedValues = fnEncodeKeyValueMap(values);
        if (encodedValues.isNotEmpty) {
          encodedValues = '/$encodedValues';
        }

        var historyEntry = "${preparedSegs.join("/")}/$path$encodedValues";

        var currentPath = _getCurrentPath();

        if (currentPath.isNotEmpty) {
          if (!historyEntry.startsWith('/')) {
            historyEntry = '/$historyEntry';
          }
        }

        Window.delegate.historyPushState(
          title: '',
          url: historyEntry,
          rootElement: rootElement,
        );

        var routerLink = getRouterLink(routerElement);
        var childRouteObject = routerLink.getChildLinkedOnCurrentRoutePath();

        if (null != childRouteObject) {
          var childRouterCurrentPath = routerElement.getCurrentRoutePath();
          if (childRouterCurrentPath == childRouteObject.segments.last) {
            var childRouterElement = childRouteObject.routerElement;

            childRouterElement.frameworkOnParentPathChange(path);
          }
        }
      }

      var entry = RouterStackEntry(
        path: path,
        values: values,
        routerElement: routerElement,
        location: Window.delegate.locationHref,
      );

      _routerStack.push(entry);
    }
  }

  /// Register logic, actual.
  ///
  void _register(RouterRenderElement routerElement) {
    // try finding a router element in ancestors

    RenderElement? parentElement;
    routerElement.visitAncestorElements((element) {
      if (element is RouterRenderElement) {
        parentElement = element;

        return false;
      }

      return true;
    });

    // if no element in ancestors i.e we're dealing with a root

    if (null == parentElement) {
      _setRouterLink(
        routerElement: routerElement,
        routerLink: RouterLink(
          routerElement: routerElement,
          segments: [_getRoutingPath()],
        ),
      );

      if (DEBUG_BUILD) {
        if (services.debug.routerLogs) {
          print(
            '$RouterRenderElement Registered: #$routerElement at ${[
              _getRoutingPath()
            ]}',
          );
        }
      }

      return;
    }

    // else it's nested router element

    var parentRouterElement = parentElement as RouterRenderElement;

    var parentLinkObject = getRouterLink(parentRouterElement);
    var parentCurrentRoutePath = parentRouterElement.getCurrentRoutePath();

    var segments = [...parentLinkObject.segments, parentCurrentRoutePath];

    // create a link object

    var routerLink = RouterLink(
      routerElement: routerElement,
      segments: segments,
      parentLink: parentLinkObject,
    );

    // register link object

    _setRouterLink(routerElement: routerElement, routerLink: routerLink);

    // establish link with parent

    parentLinkObject.setChildLinkOnCurrentRoutePath(routerLink);

    if (DEBUG_BUILD) {
      if (services.debug.routerLogs) {
        print(
          '$RouterRenderElement Registered: #$routerElement at $segments',
        );
      }
    }
  }
}
