import '/src/core/classes/framework.dart';
import '/src/core/enums.dart';
import '/src/core/structures/build_context.dart';
import '/src/core/structures/widget_object.dart';

abstract class RenderObject {
  late final BuildContext context;
  final BuildableContext buildableContext;
  final String widgetType;
  final DomTag domTag;

  RenderObject({
    required this.buildableContext,
    required this.widgetType,
    required this.domTag,
  }) {
    context = BuildContext(
      id: buildableContext.id ?? Framework.generateId(),
      parentId: buildableContext.parentId,
      widgetType: widgetType,
      widgetDomTag: domTag,
    );
  }

  render(WidgetObject widgetObject);

  void beforeMount() {}

  void afterMount() {}

  void beforeUnMount() {}

  rebuild() {
    // Framework.build(this);
  }
}
