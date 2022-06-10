import 'dart:html';

import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/renderer/render_node.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A object that holds widget and associated objects.
///
class WidgetObject {
  final BuildContext context;

  final Element? domNode;
  final RenderNode renderNode;
  final RenderObject renderObject;

  /// Whether a dom node is associated with widget.
  ///
  final bool hasDomNode;

  bool _isMounted = false;
  bool get isMounted => _isMounted;

  Widget _widget;
  Widget get widget => _widget;

  DomNodeDescription? _description;
  DomNodeDescription get description => _description!;

  WidgetObject({
    required this.context,
    required this.domNode,
    required this.renderNode,
    required this.renderObject,
    required Widget widget,
  })  : _widget = widget,
        hasDomNode = null != domNode;

  // framework reserved internals

  void frameworkUpdateMountStatus(bool toSet) {
    _isMounted = toSet;
  }

  void frameworkRebindWidget(Widget widget) {
    _widget = widget;
  }

  void frameworkRebindElementDescription(DomNodeDescription? description) {
    _description = description;
  }
}
