import 'package:rad/src/widgets/abstract/widget.dart';

/// A simple object used to wrap Widget update entries
/// before dispatching them.
///
class WidgetUpdateObject {
  /// New widget instance.
  ///
  final Widget widget;

  /// Id of existing element in DOM to update.
  ///
  /// If it's Null, then framework shouldshould be append or insert a new
  /// element.
  ///
  final String? elementId;

  WidgetUpdateObject(this.widget, this.elementId);
}
