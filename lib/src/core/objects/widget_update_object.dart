import 'package:rad/src/widgets/abstract/widget.dart';

/// A simple object used to wrap Widget update entries
/// before dispatching them.
///
class WidgetUpdateObject {
  final Widget widget;
  final String? existingElementId;

  WidgetUpdateObject(this.widget, this.existingElementId);
}
