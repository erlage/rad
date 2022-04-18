import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';

/// A simple object used to wrap Action entries
/// before dispatching them.
///
class WidgetActionObject {
  final WidgetObject widgetObject;
  final WidgetAction widgetAction;

  WidgetActionObject(this.widgetAction, this.widgetObject);
}
