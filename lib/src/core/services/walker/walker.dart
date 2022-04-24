import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// Tree Walker/Registry for Dom/Render Objects.
///
class Walker extends Service {
  final WalkerOptions options;

  final _registeredRenderObjects = <String, RenderObject>{};

  Walker(BuildContext context, this.options) : super(context);

  @override
  startService() {
    _registeredRenderObjects.clear();
  }

  @override
  stopService() {
    _registeredRenderObjects.clear();
  }

  void registerRenderObject(RenderObject renderObject) {
    var widgetKey = renderObject.context.key.value;

    if (services.debug.additionalChecks) {
      if (_registeredRenderObjects.containsKey(widgetKey)) {
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

    _registeredRenderObjects[widgetKey] = renderObject;
  }

  RenderObject? getRenderObject(String widgetKey) {
    return _registeredRenderObjects[widgetKey];
  }

  void unRegisterRenderObject(RenderObject renderObject) {
    var widgetKey = renderObject.context.key.value;

    _registeredRenderObjects.remove(widgetKey);
  }

  /// Return all registered widget keys.
  ///
  List<String> dumpWidgetKeys() {
    return _registeredRenderObjects.keys.toList();
  }

  /*
  |--------------------------------------------------------------------------
  | Misc methods
  |--------------------------------------------------------------------------
  */

  /// Find widget object in ancestors using selector.
  ///
  RenderObject? findAncestorRenderObjectFromSelector(
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

    return getRenderObject(domNode.id);
  }

  T? findAncestorWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrRuntimeType}='$T']";

    var renderObject = findAncestorRenderObjectFromSelector(selector, context);

    if (null != renderObject) {
      return renderObject.context.widget as T;
    }

    return null;
  }

  T? findAncestorStateOfType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrStateType}='$T']";

    var renderObject = findAncestorRenderObjectFromSelector(selector, context);

    if (null != renderObject) {
      renderObject as StatefulWidgetRenderObject;

      return (renderObject).state as T;
    }

    return null;
  }

  RenderObject? findAncestorRenderObjectOfType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrRuntimeType}='$T']";

    return findAncestorRenderObjectFromSelector(selector, context);
  }

  RenderObject? findAncestorRenderObjectOfClass<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrConcreteType}='$T']";

    return findAncestorRenderObjectFromSelector(selector, context);
  }

  T? dependOnInheritedWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${Constants.attrRuntimeType}='$T']"
        "[data-${Constants.attrConcreteType}='$InheritedWidget']";

    var renderObject = findAncestorRenderObjectFromSelector(selector, context);

    if (null != renderObject) {
      renderObject as InheritedWidgetRenderObject;

      renderObject.addDependent(context);

      return renderObject.context.widget as T;
    }

    return null;
  }
}
