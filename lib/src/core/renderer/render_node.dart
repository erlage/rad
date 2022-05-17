import 'package:rad/src/core/common/objects/build_context.dart';

/// A node in Render tree.
///
/// Most of the dom related operations are first carried out on [RenderNode]s as
/// operating DOM is painfully slow and expensive.
///
class RenderNode {
  /// Context reference of node.
  ///
  final BuildContext context;

  /// Identifier for keyed nodes.
  ///
  final String matchKey;

  RenderNode(
    this.context,
  ) : matchKey = '${context.widgetRuntimeType}${context.key.value}';

  RenderNode? _parent;
  RenderNode? get parent => _parent;

  final _children = <RenderNode>[];
  List<RenderNode> get children => _children;

  void append(RenderNode node) {
    node.detach();

    _children.add(node);

    node._parent = this;
  }

  void insertAt(RenderNode node, int? index) {
    node.detach();

    if (null != index && index > -1 && _children.length > index) {
      _children.insert(index, node);
    } else {
      _children.add(node);
    }

    node._parent = this;
  }

  void insertBefore(
    RenderNode node,
    RenderNode? beforeNode,
  ) {
    node.detach();

    var index = (null != beforeNode) ? _children.indexOf(beforeNode) : -1;

    if (-1 != index) {
      _children.insert(index, node);
    } else {
      _children.add(node);
    }

    node._parent = this;
  }

  void detach() {
    if (null != parent) {
      parent!._removeChild(this);
    }

    _parent = null;
  }

  void _removeChild(RenderNode node) {
    _children.remove(node);

    node._parent = null;
  }
}
