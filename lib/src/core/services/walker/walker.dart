import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
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
    var widgetKey = widgetObject.context.key.value;

    if (services.debug.additionalChecks) {
      if (_registeredWidgetObjects.containsKey(widgetKey)) {
        return services.debug.exception(
          'Key $widgetKey already exists.'
          '\n\nThis usually happens in two scenarios,'
          '\n\n1. When you have duplicate keys in your code.'
          "\n\nor\n\n2. When you've two adjacent widgets of same type and one"
          ' of them is optional.\n\nCorrect way to fix (2): Use explicit keys'
          ' on one of the widgets that are of same type.',
        );
      }
    }

    _registeredWidgetObjects[widgetKey] = widgetObject;
  }

  WidgetObject? getWidgetObject(BuildContext context) {
    return getWidgetObjectUsingKey(context.key.value);
  }

  WidgetObject? getWidgetObjectUsingKey(String? key) {
    return _registeredWidgetObjects[key];
  }

  void unRegisterWidgetObject(WidgetObject widgetObject) {
    var widgetKey = widgetObject.renderObject.context.key.value;

    _registeredWidgetObjects.remove(widgetKey);
  }

  /// Return all registered widget objects.
  ///
  List<WidgetObject> dumpWidgetObjects() {
    return _registeredWidgetObjects.values.toList();
  }

  /*
  |--------------------------------------------------------------------------
  | Misc methods
  |--------------------------------------------------------------------------
  */

  /// Find widget's corresponding element.
  ///
  Element findElement(BuildContext context) {
    var widgetObject = getWidgetObject(context);

    if (null == widgetObject) {
      services.debug.exception(Constants.coreError);
    }

    widgetObject as WidgetObject;

    return widgetObject.element;
  }

  /// Returns the nearest ancestor widget of the given type [T], which must be
  /// the type of a concrete [Widget] subclass.
  ///
  T? findAncestorWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var widgetObject = getWidgetObject(context);

    if (null != widgetObject) {
      var foundWidgetObject = _findWidgetObjectInAncestors(
        widgetObject: widgetObject,
        matchWidgetType: '$T',
      );

      if (null != foundWidgetObject) {
        return foundWidgetObject.widget as T;
      }
    }

    return null;
  }

  /// Returns the State object of the nearest ancestor StatefulWidget widget
  /// that is an instance of the given type [T].
  ///
  T? findAncestorStateOfType<T>(
    BuildContext context,
  ) {
    var widgetObject = getWidgetObject(context);

    if (null != widgetObject) {
      var foundWidgetObject = _findWidgetObjectInAncestors(
        widgetObject: widgetObject,
        matchStateType: '$T',
      );

      if (null != foundWidgetObject) {
        var foundRenderObject = foundWidgetObject.renderObject;

        foundRenderObject as StatefulWidgetRenderObject;

        return (foundRenderObject).state as T;
      }
    }

    return null;
  }

  /// Obtains the nearest widget of the given type [T], which must be the type
  /// of a concrete [InheritedWidget] subclass, and registers this build context
  /// with that widget such that when that widget changes (or a new widget of
  /// that type is introduced, or the widget goes away), this build context is
  /// rebuilt so that it can obtain new values from that widget.
  ///
  T? dependOnInheritedWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var widgetObject = getWidgetObject(context);

    if (null != widgetObject) {
      var foundWidgetObject = _findWidgetObjectInAncestors(
        widgetObject: widgetObject,
        matchWidgetType: '$InheritedWidget',
        matchRuntimeType: '$T',
      );

      if (null != foundWidgetObject) {
        var foundRenderObject = foundWidgetObject.renderObject;

        foundRenderObject as InheritedWidgetRenderObject;

        foundRenderObject.addDependent(context);

        return foundWidgetObject.widget as T;
      }
    }

    return null;
  }

  /// Find widget object of a widget in ancestors.
  ///
  WidgetObject? findAncestorWidgetObject<T>(
    BuildContext context,
  ) {
    var widgetObject = getWidgetObject(context);

    if (null == widgetObject) {
      return null;
    }

    return _findWidgetObjectInAncestors(
      widgetObject: widgetObject,
      matchRuntimeType: '$T',
    );
  }

  WidgetObject? _findWidgetObjectInAncestors({
    required WidgetObject widgetObject,
    String? matchStateType,
    String? matchWidgetType,
    String? matchRuntimeType,
  }) {
    var widgetRuntimeType = widgetObject.context.widgetRuntimeType;

    // 1. If root widget, then there's no parent to check

    if (Constants.contextTypeBigBang == widgetRuntimeType) {
      return null;
    }

    var parentWidgetObject = getWidgetObject(
      widgetObject.context.parent,
    );

    // 2. If parent widget doesn't exists for some reason

    if (null == parentWidgetObject) {
      return null;
    }

    // 3. Assume parent widget is matched

    var isStateTypeMatched = true;
    var isWidgetTypeMatched = true;
    var isRuntimeTypeMatched = true;

    // 4. Prepare widget data

    var parentWidgetType = parentWidgetObject.context.widgetType;
    var parentWidgetRuntimeType = parentWidgetObject.context.widgetRuntimeType;

    // 5. If widget type has to be matched

    if (null != matchWidgetType) {
      isWidgetTypeMatched = matchWidgetType == parentWidgetType;
    }

    // 6. If runtime type has to be matched

    if (null != matchRuntimeType) {
      isRuntimeTypeMatched = matchRuntimeType == parentWidgetRuntimeType;
    }

    // 7. If state type has to be matched (only for StatefulWidgets)

    if (null != matchStateType) {
      var parentRenderObject = parentWidgetObject.renderObject;

      if (parentRenderObject is StatefulWidgetRenderObject) {
        var parentStateType = '${parentRenderObject.state.runtimeType}';

        isStateTypeMatched = matchStateType == parentStateType;
      } else {
        isStateTypeMatched = false;
      }
    }

    // 8. Check match results, if matched return widget object

    if (isStateTypeMatched && isWidgetTypeMatched && isRuntimeTypeMatched) {
      return parentWidgetObject;
    }

    // 9. Else try matching parent

    return _findWidgetObjectInAncestors(
      widgetObject: parentWidgetObject,
      matchStateType: matchStateType,
      matchWidgetType: matchWidgetType,
      matchRuntimeType: matchRuntimeType,
    );
  }
}
