// ignore_for_file: avoid_classes_with_only_static_members, camel_case_types

import 'test_imports.dart';

/// Collect all render elements into an iterable.
///
Iterable<RenderElement> collectRenderElements(
  RenderElement rootElement,
) {
  return _DepthFirstChildIterator(rootElement);
}

class _DepthFirstChildIterator extends Iterable<RenderElement>
    implements Iterator<RenderElement> {
  _DepthFirstChildIterator(RenderElement rootElement) {
    _fillChildren(rootElement);
  }

  @override
  Iterator<RenderElement> get iterator => this;

  late RenderElement _current;

  final _stack = <RenderElement>[];

  @override
  RenderElement get current => _current;

  @override
  bool moveNext() {
    if (_stack.isEmpty) return false;

    _current = _stack.removeLast();
    _fillChildren(_current);

    return true;
  }

  void _fillChildren(RenderElement element) {
    final List<RenderElement> reversed = <RenderElement>[];

    element.traverseChildElements(reversed.add);

    while (reversed.isNotEmpty) {
      _stack.add(reversed.removeLast());
    }
  }
}
