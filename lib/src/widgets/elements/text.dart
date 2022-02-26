import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/buildable_context.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/objects/render_object.dart';

class Text extends Widget {
  final String? key;

  final String text;
  final bool? isHtml;
  final String? style;

  const Text(
    this.text, {
    this.key,
    this.style,
    this.isHtml,
  });

  @override
  builder(context) {
    return TextRenderObject(
      text: text,
      style: style ?? '',
      isHtml: isHtml ?? false,
      buildableContext: context.mergeKey(key),
    );
  }
}

class TextRenderObject extends RenderObject<Text> {
  final String text;
  final bool isHtml;
  final String style;

  final BuildableContext buildableContext;

  TextRenderObject({
    required this.text,
    required this.style,
    required this.isHtml,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.span,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className = style;
    }

    if (isHtml) {
      widgetObject.htmlElement.innerHtml = text;

      return;
    }

    widgetObject.htmlElement.innerText = text;
  }
}
