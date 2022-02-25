import 'package:castor/src/core/classes/framework.dart';
import 'package:castor/src/core/structures/build_context.dart';
import 'package:castor/src/core/structures/widget.dart';
import 'package:castor/src/core/structures/widget_object.dart';

class Painter {
  final WidgetObject widgetObject;

  Painter(this.widgetObject);

  renderSingleWidget(Widget widget, {append = false}) {
    Framework.buildWidget(
      append: append,
      renderObject: widget.builder(
        BuildableContext(
          parentKey: widgetObject.context.key,
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
            parentKey: widgetObject.context.key,
          ),
        ),
      );

      // remaining widgets will be appended
      append = true;
    }
  }
}
