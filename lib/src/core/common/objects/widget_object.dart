import 'dart:html';

import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/renderer/render_node.dart';
import 'package:rad/src/core/common/objects/element_description.dart';

/// A object that holds widget and associated objects.
///
class WidgetObject {
  final BuildContext context;

  final Element element;
  final RenderNode renderNode;
  final RenderObject renderObject;

  bool _isMounted = false;
  bool get isMounted => _isMounted;

  Widget _widget;
  Widget get widget => _widget;

  WidgetConfiguration _configuration;
  WidgetConfiguration get configuration => _configuration;

  ElementDescription? _description;
  ElementDescription get description => _description!;

  WidgetObject({
    required this.context,
    required this.element,
    required this.renderNode,
    required this.renderObject,
    required Widget widget,
    required WidgetConfiguration configuration,
  })  : _widget = widget,
        _configuration = configuration;

  // framework reserved internals

  void frameworkUpdateMountStatus(bool toSet) {
    _isMounted = toSet;
  }

  void frameworkRebindWidget(Widget widget) {
    _widget = widget;
  }

  void frameworkRebindWidgetConfiguration(WidgetConfiguration configuration) {
    _configuration = configuration;
  }

  void frameworkRebindElementDescription(ElementDescription? description) {
    _description = description;
  }
}
