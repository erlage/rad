import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/props/class_attribute_prop.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A run of text with a single style.
///
class Text extends Widget {
  final String text;
  final String? classAttribute;

  const Text(
    this.text, {
    String? id,
    this.classAttribute,
  }) : super(id);

  @override
  DomTag get tag => DomTag.span;

  @override
  String get type => "$Text";

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
  String text;

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

    text = updatedRenderObject.text;

    widgetObject.element.innerText = updatedRenderObject.text;
  }
}
