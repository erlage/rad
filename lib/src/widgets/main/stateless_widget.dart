import 'package:tard/src/core/structures/widget.dart';
import 'package:tard/src/core/enums.dart';
import 'package:tard/src/core/classes/painter.dart';
import 'package:tard/src/core/structures/render_object.dart';
import 'package:tard/src/core/structures/build_context.dart';
import 'package:tard/src/core/structures/widget_object.dart';

abstract class StatelessWidget extends Widget {
  final String? key;

  const StatelessWidget({this.key});

  Widget build(BuildContext context);

  @override
  RenderObject builder(BuildableContext context) {
    var renderObject = StatelessWidgetRenderObject(
      buildableContext: context.mergeKey(key),
    );

    renderObject.child = build(renderObject.context);

    return renderObject;
  }
}

class StatelessWidgetRenderObject extends RenderObject<StatelessWidget> {
  late final Widget child;

  StatelessWidgetRenderObject({
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
        );

  @override
  render(WidgetObject widgetObject) {
    var childWidget = child;

    Painter(widgetObject).renderSingleWidget(childWidget);
  }
}
