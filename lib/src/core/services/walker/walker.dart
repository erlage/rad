import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// Tree Walker/Registry for Dom/Widget Objects.
///
class Walker extends Service {
  final WalkerOptions options;

  final _registeredWidgetObjects = <String, WidgetObject>{};

  Walker(BuildContext context, this.options) : super(context);

  @override
  startService() {
    _registeredWidgetObjects.clear();
  }

  @override
  stopService() {
    _registeredWidgetObjects.clear();
  }

  void registerWidgetObject(WidgetObject widgetObject) {
    var widgetKey = widgetObject.renderObject.context.key.value;

    if (services.debug.additionalChecks) {
      if (_registeredWidgetObjects.containsKey(widgetKey)) {
        return services.debug.exception(
          "Key $widgetKey already exists."
          "\n\nThis usually happens in two scenarios,"
          "\n\n1. When you have duplicate keys in your code."
          "\n\nor\n\n2. When you've two adjacent widgets of same type and one"
          " of them is optional.\n\nCorrect way to fix (2): Use explicit keys"
          " on one of the widgets that are of same type.",
        );
      }
    }

    _registeredWidgetObjects[widgetKey] = widgetObject;
  }

  WidgetObject? getWidgetObject(String widgetKey) {
    return _registeredWidgetObjects[widgetKey];
  }

  void unRegisterWidgetObject(WidgetObject widgetObject) {
    var widgetKey = widgetObject.renderObject.context.key.value;

    _registeredWidgetObjects.remove(widgetKey);
  }

  /// Return all registered widget keys.
  ///
  List<String> dumpWidgetKeys() {
    return _registeredWidgetObjects.keys.toList();
  }

  /*
  |--------------------------------------------------------------------------
  | Misc methods
  |--------------------------------------------------------------------------
  */

  /// Find widget object in ancestors using selector.
  ///
  WidgetObject? findAncestorWidgetObjectFromSelector(
    String selector,
    BuildContext context,
  ) {
    if (Constants.contextKeyNotSet == context.key) {
      services.debug.exception(
        "Part of build context is not ready. This means that context is under"
        " construction.",
      );

      return null;
    }

    var domNode = document.getElementById(context.key.value)?.parent?.closest(
          selector,
        );

    if (null == domNode) {
      return null;
    }

    return getWidgetObject(domNode.id);
  }

  T? findAncestorWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrRuntimeType}='$T']";

    var widgetObject = findAncestorWidgetObjectFromSelector(selector, context);

    if (null != widgetObject) {
      return widgetObject.widget as T;
    }

    return null;
  }

  T? findAncestorStateOfType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrStateType}='$T']";

    var widgetObject = findAncestorWidgetObjectFromSelector(selector, context);

    if (null != widgetObject) {
      var renderObject = widgetObject.renderObject;

      renderObject as StatefulWidgetRenderObject;

      return (renderObject).state as T;
    }

    return null;
  }

  WidgetObject? findAncestorWidgetObjectOfType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrRuntimeType}='$T']";

    return findAncestorWidgetObjectFromSelector(selector, context);
  }

  WidgetObject? findAncestorRenderObjectOfClass<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrWidgetType}='$T']";

    return findAncestorWidgetObjectFromSelector(selector, context);
  }

  T? dependOnInheritedWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrRuntimeType}='$T']"
        "[data-${Constants.attrWidgetType}='$InheritedWidget']";

    var widgetObject = findAncestorWidgetObjectFromSelector(selector, context);

    if (null != widgetObject) {
      var renderObject = widgetObject.renderObject;

      renderObject as InheritedWidgetRenderObject;

      renderObject.addDependent(context);

      return widgetObject.widget as T;
    }

    return null;
  }
}
