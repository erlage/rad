import 'dart:html';

import 'package:trad/src/core/classes/framework.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/widget_object.dart';

class Painter {
  final WidgetObject widgetObject;

  Painter(this.widgetObject);

  static void insertStyles(String styles) {
    var styleSheet = document.createElement("style");

    styleSheet.innerText = styles;

    if (null != document.head) {
      document.head!.insertBefore(styleSheet, null);
    } else if (null != document.body) {
      document.head!.insertBefore(styleSheet, null);
    } else {
      throw "Unable to find a target for CSS styles. You must have either head or a body in your app.";
    }
  }

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
