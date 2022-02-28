import 'dart:html';

import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/utils.dart';

class WidgetObject {
  final BuildContext context;

  final Widget widget;
  final RenderObject renderObject;
  late final HtmlElement htmlElement;

  var isMounted = false;

  WidgetObject({
    required this.widget,
    required this.renderObject,
  }) : context = renderObject.context;

  void createHtmlElement() {
    var tag = Utils.mapDomTag(widget.tag);

    htmlElement = document.createElement(tag) as HtmlElement;

    htmlElement.id = renderObject.context.key;
    htmlElement.dataset["wtype"] = renderObject.context.widgetType;
  }

  void injectStyles(List<String>? styles) {
    if (null != styles && styles.isNotEmpty) {
      htmlElement.classes.addAll(styles);
    }
  }

  void mount() {
    if (isMounted) {
      throw "Widget is already mounted.";
    }

    // we can't use node.parent here cus root widget's parent can be null

    var parentElement = document.getElementById(
      renderObject.context.parent.key,
    );

    if (null == parentElement) {
      throw "Unable to find parent widget of element #${context.key}. Either disposed or something went wrong;";
    }

    parentElement.append(htmlElement);

    isMounted = true;
  }

  void render() {
    renderObject.build(this);
  }
}
