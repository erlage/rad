import 'package:rad_test/src/common/functions.dart';
import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/cached_interable.dart';

/// Provides an iterable that efficiently returns all the elements
/// rooted at the given element. See [CachingIterable] for details.
///
/// This method must be called again if the tree changes. You cannot
/// call this function once, then reuse the iterable after having
/// changed the state of the tree, because the iterable returned by
/// this function caches the results and only walks the tree once.
///
/// The same applies to any iterable obtained indirectly through this
/// one, for example the results of calling `where` on this iterable
/// are also cached.
///
Iterable<RenderElement> collectAllWidgetObjectsFrom(
  RenderElement rootElement, {
  required bool skipOffstage,
}) {
  return CachingIterable<RenderElement>(
    _DepthFirstChildIterator(rootElement, skipOffstage),
  );
}

/// Provides a recursive, efficient, depth first search of an element tree.
///
///       1
///     /   \
///    2     3
///   / \   / \
///  4   5 6   7
///
/// Will iterate in order 2, 4, 5, 3, 6, 7.
///
class _DepthFirstChildIterator
    with ServicesResolver
    implements Iterator<RenderElement> {
  _DepthFirstChildIterator(RenderElement rootElement, this.skipOffstage) {
    _fillChildren(rootElement);
  }

  final bool skipOffstage;

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

    element.traverseChildElements((child) {
      var childDomNode = child.domNode;

      if (skipOffstage) {
        childDomNode ??= child.findClosestDomNode();

        if (fnIsDomNodeVisible(childDomNode)) {
          reversed.add(child);
        }
      } else {
        reversed.add(child);
      }
    });

    while (reversed.isNotEmpty) {
      _stack.add(reversed.removeLast());
    }
  }
}
