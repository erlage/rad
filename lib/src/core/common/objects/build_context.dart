import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';
import 'package:rad/src/core/services/services_registry.dart';

/// A handle to the location of a widget in the widget tree.
///
class BuildContext {
  /// Widget's key.
  ///
  /// Every widget's key must be unique. If user provides a non global key,
  /// framework must compute a global key from provided key.
  ///
  final GlobalKey key;

  final String appTargetId;

  final String widgetRuntimeType;

  final String widgetConcreteType;

  final DomTag widgetCorrespondingTag;

  final HtmlElement element;

  final BuildContext? _parent;

  bool _isMounted;
  Widget? _widget;
  WidgetConfiguration? _configuration;

  bool get isMounted => _isMounted;
  Widget get widget => _widget!;
  WidgetConfiguration get configuration => _configuration!;

  /// Reference to widget's parent context.
  ///
  /// Accessing it will results in error if [widgetRuntimeType] is
  /// [Constants.contextTypeBigBang]
  ///
  BuildContext get parent => _parent!;

  /*
  |--------------------------------------------------------------------------
  | named constructors
  |--------------------------------------------------------------------------
  */

  /// Create build context from parent.
  ///
  BuildContext.fromParent({
    required this.key,
    required Widget widget,
    required BuildContext parentContext,
  })  :
        // properties from parent

        _parent = parentContext,
        appTargetId = parentContext.appTargetId,

        // widget instance

        _isMounted = false,
        _widget = widget,

        // widget type information

        widgetConcreteType = widget.widgetType,
        widgetRuntimeType = "${widget.runtimeType}",
        widgetCorrespondingTag = widget.correspondingTag,

        // widget configuration

        _configuration = widget.createConfiguration(),

        // widget element

        element = (document.createElement(
          fnMapDomTag(widget.correspondingTag),
        ) as HtmlElement)
          ..id = key.value
          ..dataset[Constants.attrWidgetType] = widget.widgetType
          ..dataset[Constants.attrRuntimeType] = "${widget.runtimeType}";

  /// Create app context(root).
  ///
  BuildContext.bigBang(this.key)
      : _widget = null,
        _parent = null,
        _isMounted = false,
        _configuration = const WidgetConfiguration(),
        appTargetId = key.value,
        widgetCorrespondingTag = DomTag.division,
        widgetConcreteType = Constants.contextTypeBigBang,
        widgetRuntimeType = Constants.contextTypeBigBang,
        element = document.getElementById(key.value) as HtmlElement;

  /*
  |--------------------------------------------------------------------------
  | methods
  |--------------------------------------------------------------------------
  */

  /// Returns the nearest ancestor widget of the given type `T`, which must be
  /// the type of a concrete [Widget] subclass.
  ///
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    var walkerService = ServicesRegistry.instance.getWalker(this);

    return walkerService.findAncestorWidgetOfExactType<T>(this);
  }

  /// Returns the [State] object of the nearest ancestor [StatefulWidget] widget
  /// that is an instance of the given type `T`.
  ///
  T? findAncestorStateOfType<T extends State>() {
    var walkerService = ServicesRegistry.instance.getWalker(this);

    return walkerService.findAncestorStateOfType<T>(this);
  }

  /// Obtains the nearest widget of the given type `T`, which must be the type
  /// of a concrete [InheritedWidget] subclass, and registers this build context
  /// with that widget such that when that widget changes (or a new widget of
  /// that type is introduced, or the widget goes away), this build context is
  /// rebuilt so that it can obtain new values from that widget.
  ///
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() {
    var walkerService = ServicesRegistry.instance.getWalker(this);

    return walkerService.dependOnInheritedWidgetOfExactType<T>(this);
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  void frameworkRebindWidget(Widget widget) {
    _widget = widget;
  }

  void frameworkRebindConfiguration(WidgetConfiguration configuration) {
    _configuration = configuration;
  }

  void frameworkSetIsMounted(bool toSet) {
    _isMounted = toSet;
  }

  @override
  toString() {
    var wType = _widget?.widgetType;
    var rType = "${_widget?.runtimeType}";

    var pType = wType != rType ? "$rType ($wType)" : rType;

    return "#$key $pType < #${_parent?.key}";
  }
}
