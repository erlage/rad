import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Widget's meta data that's required to locate a widget in the tree.
///
/// [BuildContext] also contains a reference to its parent's [BuildContext]
/// which further contains its parent reference and so on. This can be used
/// to trace back origin of widget all the way to BigBang(where it all started)
///
class BuildContext {
  final String id;

  final String widgetType;
  final DomTag widgetDomTag;
  final String widgetClassName;

  /// reference to context of parent's widget
  ///
  /// accessing will results in error if [widgetClassName] is [System.typeBigBang]
  ///
  BuildContext get parent => _parent!;
  final BuildContext? _parent;

  /// Widget is the only mutable property in build context.
  ///
  Widget get widget => _widget!;
  Widget? _widget;
  void updateWidget(Widget widget) => _widget = widget;

  bool hasParent() => null != _parent;
  bool hasWidget() => null != _widget;

  BuildContext({
    required this.id,
    required this.widgetType,
    required this.widgetDomTag,
    required this.widgetClassName,
    required Widget widget,
    required BuildContext parent,
  })  : _widget = widget,
        _parent = parent;

  /// Create root context.
  ///
  /// This is required to bootstrap framework.
  ///
  /// Root widget's can have a parent id which points to the place
  /// where it all started(HTML div) but parent is not a widget and
  /// its type is undefined because at the time of big bang there
  /// are no widgets.
  ///
  BuildContext.bigBang(this.id)
      : _widget = null,
        _parent = null,
        widgetDomTag = DomTag.div,
        widgetType = System.typeBigBang,
        widgetClassName = System.typeBigBang;
}
