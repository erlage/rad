import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';

/// A simple object used to wrap Action entries
/// before dispatching them.
///
class WidgetActionObject {
  final RenderElement element;
  final WidgetAction widgetAction;

  WidgetActionObject(this.widgetAction, this.element);
}
