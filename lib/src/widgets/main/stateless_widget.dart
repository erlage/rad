import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/build_context.dart';

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
          domTag: DomTag.div,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }
}
