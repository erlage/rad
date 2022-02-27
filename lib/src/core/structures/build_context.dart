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
  final String key;
  final String parentKey;
  final String widgetType;
  final DomTag widgetDomTag;

  BuildContext({
    required this.key,
    required this.parentKey,
    required this.widgetType,
    required this.widgetDomTag,
  });
}
