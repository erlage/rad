import 'package:rad/src/core/structures/widget.dart';

/// A simple object used to wrap Update entries
/// before dispatching them.
///
class UpdateObject {
  final Widget widget;
  final String? existingElementId;

  UpdateObject(this.widget, this.existingElementId);
}
