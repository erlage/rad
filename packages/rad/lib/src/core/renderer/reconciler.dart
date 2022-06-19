import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/renderer/widget_update_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Rad's reconciler.
///
/// Reconciler tries to match new widgets with exisiting widgets and prepare
/// list of dom operations that are required to bring DOM into desired state.
///
/// Every reconciler method is on hot-path and optimized for performance. While
/// optimizations are great but it also increases the probability of bugs that
/// can easily hide behind these optimizations. To ensure that reconciler works
/// correct, we run number of mutations which involves removing specific, few,
/// and all optimizations, and running tests after each such mutation.
///
class Reconciler {
  /// Compatibility hasher instances that are available for reuse.
  ///
  /// Re-useable hasher instances for Rad's algorithm.
  ///
  final _availableHashers = <_CompatibilityHashGenerator>[];

  /// Prepare widget updates.
  ///
  Iterable<WidgetUpdateObject> prepareUpdates({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required BuildContext parentContext,
    required bool flagAddIfNotFound,
  }) {
    // If there are no new widgets, dispose all the old ones

    if (widgets.isEmpty) {
      return _prepareUpdatesDisposeAll(
        parentRenderElement: parentRenderElement,
        flagAddIfNotFound: flagAddIfNotFound,
      );
    }

    // If there are no old widgets, add all the new ones

    if (parentRenderElement.frameworkChildElements.isEmpty) {
      return _prepareUpdatesAddAllWithoutClean(
        widgets: widgets,
        flagAddIfNotFound: flagAddIfNotFound,
      );
    }

    return _prepareUpdatesUsingRadAlgo(
      widgets: widgets,
      parentRenderElement: parentRenderElement,
      parentContext: parentContext,
      flagAddIfNotFound: flagAddIfNotFound,
    );
  }

  Iterable<WidgetUpdateObject> _prepareUpdatesAddAllWithoutClean({
    required List<Widget> widgets,
    required bool flagAddIfNotFound,
  }) {
    if (widgets.isEmpty || !flagAddIfNotFound) {
      return const [];
    }

    return [
      WidgetUpdateObjectActionAddAllWithoutClean(
        widgets: widgets,
      )
    ];
  }

  Iterable<WidgetUpdateObject> _prepareUpdatesDisposeAll({
    required RenderElement parentRenderElement,
    required bool flagAddIfNotFound,
  }) {
    // if there are no old childs to dispose
    if (parentRenderElement.frameworkChildElements.isEmpty) {
      return const [];
    }

    return [WidgetUpdateObjectActionCleanParent()];
  }

