import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/objects/debug_options.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/update_object.dart';
import 'package:rad/src/core/structures/build_context.dart';

class Framework {
  static var _isInit = false;

  static final _registeredWidgetObjects = <String, WidgetObject>{};

  /// Initialize framework.
  ///
  /// It's AppWidget job to call this method as first task. Initialization
  /// process will initialize other important components such as Router.
  ///
  static init({
    required String routingPath,
    DebugOptions? debugOptions,
  }) {
    if (_isInit) {
      throw "Framework aleady initialized.";
    }

    debugOptions ??= DebugOptions(
      routerLogs: false,
      frameworkLogs: false,
      developmentMode: false,
    );

    Debug.update(debugOptions);

    Router.init(routingPath);

    _isInit = true;
  }

  /// Inject styles into DOM.
  ///
  static void addGlobalStyles(String styles, [String? flagLogEntry]) {
    // create dom element

    var styleSheet = document.createElement("style");

    styleSheet.innerText = styles;

    // insert styles where possible

    if (null != document.head) {
      document.head!.insertBefore(styleSheet, null);
    } else if (null != document.body) {
      document.head!.insertBefore(styleSheet, null);
    } else {
      throw "For Rad to work, your page must have either a head tag or a body."
          "Creating a body(or head) in your page will fix this problem.";
    }

    // log if flag is on

    if (Debug.frameworkLogs) {
      if (null != flagLogEntry) {
        print("Styles injected: $flagLogEntry");
      }
    }
  }

  static WidgetObject? findAncestorOfType<WidgetType>(BuildContext context) {
    // ensure context is ready for processing.
    // this happens when user .of(context) is called inside a constructor.

    if (System.keyNotSet == context.key) {
      throw "Part of build context is not ready. This means that context is under construction.";
    }

    // find dom node having provided 'widget type' in ancestors

    var match = "[data-wtype='$WidgetType']";

    var domNode = document.getElementById(context.key)?.closest(match);

    if (null == domNode) {
      return null;
    }

    // found. return corresponding widget's object.

    return _getWidgetObject(domNode.id);
  }

  /// Build children under given context.
  ///
  static buildChildren({
    // widgets to build
    required List<Widget> widgets,
    required BuildContext parentContext,
    ElementCallback? elementCallback,
    //
    // -- flags --
    //
    flagCleanParentContents = true,
    //
  }) {
    if (!_isInit) {
      throw "Framework not initialized. If you're building your own AppWidget implementation, make sure to call Framework.init()";
    }

    for (var widget in widgets) {
      // generate key if not set

      var widgetKey = System.keyNotSet == widget.initialKey
          ? Utils.generateWidgetKey()
          : widget.initialKey;

      // create build context

      var buildContext = BuildContext(
        key: widgetKey,
        parent: parentContext,
        widgetType: widget.type,
        widgetDomTag: widget.tag,
        widgetClassName: widget.runtimeType.toString(),
      );
      widget.onContextCreate(buildContext);

      // create render object

      var renderObject = widget.createRenderObject(buildContext);
      widget.onRenderObjectCreate(renderObject);

      if (Debug.widgetLogs) {
        print("Build widget: ${widget.type} #${buildContext.key}");
      }

      // create widget object

      var widgetObject = WidgetObject(
        widget: widget,
        renderObject: renderObject,
      );

      // create dom element(node)

      widgetObject.createElement();

      if (null != elementCallback) {
        elementCallback(widgetObject.element);
      }

      _registerWidgetObject(widgetObject);

      // dispose inner contents if flag is on

      if (flagCleanParentContents) {
        var isRoot =
            System.typeBigBang != widgetObject.context.parent.widgetType;

        if (isRoot) {
          var element = document.getElementById(
            renderObject.context.parent.key,
          );

          if (null == element) {
            throw "Unable to find target to mount app. Make sure your DOM has element with id #${renderObject.context.parent}";
          }

          element.innerHtml = "";
        } else {
          _disposeWidget(
            preserveTarget: true,
            widgetObject: _getWidgetObject(widgetObject.context.parent.key),
          );
        }
      }

      widgetObject.renderObject.beforeMount();

      widgetObject.mount();

      widgetObject.renderObject.afterMount();

      widgetObject.build();

      // unset clean flag.
      // because remaining childs must not remove newly added childs

      flagCleanParentContents = false;
    }
  }

