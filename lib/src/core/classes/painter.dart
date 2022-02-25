import '/src/core/classes/framework.dart';
import '/src/core/structures/build_context.dart';
import '/src/core/structures/widget.dart';
import '/src/core/structures/widget_object.dart';

class Painter {
  final WidgetObject widgetObject;

  Painter(this.widgetObject);

  renderSingleWidget(Widget widget, {append = false}) {
    Framework.buildWidget(
      append: append,
      renderObject: widget.builder(
        BuildableContext(
          parentId: widgetObject.context.id,
        ),
      ),
    );
  }

  renderMultipleWidgets(List<Widget> widgets, {append = false}) {
    // build them one by one
    for (var widget in widgets) {
      Framework.buildWidget(
        append: append,
        renderObject: widget.builder(
          BuildableContext(
            parentId: widgetObject.context.id,
          ),
        ),
      );

      // remaining widgets will be appended
      append = true;
    }
  }
}
