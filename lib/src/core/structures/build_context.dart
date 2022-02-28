import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';

/// Widget's meta data that's required to locate a widget in the tree.
///
/// [BuildContext] objects are passed to widget builder functions (such as
/// [StatelessWidget.build]).
///
/// Each widget has its own [BuildContext], part of which becomes the parent
/// of the widget returned by the [StatelessWidget.build] or
/// [StatefulWidget.build] function or builder's method of Rad widgets.
///
class BuildContext {
  String key;
  late final String widgetType;
  late final DomTag widgetDomTag;

  late final BuildContext parent;

  BuildContext({
    required this.key,
    required this.parent,
    required this.widgetType,
    required this.widgetDomTag,
  });

  /// used for root context
  BuildContext.bigBang(this.key) {
    widgetDomTag = DomTag.div;
    widgetType = Constants.typeBigBang;
  }

  BuildContext mergeKey(String? key) {
    if (null != key) {
      this.key = key;
    }

    return this;
  }
}
