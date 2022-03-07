import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';

/// Widget's meta data that's required to locate a widget in the tree.
///
/// [BuildContext] also contains a reference to its parent's [BuildContext]
/// which further contains its parent reference and so on. This can be used
/// to trace back origin of widget all the way to BigBang(where it all started)
///
class BuildContext {
  final String key;
  final String widgetType;
  final DomTag widgetDomTag;
  final String widgetClassName;

  /// reference to context of parent's widget
  ///
  /// accessing will results in error if [widgetClassName] is [System.typeBigBang]
  ///
  late BuildContext parent;
  // mark final in next release. dart2js-not-working-as-expected at this moment.

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
  BuildContext.bigBang(this.key)
      : widgetDomTag = DomTag.div,
        widgetType = System.typeBigBang,
        widgetClassName = System.typeBigBang;
}
