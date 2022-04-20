import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// Widget's meta data that's required to locate a widget in the tree.
///
/// [BuildContext] also contains a reference to its parent's [BuildContext]
/// which further contains its parent reference and so on. This can be used
/// to trace back origin of widget all the way to BigBang(where it all started)
///
class BuildContext {
  /// Widget's key.
  ///
  /// It must be computed if user has provided an explicit key for widget.
  ///
  final Key key;

  /// ID of root HTML element where App(that's enclosing this context) is
  /// mounted.
  ///
  final String appTargetId;

  /// Runtime type of widget class.
  ///
  final String widgetRuntimeType;

  /// Concrete class name.
  ///
  /// It's same as Runtime type if widget is not extending
  /// a another concrete widget class.
  ///
  final String widgetConcreteType;

  /// Widget corresponding Dom tag in use.
  ///
  final DomTag widgetCorrespondingTag;

  final BuildContext? _parent;

  Widget? _widget;

  /*
  |--------------------------------------------------------------------------
  | getters
  |--------------------------------------------------------------------------
  */

  /// reference to context of parent's widget
  ///
  /// accessing will results in error if [widgetRuntimeType] is
  /// [Constants.contextTypeBigBang]
  ///
  BuildContext get parent => _parent!;

  /// Widget is the only mutable property in build context.
  ///
  Widget get widget => _widget!;

  /*
  |--------------------------------------------------------------------------
  | named constructors
  |--------------------------------------------------------------------------
  */

  /// Create build context from parent.
  ///
  BuildContext.fromParent({
    required this.key,
    required this.widgetConcreteType,
    required this.widgetCorrespondingTag,
    required this.widgetRuntimeType,
    required Widget widget,
    required BuildContext parentContext,
  })  : _widget = widget,
        _parent = parentContext,
        appTargetId = parentContext.appTargetId;

  /// Create root context.
  ///
  /// This is required to bootstrap framework.
  ///
  /// Root widget's can have a parent key which points to the place
  /// where it all started(HTML div) but parent is not a widget and
  /// its type is undefined because at the time of big bang there
  /// are no widgets.
  ///
  BuildContext.bigBang(this.key)
      : _widget = null,
        _parent = null,
        appTargetId = key.value,
        widgetCorrespondingTag = DomTag.division,
        widgetConcreteType = Constants.contextTypeBigBang,
        widgetRuntimeType = Constants.contextTypeBigBang;

  /*
  |--------------------------------------------------------------------------
  | methods
  |--------------------------------------------------------------------------
  */

  bool hasParent() => null != _parent;
  bool hasWidget() => null != _widget;

  void rebindWidget(Widget widget) => _widget = widget;

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

  @override
  toString() {
    var cType = _widget?.concreteType;
    var rType = "${_widget?.runtimeType}";

    var pType = cType != rType ? "$rType ($cType)" : rType;

    return "#$key $pType < #${_parent?.key}";
  }
}
