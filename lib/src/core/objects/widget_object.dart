import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A wrapper for containing everything that can belong to a single widget.
///
/// Before using [element] make sure to check if element is actually
/// created using [isCreated] getter.
///
/// Another getter [isMounted] can be used to check if element is actually
/// mounted.
///
class WidgetObject {
  final HtmlElement element;
  final RenderObject renderObject;

  var _isMounted = false;

  bool get isMounted => _isMounted;
  Widget get widget => renderObject.context.widget;
  BuildContext get context => renderObject.context;

  WidgetObject(this.renderObject)
      :
        // create dom element
        element = document.createElement(
          Utils.mapDomTag(renderObject.context.widget.tag),
        ) as HtmlElement {
    //
    // add properties to element

    element.id = renderObject.context.id;
    element.dataset[System.attrType] = renderObject.context.widgetType;
    element.dataset[System.attrClass] = renderObject.context.widgetClassName;
  }

  void mount() {
    if (_isMounted) {
      throw "Widget's element already mounted.";
    }

    // we can't use node.parent here cus root widget's parent can be null

    var parentElement = document.getElementById(
      renderObject.context.parent.id,
    );

    if (null != parentElement) {
      parentElement.append(element);

      _isMounted = true;
    }
  }

  RenderObject reCreateRenderObject() {
    return renderObject.context.widget.createRenderObject(renderObject.context);
  }

  void build() {
    renderObject.render(this);
  }
}
