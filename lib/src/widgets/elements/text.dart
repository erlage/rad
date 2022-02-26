import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget_object.dart';

class Text extends Widget {
  final String? key;
  final String text;
  final bool? isHtml;
  final String? style;

  const Text(
    this.text, {
    this.key,
    this.isHtml,
    this.style,
  });

  @override
  RenderObject builder(BuildableContext context) {
    return TextRenderObject(
      text: text,
      style: style,
      buildableContext: context.mergeKey(key),
    );
  }
}

class TextRenderObject extends RenderObject<Text> {
  final String text;
  final bool? isHtml;
  final String? style;

  TextRenderObject({
    this.isHtml,
    required this.text,
    required this.style,
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
        );

  @override
  render(WidgetObject widgetObject) {
    if (null != style) {
      widgetObject.htmlElement.className = style!; // (!) https://dart.dev/tools/non-promotion-reasons
    }

    var isHtml = this.isHtml;

    if (null != isHtml && isHtml) {
      widgetObject.htmlElement.innerHtml = text;

      return;
    }

    widgetObject.htmlElement.innerText = text;
  }
}
