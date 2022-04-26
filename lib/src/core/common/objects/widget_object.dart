import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';

/// A object that wraps widget and its associated objects.
///
/// This object provides a sort of high level control over render object and
/// element of a widget.
///
class WidgetObject {
  final HtmlElement element;
  final BuildContext context;
  final RenderObject renderObject;

  Widget _widget;
  Widget get widget => _widget;

  WidgetConfiguration _configuration;
  WidgetConfiguration get configuration => _configuration;

  bool _isMounted = false;
  bool get isMounted => _isMounted;

  WidgetObject({
    required Widget widget,
    required this.context,
  })  : _widget = widget,

        // widget configuration

        _configuration = widget.createConfiguration(),

        // render object

        renderObject = widget.createRenderObject(context),

        // element

        element = (document.createElement(
          fnMapDomTag(widget.correspondingTag),
        ) as HtmlElement)
          ..id = context.key.value
          ..dataset[Constants.attrWidgetType] = widget.widgetType
          ..dataset[Constants.attrRuntimeType] = "${widget.runtimeType}";

  void mount(int? mountAtIndex) {
    renderObject.beforeMount();

    _doMount(mountAtIndex);

    _isMounted = true;

    renderObject
      ..afterMount()
      ..render(element, configuration);
  }

  void unMount() {
    renderObject.beforeUnMount();

    _isMounted = false;

    _doUnMount();
  }

  void rebindWidget({
    required Widget widget,
    required UpdateType updateType,
    required WidgetConfiguration newConfiguration,
  }) {
    var oldWidget = _widget;
    var newWidget = widget;

    _widget = newWidget;
    _configuration = newConfiguration;

    renderObject.afterWidgetRebind(
      newWidget: newWidget,
      oldWidget: oldWidget,
      updateType: updateType,
    );
  }

  /// Direct call to [RenderObject.update].
  ///
  void update({
    required UpdateType updateType,
    required WidgetConfiguration newConfiguration,
    required WidgetConfiguration oldConfiguration,
  }) {
    renderObject.update(
      element: element,
      updateType: updateType,
      oldConfiguration: oldConfiguration,
      newConfiguration: newConfiguration,
    );
  }

  void _doMount(int? mountAtIndex) {
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

          return;
        }
      }

      // else append

      parentElement.append(element);
    }
  }

  void _doUnMount() {
    element.remove();
  }
}