  /// Update childrens under provided context.
  ///
  static updateChildren({
    // widgets to build
    required List<Widget> widgets,
    required BuildContext parentContext,
    ElementCallback? elementCallback,
    //
    // -- flags for special nodes --
    //
    flagHideObsoluteChildren = false,
    flagDisposeObsoluteChildren = true,
    //
    // -- flags for widgets that aren't found in tree --
    //
    flagAddIfNotFound = false,
    //
    // -- hard flags, can cause subtree rebuilds --
    //
    flagTolerateMissingChildren = false,
    flagTolerateChildrenCountMisMatch = false,
    //
  }) {
    if (!_isInit) {
      throw "Framework not initialized. If you're building your own AppWidget implementation, make sure to call Framework.init()";
    }

    // convenience function that dispatches complete rebuild.

    void dispatchCompleteRebuild() {
      buildChildren(
        widgets: widgets,
        parentContext: parentContext,
        elementCallback: elementCallback,
      );
    }

    var parent = document.getElementById(parentContext.key);

    if (null == parent) {
      return dispatchCompleteRebuild();
    }

    // ensure children count match if flag is on

    if (!flagTolerateChildrenCountMisMatch) {
      if (parent.children.length != widgets.length) {
        return dispatchCompleteRebuild();
      }
    }

    // list of updates  {Node index}: existing {WidgetObject}

    var updates = <String, UpdateObject>{};

    // prepare updates

    widgetLoop:
    for (var widget in widgets) {
      for (var child in parent.children) {
        var alreadySelected = updates.containsKey(child.id);

        if (!alreadySelected) {
          var hasSameType = child.dataset.isNotEmpty &&
              widget.runtimeType.toString() == child.dataset[System.attrClass];

          if (hasSameType) {
            updates[child.id] = UpdateObject(widget, child.id);

            continue widgetLoop;
          }
        }
      }

      // child is missing

      if (!flagTolerateChildrenCountMisMatch) {
        return dispatchCompleteRebuild();
      }

      // if flag is on for missing childs

      if (flagAddIfNotFound) {
        updates["_${Utils.generateMonotonicId()}"] = UpdateObject(widget, null);
      }
    }

    // publish widget updates

    updates.forEach((elementId, updateObject) {
      if (null != updateObject.existingElementId) {
        var existingWidgetObject = _getWidgetObject(elementId);

        // if found

        if (null != existingWidgetObject) {
          // get updated render object
          var renderObject = updateObject.widget.createRenderObject(
            existingWidgetObject.context,
          );

          // if there's element callback

          if (null != elementCallback) {
            elementCallback(existingWidgetObject.element);
          }

          // publish update

          return existingWidgetObject.renderObject.update(
            existingWidgetObject,
            renderObject,
          );
        } else {
          if (!flagTolerateChildrenCountMisMatch) {
            return dispatchCompleteRebuild();
          }
        }
      } else {
        if (flagAddIfNotFound) {
          buildChildren(
            widgets: [updateObject.widget],
            parentContext: parentContext,
            elementCallback: elementCallback,
          );
        }
      }
    });

    // deal with obsolute nodes

    for (var childElement in parent.children) {
      if (!updates.containsKey(childElement.id)) {
        if (flagDisposeObsoluteChildren) {
          _disposeWidget(
            widgetObject: _getWidgetObject(childElement.id),
            preserveTarget: false,
          );
        } else if (flagHideObsoluteChildren) {
          _hideElement(childElement);
        }
      }
    }
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  /// Dispose widgets and its child widgets.
  ///
  static _disposeWidget({
    WidgetObject? widgetObject,
    bool preserveTarget = false,
  }) {
    if (null == widgetObject) {
      return;
    }

    // cascade dispose to its childs first

    if (widgetObject.element.hasChildNodes()) {
      for (var childElement in widgetObject.element.children) {
        _disposeWidget(widgetObject: _getWidgetObject(childElement.id));
      }
    }

    if (preserveTarget) return;

    // nothing to dispose if its a body tag

    if (widgetObject.element == document.body) {
      return;
    }

    // nothing to dispose if its not a widget

    if (null == widgetObject.element.dataset[System.attrType]) {
      return;
    }

    widgetObject.renderObject.beforeUnMount();

    _unRegisterWidgetObject(widgetObject);

    widgetObject.element.remove();
  }

  static _hideElement(Element element) {
    element.classes.add('rad-hidden');
  }

  static WidgetObject? _getWidgetObject(String widgetKey) {
    return _registeredWidgetObjects[widgetKey];
  }

  static void _registerWidgetObject(WidgetObject widgetObject) {
    _registeredWidgetObjects[widgetObject.context.key] = widgetObject;
  }

  static void _unRegisterWidgetObject(WidgetObject widgetObject) {
    _registeredWidgetObjects.remove(widgetObject.context.key);
  }
}
