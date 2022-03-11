import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// Widget's meta data that's required to locate a widget in the tree.
///
/// [BuildContext] also contains a reference to its parent's [BuildContext]
/// which further contains its parent reference and so on. This can be used
/// to trace back origin of widget all the way to BigBang(where it all started)
///
class BuildContext {
  final String key;

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

  /// reference to context of parent's widget
  ///
  /// accessing will results in error if [widgetRuntimeType] is [System.contextTypeBigBang]
  ///
  BuildContext get parent => _parent!;
  final BuildContext? _parent;

  /// Widget is the only mutable property in build context.
  ///
  Widget get widget => _widget!;
  Widget? _widget;
  void rebindWidget(Widget widget) => _widget = widget;

  bool hasParent() => null != _parent;
  bool hasWidget() => null != _widget;

  BuildContext({
    required this.key,
    required this.widgetConcreteType,
    required this.widgetCorrespondingTag,
    required this.widgetRuntimeType,
    required Widget widget,
    required BuildContext parent,
  })  : _widget = widget,
        _parent = parent;

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
        widgetCorrespondingTag = DomTag.div,
        widgetConcreteType = System.contextTypeBigBang,
        widgetRuntimeType = System.contextTypeBigBang;

  /// Returns the nearest ancestor widget of the given type `T`, which must be the
  /// type of a concrete [Widget] subclass.
  ///
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    return Framework.findAncestorWidgetOfExactType<T>(this);
  }

  /// Returns the [State] object of the nearest ancestor [StatefulWidget] widget
  /// that is an instance of the given type `T`.
  ///
  T? findAncestorStateOfType<T extends State>() {
    return Framework.findAncestorStateOfType<T>(this);
  }

  @override
  String toString() {
    var cType = widget.concreteType;
    var rType = "${widget.runtimeType}";

    var pType = cType != rType ? "$rType ($cType)" : rType;

    return "#$key $pType < #${parent.key}";
  }
}
