import 'dart:html';

import 'package:rad/src/core/renderer/render_node.dart';

class TreeFragment {
  final _renderNodes = <RenderNode>[];
  final _documentFragment = document.createDocumentFragment();

  List<RenderNode> get renderNodes => _renderNodes;
  DocumentFragment get documentFragment => _documentFragment;

  void appendRenderNode(RenderNode node) {
    _renderNodes.add(node);
  }

  void appendElement(Element element) {
    _documentFragment.append(element);
  }
}
