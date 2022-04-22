import 'dart:html';

import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
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

  /// Create widget object.
  ///
  WidgetObject(Widget widget, BuildContext context)
      : configuration = widget.createConfiguration(),
        renderObject = widget.createRenderObject(context),
        element = document.createElement(
          fnMapDomTag(context.widget.correspondingTag),
        ) as HtmlElement {
    //
    // add properties to element

    element
      ..id = context.key.value
      ..dataset[Constants.attrConcreteType] = context.widgetConcreteType
      ..dataset[Constants.attrRuntimeType] = context.widgetRuntimeType;
  }

  void rebindConfiguration(WidgetConfiguration newConfiguration) {
    configuration = newConfiguration;
  }

  void mount({int? mountAtIndex}) {
    renderObject.beforeMount();

    _doMount(mountAtIndex: mountAtIndex);

    renderObject.afterMount();

    renderObject.render(element, configuration);
  }

  void unMount() {
    renderObject.beforeUnMount();

    element.remove();
  }

  void _doMount({int? mountAtIndex}) {
    // we can't use node.parent here cus root widget's parent can be null

    var parentElement = document.getElementById(
      renderObject.context.parent.key.value,
    );

    if (null != parentElement) {
      // if mount is requested at a specific index

      if (null != mountAtIndex) {
        // if index is available

        if (mountAtIndex >= 0 && parentElement.children.length > mountAtIndex) {
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
    }
  }
}
