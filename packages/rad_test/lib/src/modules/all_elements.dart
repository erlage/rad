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
Iterable<WidgetObject> collectAllWidgetObjectsFrom(
  WidgetObject rootWidgetObject, {
  required bool skipOffstage,
}) {
  return CachingIterable<WidgetObject>(
    _DepthFirstChildIterator(rootWidgetObject, skipOffstage),
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
    implements Iterator<WidgetObject> {
  BuildContext? rootContext;

  Services get services => resolveServices(rootContext!);

  _DepthFirstChildIterator(WidgetObject rootWidgetObject, this.skipOffstage) {
    rootContext = rootWidgetObject.context;

    _fillChildren(rootWidgetObject);
  }

  final bool skipOffstage;

  late WidgetObject _current;

  final _stack = <WidgetObject>[];

  @override
  WidgetObject get current => _current;

  @override
  bool moveNext() {
    if (_stack.isEmpty) return false;

    _current = _stack.removeLast();
    _fillChildren(_current);

    return true;
  }

  void _fillChildren(WidgetObject widgetObject) {
    final List<WidgetObject> reversed = <WidgetObject>[];

    var walker = services.walker;

    for (final node in widgetObject.renderNode.children) {
      var childWidgetObject = walker.getWidgetObject(node.context);
      var childDomNode = childWidgetObject?.domNode;

      if (null != childWidgetObject) {
        if (skipOffstage) {
          childDomNode ??= childWidgetObject.context.findDomNode();

          if (fnIsDomNodeVisible(childDomNode)) {
            reversed.add(childWidgetObject);
          }
        } else {
          reversed.add(childWidgetObject);
        }
      }
    }

    while (reversed.isNotEmpty) {
      _stack.add(reversed.removeLast());
    }
  }
}
