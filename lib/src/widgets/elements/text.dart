import '/src/core/enums.dart';
import '/src/core/structures/widget.dart';
import '/src/core/structures/render_object.dart';
import '/src/core/structures/build_context.dart';
import '/src/core/structures/widget_object.dart';

class Text extends Widget {
  String? id;
  String text;
  bool? isHtml;
  String? classes;

  Text(
    this.text, {
    this.id,
    this.isHtml,
    this.classes,
  });

  @override
  RenderObject builder(BuildableContext context) {
    return TextRenderObject(
      classes: classes ?? '',
      text: text,
      buildableContext: BuildableContext(parentId: context.parentId),
    );
  }
}

class TextRenderObject extends RenderObject {
  final String text;
  final bool? isHtml;
  final String classes;

  TextRenderObject({
    this.isHtml,
    required this.classes,
    required this.text,
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
          widgetType: (Text).toString(),
        );

  @override
  render(WidgetObject widgetObject) {
    widgetObject.htmlElement.className = classes;

    var isHtml = this.isHtml;

    if (null != isHtml && isHtml) {
      widgetObject.htmlElement.innerHtml = text;

      return;
    }

    widgetObject.htmlElement.innerText = text;
  }
}
