import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_element.dart';

/// A simple object used to wrap Action entries
/// before dispatching them.
///
class WidgetActionObject {
  final RenderElement element;
  final WidgetAction widgetAction;

  WidgetActionObject(this.widgetAction, this.element);
}
