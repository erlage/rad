import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';

abstract class RenderObject {
  final BuildContext context;

  RenderObject(this.context);

  void render(WidgetObject widgetObject);

  void beforeMount() {}

  void afterMount() {}

  void beforeUnMount() {}

  void update(WidgetObject widgetObject, RenderObject updatedRenderObject);
}
