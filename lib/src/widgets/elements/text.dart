import 'dart:html';

import 'package:rad/rad.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/utils.dart';

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
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return TextRenderObject(
      context: context,
      props: TextProps(
        text: text,
        styles: null != styles ? styles!.split(" ") : [],
        isHtml: isHtml ?? false,
      ),
    );
  }
}

class TextProps {
  final String text;
  final bool isHtml;
  final List<String> styles;

  TextProps({
    required this.text,
    required this.isHtml,
    required this.styles,
  });
}

class TextRenderObject extends RenderObject {
  TextProps props;

  TextRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    applyProps(widgetObject.htmlElement);

    if (props.isHtml) {
      widgetObject.htmlElement.innerHtml = props.text;
      return;
    }

    widgetObject.htmlElement.innerText = props.text;
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as TextRenderObject;

    clearProps(widgetObject.htmlElement);

    switchProps(updatedRenderObject.props);

    applyProps(widgetObject.htmlElement);

    if (props.isHtml) {
      widgetObject.htmlElement.innerHtml = props.text;
      return;
    }

    widgetObject.htmlElement.innerText = props.text;
  }

  void switchProps(TextProps props) {
    this.props = props;
  }

  void applyProps(HtmlElement htmlElement) {
    if (props.styles.isNotEmpty) {
      htmlElement.classes.addAll(props.styles);
    }
  }

  void clearProps(HtmlElement htmlElement) {
    if (props.styles.isNotEmpty) {
      htmlElement.classes.removeAll(props.styles);
    }
  }
}
