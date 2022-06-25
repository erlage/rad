// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/options/router_options.dart';
import 'package:rad/src/core/interface/window/window.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/router/navigator_link.dart';
import 'package:rad/src/core/services/router/router_request.dart';
import 'package:rad/src/core/services/router/router_stack.dart';
import 'package:rad/src/core/services/router/router_stack_entry.dart';
import 'package:rad/src/widgets/navigator.dart';

/// Router service.
///
@internal
class RouterService extends Service {
  final RouterOptions options;

  /// Registered navigators.
  ///
  /// navigator render element: navigator link information
  ///
  final _links = <NavigatorRenderElement, NavigatorLink>{};

  final _routerStack = RouterStack();

  /// Router request stream.
  ///
  /// Router services uses this stream, internally, to linearlize all calls
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
    _routerRequestsStream?.stream.listen(_proccessRouterRequest);
  }

  @override
  stopService() {
    _routerRequestsStream?.close();

    _links.clear();
    _routerStack.clear();

    Window.delegate.removePopStateListener(rootElement);
  }

  /// Register navigator's state.
  ///
  void register(NavigatorRenderElement navigator) {
    if (_links.containsKey(navigator)) {
      return services.debug.exception(Constants.coreError);
    }

    _register(navigator);
  }

  void unRegister(NavigatorRenderElement navigator) {
    _links.remove(navigator)?.disband();

    _routerStack.remove(navigator);
  }

  /// Push page entry.
  ///
  void pushEntry({
    required String name,
    required Map<String, String> values,
    required NavigatorRenderElement navigator,
    required bool updateHistory,
  }) {
    _routerRequestsStream?.sink.add(
      RouterRequest(
        name: name,
        values: values,
        navigator: navigator,
        updateHistory: updateHistory,
        isReplacement: false,
      ),
    );
  }

  /// Push page entry as replacement.
  ///
  /// This allows nested navigators to do initial linking.
  ///
  void pushReplacement({
    required String name,
    required Map<String, String> values,
    required NavigatorRenderElement navigator,
  }) {
    _routerRequestsStream?.sink.add(
      RouterRequest(
        name: name,
        values: values,
        navigator: navigator,
        isReplacement: true,
        updateHistory: true, // irrelevant if is replacement
      ),
    );
  }

  /// Mannually dispatch a back action.
  ///
  void dispatchBackAction() {
    Window.delegate.historyBack(rootElement: rootElement);
  }

  /// Get current path based on Navigator's access.
  ///
  /// Returns empty string, if matches nothing. Navigators should display
  /// default page when [getPath] returns empty string.
  ///
  String getPath(NavigatorRenderElement navigator) {
    var stateObject = navigator.state;

    var segments = accessibleSegments(navigator);

    var matchedPathSegment = '';

    for (final segment in segments) {
      if (stateObject.pathToRouteMap.containsKey(segment)) {
        matchedPathSegment = segment;

        break;
      }
    }

    if (services.debug.routerLogs) {
      print(
        'Navigator(#$navigator) matched: '
        "'$matchedPathSegment' from '${segments.join("/")} < "
        " (${_getCurrentSegments()})'",
      );
    }

    return matchedPathSegment;
  }

  /// Get value following the provided segment in URL.
  ///
  String getValue(NavigatorRenderElement navigator, String segment) {
    var encodedSegment = fnEncodeValue(segment);

    var path = accessibleSegments(navigator).join('/');

    // try to find a value that's following the provided segment in path

    var match = RegExp(encodedSegment + r'\/+([^\/]+)').firstMatch(path);

    return (null == match) ? '' : fnDecodeValue(match.group(1) ?? '');
  }

  void ensureNavigatorIsVisible(NavigatorLink linkObject) {
    var parentLinkObject = linkObject.parentLink;

    if (null != parentLinkObject) {
      ensureNavigatorIsVisible(parentLinkObject);

      var parentState = parentLinkObject.navigator.state;
      var parentRouteNameToOpen = linkObject.segments.last;

      parentState.open(name: parentRouteNameToOpen, updateHistory: false);
    }
  }

  /// Part of path(Window.delegate.locationPathName) that navigator with
  /// [navigator] can access.
  ///
  List<String> accessibleSegments(NavigatorRenderElement navigator) {
    var linkObject = _links[navigator];
    var currentSegments = _getCurrentSegments();

    if (null == linkObject) {
      services.debug.exception(Constants.coreError);

      return [];
    }

    // if root navigator, all segments are available

    if (null == linkObject.parentLink) {
      return currentSegments;
    }

    // else limit part of path that's visible to current navigator

    var matcher = '';

    if (linkObject.segments.length < 3) {
      matcher = r'^\/*.*(' + linkObject.segments.last + r'.*)';
    } else {
      matcher = r'^\/*' +
          linkObject.segments[1] +
          r'.*(' +
          linkObject.segments.last +
          r'.*)';
    }

    var path = currentSegments.join('/');

    var match = RegExp(matcher).firstMatch(path);

    if (null == match) return [];

    var group = match.group(1);

    if (null == group) return [];

    return group.split('/');
  }

  /// Part of path(Window.delegate.locationPathName) that navigator with
  /// [navigator] can't change.
  ///
  /// Note that, navigator still can access **some parts** of protected
  /// segements using [accessibleSegments]
  ///
  List<String> protectedSegments(NavigatorRenderElement navigator) {
    var stateObject = navigator.state;
    var linkObject = _links[navigator];

    if (null == linkObject) {
      services.debug.exception(Constants.coreError);

      return [];
    }

    // if root navigator, no segments are protected

    if (null == linkObject.parentLink) {
      return _getRoutingPath().split('/');
    }

    // else find protected part

    var matcher = '';

    var matchRoutes = stateObject.nameToPathMap.values.join(r'|\/');

    if (linkObject.segments.length < 3) {
      matcher = r'(^\/*.*' +
          linkObject.segments.last +
          r'.*(?=\/' +
          matchRoutes +
          r'))';
    } else {
      matcher = r'(^\/*' +
          linkObject.segments[1] +
          r'.*' +
          linkObject.segments.last +
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

      if (services.debug.routerLogs) {
        print('Router: onPopState: location: $location');
      }

      // find or manage user history entry

      var entry = _routerStack.get(location);

      // user is traversing passive history.

      if (null == entry) {
        //
        // passive history is 'state' that browser kept after user had left the
        // site. this is to allow user navigate between sites using back button.
        //
        // since at this point, our state is lost, our entries are lost too.
        // and reloading window will build the correct interface.

        if (services.debug.routerLogs) {
          print('Router: onPopState: entry doesnt exists: $entry');
        }

        Window.delegate.locationReload();

        // for active history, our implementation is ready, see below.

      } else {
        var navigatorState = entry.navigator.state;
        var linkObject = _links[entry.navigator]!;

        ensureNavigatorIsVisible(linkObject);

        if (services.debug.routerLogs) {
          print('Router: onPopState: open: ${entry.name}');
        }

        navigatorState.open(
          name: entry.name,
          values: entry.values,
          updateHistory: false,
        );
      }
    } catch (e) {
      // reload window if anything goes wrong

      Window.delegate.locationReload();
    }
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

  void _proccessRouterRequest(RouterRequest request) {
    var name = request.name;
    var values = request.values;
    var navigator = request.navigator;
    var updateHistory = request.updateHistory;

    if (request.isReplacement) {
      var currentLocation = Window.delegate.locationHref;

      _routerStack.entries.remove(currentLocation);

      var preparedSegs = _prepareSegments(protectedSegments(navigator));

      var encodedValues = fnEncodeKeyValueMap(values);
      if (encodedValues.isNotEmpty) {
        encodedValues = '/$encodedValues';
      }

      var historyEntry = "${preparedSegs.join("/")}/$name$encodedValues";

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
        name: name,
        values: values,
        navigator: navigator,
        location: Window.delegate.locationHref,
      );

      _routerStack.push(entry);
    } else {
      if (updateHistory) {
        var preparedSegs = _prepareSegments(protectedSegments(navigator));

        var encodedValues = fnEncodeKeyValueMap(values);
        if (encodedValues.isNotEmpty) {
          encodedValues = '/$encodedValues';
        }

        var historyEntry = "${preparedSegs.join("/")}/$name$encodedValues";

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

        var state = navigator.state;
        var linkObject = _links[navigator];
        var childRouteObject = linkObject?.childLinkedOnCurrentRoute;

        if (null != childRouteObject) {
          if (state.currentRouteName == childRouteObject.segments.last) {
            var childState = childRouteObject.navigator.state;

            childState.frameworkOnParentRouteChange(name);
          }
        }
      }

      var entry = RouterStackEntry(
        name: name,
        values: values,
        navigator: navigator,
        location: Window.delegate.locationHref,
      );

      _routerStack.push(entry);
    }
  }

  /// Register logic, actual.
  ///
  void _register(NavigatorRenderElement navigator) {
    var routes = (navigator.widget as Navigator).routes;

    var parentNavigator = navigator
        .findAncestorRenderElementOfExactType<NavigatorRenderElement>();

    // if no Navigator in ancestors i.e we're dealing with a root navigator

    if (null == parentNavigator) {
      _links[navigator] = NavigatorLink(
        navigator: navigator,
        routes: routes,
        segments: [_getRoutingPath()],
      );

      if (services.debug.routerLogs) {
        print(
          'Navigator Registered: #$navigator at ${[_getRoutingPath()]}',
        );
      }

      return;
    }

    // else it's nested navigator

    var parentState = parentNavigator.state;
    var parentLinkObject = _links[parentNavigator];

    if (null == parentLinkObject) {
      return services.debug.exception(Constants.coreError);
    }

    var segments = [...parentLinkObject.segments, parentState.currentRouteName];

    // create a link object

    var linkObject = NavigatorLink(
      navigator: navigator,
      routes: routes,
      segments: segments,
      parentLink: parentLinkObject,
    );

    // register link object

    _links[navigator] = linkObject;

    // establish link with parent

    parentLinkObject.establishChildLink(linkObject);

    if (services.debug.routerLogs) {
      print('Navigator Registered: #$navigator at $segments');
    }
  }
}
