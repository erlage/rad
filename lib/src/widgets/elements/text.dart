import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/classes/build_context.dart';
import 'package:rad/src/core/classes/widget.dart';

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
  final String? styles;

  const Text(
    this.text, {
    this.key,
    this.styles,
    this.isHtml,
  });

  @override
  DomTag get tag => DomTag.span;

  @override
  String get type => (Text).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return TextRenderObject(
      context: context,
      text: text,
      isHtml: isHtml ?? false,
      styleProps: StyleProps(styles),
    );
  }
}

class TextRenderObject extends RenderObject {
  final String text;
  final bool isHtml;

  final StyleProps styleProps;

  TextRenderObject({
    required this.text,
    required this.isHtml,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    styleProps.apply(widgetObject.element);

    if (isHtml) {
      widgetObject.element.innerHtml = text;
      return;
    }

    widgetObject.element.innerText = text;
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as TextRenderObject;

    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    // if text has no change
    if (isHtml == updatedRenderObject.isHtml &&
        text == updatedRenderObject.text) {
      return;
    }

    if (updatedRenderObject.isHtml) {
      widgetObject.element.innerHtml = updatedRenderObject.text;

      return;
    }

    widgetObject.element.innerText = updatedRenderObject.text;
  }
}
