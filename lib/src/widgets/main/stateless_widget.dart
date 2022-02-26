import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/classes/painter.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';

abstract class StatelessWidget extends Widget {
  final String? key;

  const StatelessWidget({this.key});

  Widget build(BuildContext context);

  @override
  builder(context) {
    var renderObject = StatelessWidgetRenderObject(
      buildableContext: context.mergeKey(key),
    );

    renderObject.child = build(renderObject.context);

    return renderObject;
  }
}

class StatelessWidgetRenderObject extends RenderObject<StatelessWidget> {
  late final Widget child;

  final BuildableContext buildableContext;

  StatelessWidgetRenderObject({
    required this.buildableContext,
  }) : super(
          domTag: DomTag.span,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    var childWidget = child;

    Painter(widgetObject).renderSingleWidget(childWidget);
  }
}
