import 'dart:html';

import 'package:rad/src/core/utils.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/structures/build_context.dart';

class Framework {
  static var _isInit = false;
  static var _monotonicId = 0;

  static final _registeredWidgetObjects = <String, WidgetObject>{};

  static init() {
    if (_isInit) {
      throw "Framework aleady initialized.";
    }

    _isInit = true;
  }

  static generateId() {
    _monotonicId++;
    return _monotonicId.toString() + "_" + Utils.random();
  }

  static void addGlobalStyles(String styles) {
    var styleSheet = document.createElement("style");

    styleSheet.innerText = styles;

    if (null != document.head) {
      document.head!.insertBefore(styleSheet, null);
    } else if (null != document.body) {
      document.head!.insertBefore(styleSheet, null);
    } else {
      throw "For Rad to work, your page must have either a head tag or a body."
          "Creating a body(or head) in your page will fix this problem.";
    }
  }

  static WidgetObject? findAncestorOfType<WidgetType>(BuildContext context) {
    if (Constants.keyNotSet == context.key) {
      throw "Part of build context is not ready. This means that context is under construction.";
    }

    var domNode = document
        .getElementById(context.key)
        ?.closest("[data-wtype='" + WidgetType.toString() + "'");

    if (null == domNode) {
      return null;
    }

    var widgetObject = _getWidgetObject(domNode.id);

    if (null == widgetObject) {
      throw "Trying to look up a disposed widget";
    }

    return widgetObject;
  }

  static void buildMultipleChildWidgets({
    required List<Widget> widgets,
    required BuildContext context,
    List<String>? injectStyles,
    append = false,
  }) {
    for (var widget in widgets) {
      buildWidget(
        append: append,
        widget: widget,
        parentContext: context,
        styles: injectStyles,
      );

      // remaining widgets will be appended
      append = true;
    }
  }

  static buildWidget({
    append = false,
    required Widget widget,
    required BuildContext parentContext,
    List<String>? styles,
  }) {
    if (!_isInit) {
      throw "Framework not initialized. If you're building your own AppWidget implementation, make sure to call Framework.init()";
    }

    var renderObject = widget.builder(
      BuildContext(
        key: Constants.keyNotSet,
        parent: parentContext,
        widgetType: widget.type,
        widgetDomTag: widget.tag,
      ),
    );

    if (Constants.keyNotSet == renderObject.context.key) {
      renderObject.context.key = generateId();
    }

    widget.createState(renderObject);

    var widgetObject = WidgetObject(widget: widget, renderObject: renderObject);

    widgetObject.createHtmlElement();

    widgetObject.injectStyles(styles);

    _registerWidgetObject(widgetObject);

    // dispose inner contents if not appending

    if (!append) {
      // if root div

      if (Constants.typeBigBang == widgetObject.context.parent.widgetType) {
        var element = document.getElementById(renderObject.context.parent.key);

        if (null == element) {
          throw "Unable to find target to mount app. Make sure your DOM has element with id #${renderObject.context.parent}";
        }

        element.innerHtml = "";
      } else {
        // else it's in widget tree

        _disposeWidget(
          preserveTarget: true,
          widgetObject: _getWidgetObject(widgetObject.context.parent.key),
        );
      }
    }

    widgetObject.renderObject.beforeMount();

    widgetObject.mount();

    widgetObject.renderObject.afterMount();

    widgetObject.render();
  }

  // internals

  static _tryRebuildingWidgetHavingKey(String widgetKey) {
    var widgetObject = _getWidgetObject(widgetKey);

    if (null == widgetObject) {
      // widget doesn't exists

      return false;
    }

    _disposeWidget(widgetObject: widgetObject, preserveTarget: true);

    widgetObject.renderObject.render(widgetObject);

    return true;
  }

  static _disposeWidget({
    WidgetObject? widgetObject,
    bool preserveTarget = false,
  }) {
    if (null == widgetObject) {
      return;
    }

    if (widgetObject.htmlElement.hasChildNodes()) {
      for (var childHtmlElement in widgetObject.htmlElement.children) {
        _disposeWidget(widgetObject: _getWidgetObject(childHtmlElement.id));
      }
    }

    if (preserveTarget) return;

    // if a body tag

    if (widgetObject.htmlElement == document.body) {
      return;
    }

    // if is not a framework's tag

    if (null == widgetObject.htmlElement.dataset["wtype"]) {
      return;
    }

    // lifecycle hook, about to remove dom node

    widgetObject.renderObject.beforeUnMount();

    // unregister both render and dom node

    _unRegisterWidgetObject(widgetObject);

    // remove dom node

    widgetObject.htmlElement.remove();
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
