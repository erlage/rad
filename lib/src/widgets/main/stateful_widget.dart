import 'dart:html';

import 'package:trad/src/core/framework.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/buildable_context.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/objects/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';

abstract class StatefulWidget extends Widget {
  final String? key;

  late final BuildContext context;
  late final StatefulWidgetRenderObject renderObject;

  StatefulWidget({this.key});

  void initState() {}

  Widget build(BuildContext context);

  void dispose() {}

  var _isRebuilding = false;

  @override
  builder(context) {
    renderObject = StatefulWidgetRenderObject(
      dispose: dispose,
      buildableContext: context.mergeKey(key),
    );

    this.context = renderObject.context;

    initState();

    renderObject.setChildWidget(build(this.context));

    return renderObject;
  }

  void setState(VoidCallback? callable) {
    if (_isRebuilding) {
      throw "setState() called while widget was building. Usually happens when you call setState() in build()";
    }

    _isRebuilding = true;

    if (null != callable) {
      callable();
    }

    // get new interface

    renderObject.setChildWidget(build(context));

    // do rebuild

    renderObject.rebuild();

    _isRebuilding = false;
  }
}

class StatefulWidgetRenderObject extends RenderObject<StatefulWidget> {
  late Widget _child;
  final VoidCallback dispose;

  final BuildableContext buildableContext;

  StatefulWidgetRenderObject({
    required this.dispose,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.div,
          buildableContext: buildableContext,
        );

  void setChildWidget(Widget widget) {
    _child = widget;
  }

  @override
  render(widgetObject) {
    Framework.renderSingleChildWidget(
      context: context,
      widget: _child,
    );
  }

  @override
  void beforeUnMount() {
    dispose();
  }
}
