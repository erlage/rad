import 'package:trad/src/core/classes/framework.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget_object.dart';

abstract class RenderObject<T> {
  final DomTag domTag;
  late final BuildContext context;

  RenderObject({
    required this.domTag,
    required BuildableContext buildableContext,
  }) {
    context = BuildContext(
      key: buildableContext.key ?? Framework.generateId(),
      parentKey: buildableContext.parentKey,
      widgetType: T.toString(),
      widgetDomTag: domTag,
    );
  }

  void render(WidgetObject widgetObject);

  void beforeMount() {}

  void afterMount() {}

  void beforeUnMount() {}

  void rebuild() {
    // Framework.build(this);
  }
}
