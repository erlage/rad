import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/structures/buildable_context.dart';

abstract class RenderObject<T> {
  final DomTag domTag;
  final BuildContext context;

  RenderObject({
    required this.domTag,
    required BuildableContext buildableContext,
  }) : context = BuildContext(
          key: buildableContext.key ?? Framework.generateId(),
          parentKey: buildableContext.parentKey,
          widgetType: T.toString(),
          widgetDomTag: domTag,
        );

  void render(WidgetObject widgetObject);

  void beforeMount() {}

  void afterMount() {}

  void beforeUnMount() {}

  void rebuild() {
    // Framework.buildFromRenderObject(this);
  }
}