  /// Prepare list of widget updates using Rad's algorithm.
  ///
  /// This is a two-part algorithm.
  ///
  ///
  /// We refer to these parts as:
  ///
  ///
  /// - Direct mode(first algorithm)
  ///
  /// - Hash mode(second algorithm)
  ///
  ///
  /// In direct mode, we tries to reconcile widgets the easiest way possible,
  /// i.e by traversing both lists from both ends to the point where nodes
  /// starts to differ. If we fails to reconcile all nodes in direct mode we
  /// then switch to hash mode.
  ///
  ///
  /// Hash mode is capable of reconciling any type nodes, even if they contains
  /// lot of mis-matches. It also tries to ignore nodes that are already
  /// synced in the direct mode.
  ///
  ///
  /// Direct mode basically act as a compliment to the hash mode in number of
  /// cases. Algorithn used in hash mode is quite heavy weight and it's not
  /// quite suited to reconcile lists that are small or doesn't really contain
  /// moving parts. Direct mode is helpful even if it fails to reconcile all
  /// nodes as it narrows down the size of lists that hash mode has to
  /// reconcile.
  ///
  Iterable<WidgetUpdateObject> _prepareUpdatesUsingRadAlgo({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required BuildContext parentContext,
    required bool flagAddIfNotFound,
  }) {
    // Note on testing:
    //
    // Testing on CI: Automated
    //
    // Testing locally:
    //
    //  - To test direct mode:
    //    Just run all tests, direct mode always gets executed.
    //
    //  - To test hash mode & it's 'takeover procedure' from direct mode:
    //    See .github/workflows/reconciler.yml
    //

    // =======================================================================
    //  Setup | Common to both modes
    // =======================================================================

    var newNodes = widgets;
    var oldNodes = parentRenderElement.frameworkChildElements;

    var newNodesCount = newNodes.length;
    var oldNodesCount = oldNodes.length;

    var newTopPoint = 0;
    var oldTopPoint = 0;

    var newBottomPoint = newNodesCount - 1;
    var oldBottomPoint = oldNodesCount - 1;

    var preparedUpdates = <WidgetUpdateObject>[];
    var preparedUpdatesInReverse = <WidgetUpdateObject>[];

    // =======================================================================
    //  Direct Mode
    // =======================================================================

    // ----------------------------------------------------------------------
    //  Phase-1 | Match nodes from the top
    // ----------------------------------------------------------------------

    //// TEST__COMMENTABLE_MUTATION_START

    while (newTopPoint <= newBottomPoint && oldTopPoint <= oldBottomPoint) {
      //
      var newNode = newNodes[newTopPoint];
      var oldNode = oldNodes[oldTopPoint];

      var oldKey = oldNode.key;
      var oldRuntimeType = oldNode.widgetRuntimeType;

      var newKey = newNode.key;
      var newRuntimeType = '${newNode.runtimeType}';

      if (newRuntimeType != oldRuntimeType || newKey != oldKey) {
        break;
      }

      preparedUpdates.add(
        WidgetUpdateObjectActionUpdate(
          widget: newNode,
          widgetPositionIndex: newTopPoint,
          existingRenderElement: oldNode,
          newMountAtIndex: null,
        ),
      );

      newTopPoint++;
      oldTopPoint++;
    }

    //// TEST__COMMENTABLE_MUTATION_END

    // ----------------------------------------------------------------------
    //  Phase-Minor-1 | See if we can return early
    // ----------------------------------------------------------------------

    var hasUnSyncedOldNodes = oldTopPoint <= oldBottomPoint;
    var hasUnSyncedNewNodes = newTopPoint <= newBottomPoint;

    //// TEST__COMMENTABLE_MUTATION_START

    // check if we can append new nodes and return

    if (hasUnSyncedNewNodes && !hasUnSyncedOldNodes) {
      preparedUpdates.add(
        WidgetUpdateObjectActionAdd(
          widgets: newNodes.sublist(newTopPoint),
          mountAtIndex: null,
          widgetPositionIndex: newTopPoint,
        ),
      );

      return preparedUpdates;
    }

    // check if we can dispose old nodes and return

    if (hasUnSyncedOldNodes && !hasUnSyncedNewNodes) {
      preparedUpdates.insert(
        0,
        WidgetUpdateObjectActionDisposeMultiple(
          oldNodes.sublist(oldTopPoint),
        ),
      );

      return preparedUpdates;
    }

    //// TEST__COMMENTABLE_MUTATION_END

    // ----------------------------------------------------------------------
    //  Phase-2 | Match nodes from the bottom
    // ----------------------------------------------------------------------

    //// TEST__COMMENTABLE_MUTATION_START

    while (oldTopPoint <= oldBottomPoint && newTopPoint <= newBottomPoint) {
      //
      var newNode = newNodes[newBottomPoint];
      var oldNode = oldNodes[oldBottomPoint];

      var oldKey = oldNode.key;
      var oldRuntimeType = oldNode.widgetRuntimeType;

      var newKey = newNode.key;
      var newRuntimeType = '${newNode.runtimeType}';

      if (newRuntimeType != oldRuntimeType || newKey != oldKey) {
        break;
      }

      preparedUpdatesInReverse.add(
        WidgetUpdateObjectActionUpdate(
          widget: newNode,
          widgetPositionIndex: newTopPoint,
          existingRenderElement: oldNode,
          newMountAtIndex: null,
        ),
      );

      newBottomPoint--;
      oldBottomPoint--;
    }

    //// TEST__COMMENTABLE_MUTATION_END

    // =======================================================================
    //  Hash mode
    // =======================================================================

    var hasherForOldNodes = createCompatibilityHashGenerator();
    var hasherForNewNodes = createCompatibilityHashGenerator();

    // ----------------------------------------------------------------------
    //  Phase-1 | Collect data from new nodes
    // ----------------------------------------------------------------------

    var newNodeHashToNodeMap = <String, Widget>{};
    var newPositionToNodeHashMap = <int, String>{};

    // copy of original top pointer
    var copyOfNewTopPoint = newTopPoint;

    while (copyOfNewTopPoint <= newBottomPoint) {
      var newNode = newNodes[copyOfNewTopPoint];

      var newNodeHash = hasherForNewNodes.createCompatibilityHash(
        widgetKey: newNode.key,
        widgetRuntimeType: '${newNode.runtimeType}',
      );

      newNodeHashToNodeMap[newNodeHash] = newNode;
      newPositionToNodeHashMap[copyOfNewTopPoint] = newNodeHash;

      copyOfNewTopPoint++;
    }

    // ----------------------------------------------------------------------
    //  Phase-2 | Collect data from old nodes and remove obsolute nodes
    // ----------------------------------------------------------------------

    var oldNodeHashToNodeMap = <String, RenderElement>{};
    var oldNodeHashToPositionMap = <String, int>{};

    // expected position of old node

    var obsoluteNodesCount = 0;

    while (oldTopPoint <= oldBottomPoint) {
      var oldNode = oldNodes[oldTopPoint];

      var oldNodeHash = hasherForOldNodes.createCompatibilityHash(
        widgetKey: oldNode.key,
        widgetRuntimeType: oldNode.widgetRuntimeType,
      );

      oldNodeHashToPositionMap[oldNodeHash] = oldTopPoint - obsoluteNodesCount;
      oldNodeHashToNodeMap[oldNodeHash] = oldNode;

      //// TEST__COMMENTABLE_MUTATION_START

      // Optimization: Loose positions of obsolute nodes

      // this optimization creats a illusion that there are no obsolute nodes
      // in the old list. this will prevents unneccessary re-mounts of nodes
      // that are not obsolute.

      // a node is considered obsolute if it's not present in the new node list.
      // note that we still hash obsolute nodes and they'll point to a position
      // which will be occupied by a non-obsolute node. this will helps us find
      // these obsolutes nodes either for easy dispose or maybe re-use.

      if (null == newNodeHashToNodeMap[oldNodeHash]) {
        obsoluteNodesCount++;
      }

      //// TEST__COMMENTABLE_MUTATION_END

      oldTopPoint++;
    }

    // ----------------------------------------------------------------------
    //  Phase-3 | Traverse new widgets and prepare updates
    // ----------------------------------------------------------------------

    // for keeping track of nodes that were missing and added or moved to top
    var slippedInNodesCount = 0;

    // for keeping tack of last inserted node
    WidgetUpdateObjectActionAdd? lastAddedWidgetAction;

    while (newTopPoint <= newBottomPoint) {
      var newPositionIndex = newTopPoint++;

      var newNode = newNodes[newPositionIndex];
      var newNodeHash = newPositionToNodeHashMap[newPositionIndex];

      var matchedOldNode = oldNodeHashToNodeMap.remove(newNodeHash);

      // if matching node not found
      if (null == matchedOldNode) {
        if (!flagAddIfNotFound) {
          continue;
        }

        slippedInNodesCount++;

        // if we've already added a widget
        if (null != lastAddedWidgetAction) {
          // check whether this widget is consecutive to the last added widget
          // because we can add all consecutive widgets in a single operation

          // position index of previously added widget
          var lastWidgetPosIndex = lastAddedWidgetAction.widgetPositionIndex;
          var lastWidgetAppendCount = lastAddedWidgetAction.widgets.length;

          // expected offset
          var expectedPosIndex = lastWidgetPosIndex + lastWidgetAppendCount;

          if (expectedPosIndex == newPositionIndex) {
            lastAddedWidgetAction.appendAnotherWidget(newNode);

            continue;
          }
        }

        lastAddedWidgetAction = WidgetUpdateObjectActionAdd(
          widgets: [newNode],
          mountAtIndex: newPositionIndex,
          widgetPositionIndex: newPositionIndex,
        );

        preparedUpdates.add(lastAddedWidgetAction);

        continue;
      }

      // else a existing widget has been matched

      // ignore: avoid_init_to_null
      int? mountAtIndex = null;

      var newPositionY = newPositionIndex;
      var oldPositionY = oldNodeHashToPositionMap[newNodeHash];

      if (null != oldPositionY) {
        var expectedOldPosition = oldPositionY + slippedInNodesCount;

        if (expectedOldPosition != newPositionY) {
          mountAtIndex = newPositionY;

          // cuplrit 2)
          slippedInNodesCount++;
        }
      }

      preparedUpdates.add(
        WidgetUpdateObjectActionUpdate(
          widget: newNode,
          newMountAtIndex: mountAtIndex,
          widgetPositionIndex: newPositionIndex,
          existingRenderElement: matchedOldNode,
        ),
      );
    }

    // ----------------------------------------------------------------------
    //  Phase-3 | Deal with obsolute nodes
    // ----------------------------------------------------------------------

    if (oldNodeHashToNodeMap.isNotEmpty) {
      preparedUpdates.insert(
        0,
        WidgetUpdateObjectActionDisposeMultiple(
          oldNodeHashToNodeMap.values,
        ),
      );
    }

    // =======================================================================
    //  Merge collected updates during direct mode
    // =======================================================================

    while (preparedUpdatesInReverse.isNotEmpty) {
      preparedUpdates.add(preparedUpdatesInReverse.removeLast());
    }

    // -------------------------

    disposeHashGenerator(hasherForOldNodes);
    disposeHashGenerator(hasherForNewNodes);

    // -------------------------

    return preparedUpdates;
  }

  /// Create compatibility hash generator.
  ///
  _CompatibilityHashGenerator createCompatibilityHashGenerator() {
    if (_availableHashers.isNotEmpty) {
      return _availableHashers.removeLast();
    }

    return _CompatibilityHashGenerator();
  }

  /// Dispose hasher instance so it can be reused.
  ///
  void disposeHashGenerator(_CompatibilityHashGenerator generator) {
    generator._revive();

    _availableHashers.add(generator);
  }
}

/// Widget's compatibility hash generator.
///
class _CompatibilityHashGenerator {
  final _counters = <String, int>{};

  /// Create unique hash for widget that can be used to find a matching widget
  /// at the same level of tree.
  ///
  String createCompatibilityHash({
    required Key? widgetKey,
    required String widgetRuntimeType,
  }) {
    if (null != widgetKey) {
      return '$widgetRuntimeType:k:${widgetKey.value}';
    }

    return '$widgetRuntimeType:nk:${_generateCountForType(widgetRuntimeType)}';
  }

  int _generateCountForType(String type) {
    var count = _counters[type];

    count ??= 0;

    _counters[type] = count + 1;

    return count;
  }

  /// Clear hasher state so that instance can be re-used.
  ///
  void _revive() {
    _counters.clear();
  }
}
