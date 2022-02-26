import 'dart:html';

import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/render_object.dart';

class WidgetObject {
  late final BuildContext context;

  final RenderObject renderObject;
  final HtmlElement htmlElement;

  WidgetObject({
    required this.renderObject,
    required this.htmlElement,
  }) {
    context = renderObject.context;
  }

  mount() {
    // we can't use node.parent here cus root widget's parent can be null

    var parentElement = document.getElementById(renderObject.context.parentKey);

    if (null == parentElement) {
      throw "Unable to find parent widget of element #${context.key}. Either disposed or something went wrong;";
    }

    parentElement.append(htmlElement);
  }
}
