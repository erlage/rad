import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_object.dart';

/// A simple object used to wrap Action entries
/// before dispatching them.
///
class WidgetActionObject {
  final RenderObject renderObject;
  final WidgetAction widgetAction;

  WidgetActionObject(this.widgetAction, this.renderObject);
}
