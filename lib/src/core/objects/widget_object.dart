import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A wrapper for containing everything that can belong to a single widget.
///
/// Getter [isMounted] can be used to check if element is actually
/// mounted.
///
class WidgetObject {
  final HtmlElement element;
  final RenderObject renderObject;

  WidgetConfiguration configuration;

  var _isMounted = false;

  bool get isMounted => _isMounted;
  Widget get widget => renderObject.context.widget;
  BuildContext get context => renderObject.context;

  WidgetObject({
    required this.configuration,
    required this.renderObject,
  }) :
        // create dom element
        element = document.createElement(
          Utils.mapDomTag(renderObject.context.widget.correspondingTag),
        ) as HtmlElement {
    //
    // add properties to element

    element.id = renderObject.context.key;
    element.dataset[System.attrConcreteType] =
        renderObject.context.widgetConcreteType;
    element.dataset[System.attrRuntimeType] =
        renderObject.context.widgetRuntimeType;
  }

  void mount({int? mountAtIndex}) {
    if (_isMounted) {
      return Debug.exception("Widget's element already mounted.");
    }

    // we can't use node.parent here cus root widget's parent can be null

    var parentElement = document.getElementById(
      renderObject.context.parent.key,
    );

    if (null != parentElement) {
      // if mount is requested at a specific index

      if (null != mountAtIndex) {
        // if index is available

        if (mountAtIndex > 0 && parentElement.children.length > mountAtIndex) {
          // mount at specific index

          parentElement.insertBefore(
            element,
            parentElement.children[mountAtIndex],
          );

          _isMounted = true;

          return;
        }
      }

      // else append

      parentElement.append(element);

      _isMounted = true;
    } else {
      if (Debug.developmentMode) {
        print("Element not found: #${renderObject.context.parent.key}");
      }
    }
  }

  void rebindConfiguration(WidgetConfiguration newConfiguration) {
    configuration = newConfiguration;
  }
}
