import 'package:trad/src/core/classes/framework.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget_object.dart';

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
