import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/classes/painter.dart';
import 'package:trad/src/core/classes/framework.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget_object.dart';

abstract class AppWidget<T> implements Widget {
  final String? key;
  final Widget child;
  final String targetId;

  AppWidget({
    this.key,
    required this.child,
    required this.targetId,
  }) {
    Framework.init();

    Framework.buildWidget(
      renderObject: AppWidgetRenderObject<T>(
        child: child,
        context: BuildableContext(
          key: key,
          parentKey: targetId,
        ),
      ),
    );
  }

  @override
  RenderObject builder(BuildableContext context) {
    return AppWidgetRenderObject(
      child: child,
      context: BuildableContext(
        key: key,
        parentKey: targetId,
      ),
    );
  }
}

class AppWidgetRenderObject<T> extends RenderObject<T> {
  final Widget child;

  AppWidgetRenderObject({
    required this.child,
    required BuildableContext context,
  }) : super(
          buildableContext: context,
          domTag: DomTag.span,
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
