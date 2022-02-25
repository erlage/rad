import 'package:tard/src/core/classes/framework.dart';
import 'package:tard/src/core/enums.dart';
import 'package:tard/src/core/structures/build_context.dart';
import 'package:tard/src/core/structures/widget_object.dart';

abstract class RenderObject<T> {
  late final BuildContext context;
  final BuildableContext buildableContext;
  final DomTag domTag;

  RenderObject({
    required this.buildableContext,
    required this.domTag,
  }) {
    context = BuildContext(
      key: buildableContext.key ?? Framework.generateId(),
      parentKey: buildableContext.parentKey,
      widgetType: T.toString(),
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
