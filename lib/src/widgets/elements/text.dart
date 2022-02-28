import 'package:rad/rad.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A run of text with a single style.
///
/// The [Text] widget displays a string of text with single style. The string
/// might break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// It renders contents of [text] property as a string literal. It can be used to
/// render HTML contents by setting [isHtml] to true.
///
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
  DomTag get tag => DomTag.span;

  @override
  String get type => (Text).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return TextRenderObject(
      text: text,
      style: style ?? '',
      isHtml: isHtml ?? false,
      context: context,
    );
  }
}

class TextRenderObject extends RenderObject {
  final String text;
  final bool isHtml;
  final String style;

  TextRenderObject({
    required this.text,
    required this.style,
    required this.isHtml,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className += " $style";
    }

    if (isHtml) {
      widgetObject.htmlElement.innerHtml = text;

      return;
    }

    widgetObject.htmlElement.innerText = text;
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as TextRenderObject;

    // TODO implement
  }
}
