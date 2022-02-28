import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';

/// Widget's meta data that's required to locate a widget in the tree.
///
/// [BuildContext] objects are passed to widget builder functions (such as
/// [StatelessWidget.render]).
///
/// Each widget has its own [BuildContext], part of which becomes the parent
/// of the widget returned by the [StatelessWidget.render] or
/// [StatefulWidget.render] function or builder's method of Rad widgets.
///
/// [BuildContext] also contains a reference to it's parent's [BuildContext]
/// which further contains it's parent reference and so on. This can be used
/// to trace back origin of widget all the way to BigBang(where it all started)
///
class BuildContext {
  late final String key;
  late final String widgetType;
  late final DomTag widgetDomTag;
  late final String widgetClassName;

  late final BuildContext parent;

  BuildContext({
    required this.key,
    required this.parent,
    required this.widgetType,
    required this.widgetDomTag,
    required this.widgetClassName,
  });

  /// Create root context.
  ///
  /// This is required to bootstrap framework.
  ///
  /// Root widget's can have a parent key which points to the place
  /// where it all started(HTML div) but parent is not a widget and
  /// its type is undefined because at the time of big bang there
  /// are no widgets.
  ///
  BuildContext.bigBang(this.key) {
    widgetDomTag = DomTag.div;
    widgetType = Constants.typeBigBang;
  }
}
