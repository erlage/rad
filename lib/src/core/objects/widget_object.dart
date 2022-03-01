import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/utils.dart';

/// A wrapper for containing everything that can belong to a single widget.
///
/// Before using [element] make sure to check if element is actually
/// created using [isCreated] getter.
///
/// Another getter [isMounted] can be used to check if element is actually
/// mounted.
///
class WidgetObject {
  final BuildContext context;

  final Widget widget;
  final RenderObject renderObject;
  late final HtmlElement element;

  var _isMounted = false;
  var _isCreated = false;

  bool get isCreated => _isCreated;
  bool get isMounted => _isMounted;

  WidgetObject({
    required this.widget,
    required this.renderObject,
  }) : context = renderObject.context;

  void createElement() {
    var tag = Utils.mapDomTag(widget.tag);

    element = document.createElement(tag) as HtmlElement;

    element.id = renderObject.context.key;
    element.dataset[Constants.attrType] = renderObject.context.widgetType;
    element.dataset[Constants.attrClass] = renderObject.context.widgetClassName;

    _isCreated = true;
  }

  void mount() {
    if (_isMounted) {
      throw "Widget's element already mounted.";
    }

    // we can't use node.parent here cus root widget's parent can be null

    var parentElement = document.getElementById(
      renderObject.context.parent.key,
    );

    if (null == parentElement) {
      throw "Unable to find parent widget of element #${context.key}. Either disposed or something went wrong;";
    }

    parentElement.append(element);

    _isMounted = true;
  }

  void build() {
    renderObject.render(this);
  }
}
