import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/widget_object.dart';

/// A simple object used to wrap Action entries
/// before dispatching them.
///
class WidgetActionObject {
  final WidgetObject widgetObject;
  final WidgetAction widgetAction;

  WidgetActionObject(this.widgetAction, this.widgetObject);
}
