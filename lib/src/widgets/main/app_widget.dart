import '/src/core/enums.dart';
import '/src/core/classes/painter.dart';
import '/src/core/classes/framework.dart';
import '/src/core/structures/widget.dart';
import '/src/core/structures/render_object.dart';
import '/src/core/structures/build_context.dart';
import '/src/core/structures/widget_object.dart';

abstract class AppWidget implements Widget {
  final String? id;
  final Widget child;
  final String targetId;
  final String widgetType;

  AppWidget({
    this.id,
    required this.child,
    required this.targetId,
    required this.widgetType,
  }) {
    Framework.init();

    Framework.buildWidget(
      renderObject: AppWidgetRenderObject(
        child: child,
        widgetType: widgetType,
        context: BuildableContext(parentId: targetId),
      ),
    );
  }

  @override
  RenderObject builder(BuildableContext context) {
    return AppWidgetRenderObject(
      child: child,
      widgetType: widgetType,
      context: BuildableContext(
        id: id,
        parentId: targetId,
      ),
    );
  }
}

class AppWidgetRenderObject extends RenderObject {
  final Widget child;

  AppWidgetRenderObject({
    required this.child,
    required String widgetType,
    required BuildableContext context,
  }) : super(
          buildableContext: context,
          domTag: DomTag.span,
          widgetType: widgetType,
        );

  @override
  render(WidgetObject widgetObject) {
    var targetElement = widgetObject.htmlElement.parent;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    targetElement.dataset.addAll({"wtype": "Target"});

    Painter(widgetObject).renderSingleWidget(child);
  }
}
