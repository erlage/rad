import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/props/class_attribute_prop.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A run of text with a single style.
///
/// The [Text] widget displays a string of text with single style. The string
/// might break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// It renders contents of [text] property as a string literal.
///
class Text extends Widget {
  final String? id;

  final String text;
  final String? classAttribute;

  const Text(
    this.text, {
    this.id,
    this.classAttribute,
  });

  @override
  DomTag get tag => DomTag.span;

  @override
  String get type => "$Text";

  @override
  String get initialId => id ?? System.idNotSet;

  @override
  createRenderObject(context) {
    return TextRenderObject(
      context: context,
      text: text,
      styleProps: ClassAttributeProp(classAttribute),
    );
  }
}

class TextRenderObject extends RenderObject {
  final String text;

  final ClassAttributeProp styleProps;

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
  update(
    updateType,
    widgetObject,
    covariant TextRenderObject updatedRenderObject,
  ) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    if (text == updatedRenderObject.text) {
      return;
    }

    widgetObject.element.innerText = updatedRenderObject.text;
  }
}
