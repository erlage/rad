import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';

/// A run of text with a single style.
///
/// The [Text] widget displays a string of text with single style. The string
/// might break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// It renders contents of [text] property as a string literal.
///
class Text extends Widget {
  final String? key;

  final String text;
  final String? styles;

  const Text(
    this.text, {
    this.key,
    this.styles,
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
      styleProps: StyleProps(styles),
    );
  }
}

class TextRenderObject extends RenderObject {
  final String text;

  final StyleProps styleProps;

  TextRenderObject({
    required this.text,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    styleProps.apply(widgetObject.element);

    widgetObject.element.innerText = text;
  }

  @override
  update(widgetObject, covariant TextRenderObject updatedRenderObject) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    if (text == updatedRenderObject.text) {
      return;
    }

    widgetObject.element.innerText = updatedRenderObject.text;
  }
}
