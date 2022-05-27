import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/renderer/job_queue.dart';
import 'package:rad/src/core/renderer/render_node.dart';
import 'package:rad/src/core/renderer/tree_fragment.dart';
import 'package:rad/src/core/renderer/widget_action_object.dart';
import 'package:rad/src/core/renderer/widget_update_object.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Renderer.
///
class Renderer with ServicesResolver {
  final BuildContext rootContext;

  Services get services => resolveServices(rootContext);

  Renderer(this.rootContext);

  void initState() {
    document.getElementById(rootContext.appTargetId)?.innerHtml = '';
  }

  void dispose() {
    var widgetObjects = services.walker.dumpWidgetObjects();

    for (final widgetObject in widgetObjects) {
      disposeWidgets(
        context: widgetObject.context,
        flagPreserveTarget: false,
      );
    }

    document.getElementById(rootContext.appTargetId)?.innerHtml = '';
  }

  /// Create widget object.
  ///
  WidgetObject createWidgetObject({
    required Widget widget,
    required BuildContext context,
    required JobQueue jobQueue,
  }) {
    var renderNode = RenderNode(context);

    var configuration = widget.createConfiguration();

    var renderObject = widget.createRenderObject(context);

    var element = document.createElement(fnMapDomTag(widget.correspondingTag));

    var widgetObject = WidgetObject(
      widget: widget,
      context: context,
      element: element,
      configuration: configuration,
      renderNode: renderNode,
      renderObject: renderObject,
    );

    services.walker.registerWidgetObject(widgetObject);

    // create description

    var description = renderObject.render(
      configuration: configuration,
    );

    widgetObject.frameworkRebindElementDescription(description);

    // without queue as element is in mem
    applyDescription(element: element, description: description);

    jobQueue.addPostDispatchCallback(() {
      widgetObject
        ..frameworkUpdateMountStatus(true)
        ..renderObject.afterMount();
    });

    if (services.debug.widgetLogs) {
      print('Build widget: $context');
    }

    return widgetObject;
  }

  void render({
    //
    // -- widgets to render --
    //
    required List<Widget> widgets,
    required BuildContext parentContext,
    //
    // -- options --
    //
    required int? mountAtIndex,
    //
    // -- flags --
    //
    required bool flagCleanParentContents,
    //
    // -- optional --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    if (flagCleanParentContents) {
      cleanParentContents(
        parentContext: parentContext,
        jobQueue: queue,
      );
    }

    var treeFragment = TreeFragment();

    buildWidgetsUnderFragment(
      jobQueue: queue,
      widgets: widgets,
      treeFragment: treeFragment,
      parentContext: parentContext,
    );

    mountFragment(
      jobQueue: queue,
      treeFragment: treeFragment,
      mountAtIndex: mountAtIndex,
      parentContext: parentContext,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  /// Update already rendered widgets.
  ///
  void reRender({
    //
    // -- widget to re-render --
    //
    required List<Widget> widgets,
    required BuildContext parentContext,
    //
    // -- options --
    //
    required UpdateType updateType,
    //
    // -- flags --
    //
    required bool flagAddIfNotFound,
    //
    // -- optional --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    updateWidgetsUnderContext(
      jobQueue: queue,
      widgets: widgets,
      updateType: updateType,
      parentContext: parentContext,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  /// Re-render a specific widget-context
  ///
  void reRenderContext({
    //
    // -- widget context to re-render --
    //
    required BuildContext context,
    //
    // -- optional --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    var widgetObject = services.walker.getWidgetObject(context)!;

    updateWidgetsUnderContext(
      jobQueue: queue,
      widgets: [widgetObject.widget],
      updateType: UpdateType.dependencyChanged,
      parentContext: context.parent,
      flagAddIfNotFound: true,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  /// Visit child widgets.
  ///
  /// Method will call [widgetActionCallback] for each child's widget object.
  /// Whatever action the [widgetActionCallback] callback returns, framework
  /// will execute it.
  ///
  void visitWidgets({
    required BuildContext parentContext,
    required WidgetActionCallbackV2 widgetActionCallback,
    //
    // -- options --
    //
    required UpdateType updateType,
    //
    // -- flags --
    //
    bool flagIterateInReverseOrder = false,
    //
    // -- optiona --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    var widgetActions = prepareWidgetActions(
      parentContext: parentContext,
      flagIterateInReverseOrder: flagIterateInReverseOrder,
      widgetActionCallback: widgetActionCallback,
    );

    dispatchWidgetActions(
      jobQueue: queue,
      updateType: updateType,
      parentContext: parentContext,
      widgetActions: widgetActions,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  void disposeWidgets({
    //
    // -- widgets to dispose under context --
    //
    required BuildContext context,
    required bool flagPreserveTarget,
    //
    // -- optional --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    disposeWidgetObjects(
      widgetObject: services.walker.getWidgetObject(context),
      flagPreserveTarget: flagPreserveTarget,
      jobQueue: queue,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  //
  //                  private
  //

  /// Build widgets using a fragment.
  ///
  /// Fragments allows dom elements to be built under a emulated document.
  /// Which means rather than adding document jobs to queue, framework can
  /// directly prepare a sub-tree/elements in memory and append it to real dom
  /// in one go.
  ///
  void buildWidgetsUnderFragment({
    required List<Widget> widgets,
    required BuildContext parentContext,
    required TreeFragment treeFragment,
    required JobQueue jobQueue,
  }) {
    for (final widget in widgets) {
      var key = services.keyGen.computeWidgetKey(
        widget: widget,
        parentContext: parentContext,
      );

      var context = BuildContext.fromParent(
        key: key,
        widget: widget,
        parentContext: parentContext,
      );

      var widgetObject = createWidgetObject(
        widget: widget,
        context: context,
        jobQueue: jobQueue,
      );

      treeFragment
        ..appendElement(widgetObject.element)
        ..appendRenderNode(widgetObject.renderNode);

      // build child nodes

      buildWidgetsAndActivelyLinkElements(
        parentContext: context,
        widgets: widget.widgetChildren,
        parentWidgetObject: widgetObject,
        jobQueue: jobQueue,
      );
    }
  }

  /// Build widgets and immediatly interlink elements.
  ///
  /// This function is intedended to be called only by
  /// [buildWidgetsUnderFragment]. Calling it on a parent context whos element
  /// is mounted on real document will slow down things.
  ///
  void buildWidgetsAndActivelyLinkElements({
    required List<Widget> widgets,
    required BuildContext parentContext,
    required WidgetObject parentWidgetObject,
    required JobQueue jobQueue,
  }) {
    for (final widget in widgets) {
      var key = services.keyGen.computeWidgetKey(
        widget: widget,
        parentContext: parentContext,
      );

      var context = BuildContext.fromParent(
        key: key,
        widget: widget,
        parentContext: parentContext,
      );

      var widgetObject = createWidgetObject(
        widget: widget,
        context: context,
        jobQueue: jobQueue,
      );

      parentWidgetObject.renderNode.append(widgetObject.renderNode);
      parentWidgetObject.element.append(widgetObject.element);

      // build child nodes

      buildWidgetsAndActivelyLinkElements(
        parentContext: context,
        parentWidgetObject: widgetObject,
        widgets: widget.widgetChildren,
        jobQueue: jobQueue,
      );
    }
  }

  /// Update widgets.
  ///
  void updateWidgetsUnderContext({
    required List<Widget> widgets,
    required BuildContext parentContext,
    required UpdateType updateType,
    required bool flagAddIfNotFound,
    required JobQueue jobQueue,
  }) {
    var parentObject = services.walker.getWidgetObject(
      parentContext,
    );

    if (null == parentObject) {
      render(
        widgets: widgets,
        jobQueue: jobQueue,
        mountAtIndex: null,
        parentContext: parentContext,
        flagCleanParentContents: true,
      );

      return;
    }

    var parentNode = parentObject.renderNode;

    var updates = prepareUpdates(
      widgets: widgets,
      parent: parentNode,
      parentContext: parentContext,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    publishUpdates(
      updates: updates,
      parentContext: parentContext,
      updateType: updateType,
      flagAddIfNotFound: flagAddIfNotFound,
      jobQueue: jobQueue,
    );
  }

  /// Publish widget updates.
  ///
  void publishUpdates({
    required Iterable<WidgetUpdateObject> updates,
    required BuildContext parentContext,
    required UpdateType updateType,
    required bool flagAddIfNotFound,
    required JobQueue jobQueue,
  }) {
    for (final updateObject in updates) {
      switch (updateObject.widgetUpdateType) {
        case WidgetUpdateType.dispose:
          updateObject as WidgetUpdateObjectActionDispose;

          disposeWidgets(
            jobQueue: jobQueue,
            flagPreserveTarget: false,
            context: updateObject.existingRenderNode.context,
          );

          break;

        case WidgetUpdateType.add:
          updateObject as WidgetUpdateObjectActionAdd;

          if (services.debug.widgetLogs) {
            print(
              'Add missing child of type: ${updateObject.widget.runtimeType}'
              ' under: $parentContext',
            );
          }

          render(
            jobQueue: jobQueue,
            widgets: [updateObject.widget],
            mountAtIndex: updateObject.mountAtIndex,
            parentContext: parentContext,
            flagCleanParentContents: false,
          );

          break;

        case WidgetUpdateType.update:
          processWidgetUpdateObjectActionUpdate(
            jobQueue: jobQueue,
            updateType: updateType,
            flagAddIfNotFound: flagAddIfNotFound,
            updateObject: updateObject as WidgetUpdateObjectActionUpdate,
          );

          break;
      }
    }
  }

  /// Process a update task.
  ///
  void processWidgetUpdateObjectActionUpdate({
    required WidgetUpdateObjectActionUpdate updateObject,
    required UpdateType updateType,
    required bool flagAddIfNotFound,
    required JobQueue jobQueue,
  }) {
    var newWidget = updateObject.widget;
    var matchedNode = updateObject.existingRenderNode;

    var widgetObject = services.walker.getWidgetObject(
      matchedNode.context,
    );

    if (null != widgetObject) {
      var oldWidget = widgetObject.widget;
      var newMountAtIndex = updateObject.newMountAtIndex;

      /*
      |------------------------------------------------------------------------
      | update widget mount position if requested
      |------------------------------------------------------------------------
      */

      if (null != newMountAtIndex) {
        var parentNode = matchedNode.parent;

        if (null != parentNode) {
          // update render node
          parentNode.insertAt(
            matchedNode,
            updateObject.newMountAtIndex,
          );

          // update dom
          jobQueue.addJob(() {
            var element = widgetObject.element;
            var parentElement = element.parent;

            // insertBefore is a must here.
            // todo: remove these unneccesary checks.
            if (null != parentElement && newMountAtIndex >= 0) {
              //
              // if index is available
              //
              if (parentElement.children.length > newMountAtIndex) {
                //
                // mount at specific index
                //
                parentElement.insertBefore(
                  element,
                  parentElement.children[newMountAtIndex],
                );

                return;
              }
            }
          });
        }
      }

      /*
      |------------------------------------------------------------------------
      | check whether we can short-circuit the rebuild process
      |------------------------------------------------------------------------
      */

      // if it's a inherited widget update, we allow immediate childs
      // to build without checking whether they are const or not.
      //
      // or
      //
      // if it's a update from widget visitor, we allow immediate childs
      // to build without checking whether they are const or not.

      // but if they further have child widgets of their owns, we want
      // the framework to short-circuit rebuild if possible, this can be
      // acheived by resetting update type to something else

      if (UpdateType.dependencyChanged == updateType) {
        updateType = UpdateType.undefined;
      } else if (UpdateType.visitorUpdate == updateType) {
        updateType = UpdateType.undefined;
      } else {
        if (oldWidget == newWidget) {
          if (services.debug.frameworkLogs) {
            print('Short-circuit: ${widgetObject.context}');
          }

          return;
        }
      }

      /*
      |------------------------------------------------------------------------
      | rebind widget instance, always
      |------------------------------------------------------------------------
      */

      widgetObject
        ..frameworkRebindWidget(newWidget)
        ..renderObject.afterWidgetRebind(
          updateType: updateType,
          oldWidget: oldWidget,
          newWidget: newWidget,
        );

      /*
      |------------------------------------------------------------------------
      | check whether widget itself has to be updated
      |------------------------------------------------------------------------
      */

      var oldConfiguration = widgetObject.configuration;
      var isChanged = newWidget.isConfigurationChanged(oldConfiguration);

      if (isChanged) {
        if (services.debug.frameworkLogs) {
          print('Update widget: ${widgetObject.context}');
        }

        var newConfiguration = newWidget.createConfiguration();

        widgetObject.frameworkRebindWidgetConfiguration(newConfiguration);

        // publish update

        var newDescription = widgetObject.renderObject.update(
          updateType: updateType,
          oldConfiguration: oldConfiguration,
          newConfiguration: newConfiguration,
        );

        widgetObject.frameworkRebindElementDescription(newDescription);

        applyDescription(
          jobQueue: jobQueue,
          description: newDescription,
          element: widgetObject.element,
        );
      } else {
        if (services.debug.widgetLogs) {
          print('Skipped: ${widgetObject.context}');
        }
      }

      /*
      |------------------------------------------------------------------------
      | check whether widget childs has to be updated
      |------------------------------------------------------------------------
      */

      // whether old widget happen to have child widgets
      var hadChilds = oldWidget.widgetChildren.isNotEmpty;

      // whether new widget has any childs
      var hasChilds = updateObject.widget.widgetChildren.isNotEmpty;

      // if widget has childs, update them
      if (hasChilds) {
        updateWidgetsUnderContext(
          jobQueue: jobQueue,
          updateType: updateType,
          parentContext: widgetObject.context,
          flagAddIfNotFound: flagAddIfNotFound,
          widgets: updateObject.widget.widgetChildren,
        );
      } else {
        // if new widget has no childs but old had, we have to remove
        // those orphan childs.
        if (hadChilds) {
          disposeWidgets(
            jobQueue: jobQueue,
            flagPreserveTarget: true,
            context: widgetObject.context,
          );
        }
      }
    } else {
      services.debug.exception(Constants.coreError);
    }
  }

  /// Mount fragment containing widgets.
  ///
  /// This process mount both the render nodes and HTML elements on Render tree
  /// and DOM respectively. Updates on Render tree are synchoronous while DOM
  /// updates are queued and dispatched in a batch.
  ///
  void mountFragment({
    required JobQueue jobQueue,
    required int? mountAtIndex,
    required BuildContext parentContext,
    required TreeFragment treeFragment,
  }) {
    var parentWidgetObject = services.walker.getWidgetObject(
      parentContext,
    );

    // add nodes to render tree

    if (null != parentWidgetObject) {
      if (null != mountAtIndex) {
        //
        // mount at specific index
        //
        var index = mountAtIndex - 1;
        for (final node in treeFragment.renderNodes) {
          index++;

          parentWidgetObject.renderNode.insertAt(node, index);
        }
      } else {
        //
        // append
        //
        for (final node in treeFragment.renderNodes) {
          parentWidgetObject.renderNode.append(node);
        }
      }
    }

    // add nodes to dom

    jobQueue.addJob(() {
      Element? parentElement;

      if (null != parentWidgetObject) {
        parentElement = parentWidgetObject.element;
      } else {
        parentElement = document.getElementById(parentContext.key.value);
      }

      if (null == parentElement) {
        services.debug.exception(
          'Unable to locate target element #${parentContext.key.value} in HTML'
          ' document',
        );
      } else {
        // if mount is requested at a specific index
        //
        if (null != mountAtIndex && mountAtIndex >= 0) {
          //
          // if index is available
          //
          if (parentElement.children.length > mountAtIndex) {
            //
            // mount at specific index
            //
            parentElement.insertBefore(
              treeFragment.documentFragment,
              parentElement.children[mountAtIndex],
            );

            return;
          }
        }

        parentElement.append(treeFragment.documentFragment);
      }
    });
  }

  /// Prepare list of updates.
  ///
  Iterable<WidgetUpdateObject> prepareUpdates({
    required List<Widget> widgets,
    required RenderNode parent,
    required BuildContext parentContext,
    required bool flagAddIfNotFound,
  }) {
    // -------------------------

    var hasherForOldNodes = services.keyGen.createCompatibilityHashGenerator();
    var hasherForNewNodes = services.keyGen.createCompatibilityHashGenerator();

    // -------------------------

    // Widgetkey's hash : System action to take
    var widgetSystemActions = <String, WidgetUpdateObject>{};

    var oldRenderNodesHashMap = <String, RenderNode>{};
    var oldRenderNodesPositions = <String, int>{};
    var oldRenderNodesHashRegistry = <String, String>{};

    // prepare hash map from existing render nodes
    var oldPositionIndex = -1;
    for (final node in parent.children) {
      oldPositionIndex++;

      //
      // Unique hash. Can be used to find a matching widget at the same level of
      // tree.
      //
      var oldNodeHash = hasherForOldNodes.createCompatibilityHash(
        widgetKey: node.context.key,
        widgetRuntimeType: node.context.widgetRuntimeType,
      );

      // register hash
      oldRenderNodesHashRegistry[node.context.key.value] = oldNodeHash;

      oldRenderNodesPositions[oldNodeHash] = oldPositionIndex;
      oldRenderNodesHashMap[oldNodeHash] = node;
    }

    // for keeping track of nodes that were missing and added or moved to top
    var slippedInNodesCount = 0;

    // for keeping track of new widget's position
    var newPositionIndex = -1;
    for (final widget in widgets) {
      newPositionIndex++;

      var newKey = services.keyGen.computeWidgetKey(
        widget: widget,
        parentContext: parentContext,
      );

      var newNodeHash = hasherForNewNodes.createCompatibilityHash(
        widgetKey: newKey,
        widgetRuntimeType: '${widget.runtimeType}',
      );

      var existingRenderNode = oldRenderNodesHashMap[newNodeHash];

      // if matching node not found
      if (null == existingRenderNode) {
        if (!flagAddIfNotFound) {
          continue;
        }

        slippedInNodesCount++;

        widgetSystemActions[newNodeHash] = WidgetUpdateObjectActionAdd(
          widget: widget,
          mountAtIndex: newPositionIndex,
          widgetPositionIndex: newPositionIndex,
        );

        continue;
      }

      // else a existing widget has been matched

      // ignore: avoid_init_to_null
      int? mountAtIndex = null;

      var newPositionY = newPositionIndex;
      var oldPositionY = oldRenderNodesPositions[newNodeHash];

      if (null != oldPositionY) {
        var expectedOldPosition = oldPositionY + slippedInNodesCount;

        if (expectedOldPosition != newPositionY) {
          mountAtIndex = newPositionY;

          slippedInNodesCount++;
        }
      }

      widgetSystemActions[newNodeHash] = WidgetUpdateObjectActionUpdate(
        widget: widget,
        newMountAtIndex: mountAtIndex,
        widgetPositionIndex: newPositionIndex,
        existingRenderNode: existingRenderNode,
      );
    }

    var preparedSystemActions = <WidgetUpdateObject>[];

    // deal with obsolute nodes

    for (final node in parent.children) {
      var nodeKeyValue = node.context.key.value;

      // compatibility hash
      var oldNodeHash = oldRenderNodesHashRegistry[nodeKeyValue];

      if (null != oldNodeHash) {
        if (!widgetSystemActions.containsKey(oldNodeHash)) {
          preparedSystemActions.add(WidgetUpdateObjectActionDispose(node));
        }
      }
    }

    preparedSystemActions.addAll(widgetSystemActions.values);

    // -------------------------

    services.keyGen.disposeHashGenerator(hasherForOldNodes);
    services.keyGen.disposeHashGenerator(hasherForNewNodes);

    // -------------------------

    return preparedSystemActions;
  }

  /// Prepare list of widget actions(by iterating widgets under a context).
  ///
  List<WidgetActionObject> prepareWidgetActions({
    required BuildContext parentContext,
    required WidgetActionCallbackV2 widgetActionCallback,
    required bool flagIterateInReverseOrder,
  }) {
    var widgetObject = services.walker.getWidgetObject(
      parentContext,
    );

    if (null == widgetObject) {
      return [];
    }

    var widgetActionObjects = <WidgetActionObject>[];

    var children = widgetObject.renderNode.children;

    var iterable = flagIterateInReverseOrder ? children.reversed : children;

    childrenLoop:
    for (final node in iterable) {
      var childWidgetObject = services.walker.getWidgetObject(
        node.context,
      );

      if (null != childWidgetObject) {
        var widgetActions = widgetActionCallback(childWidgetObject);

        for (final widgetAction in widgetActions) {
          widgetActionObjects.add(
            WidgetActionObject(widgetAction, childWidgetObject),
          );

          if (WidgetAction.skipRest == widgetAction) {
            break childrenLoop;
          }
        }
      }
    }

    return widgetActionObjects;
  }

  void dispatchWidgetActions({
    required BuildContext parentContext,
    required List<WidgetActionObject> widgetActions,
    required UpdateType updateType,
    required JobQueue jobQueue,
  }) {
    for (final widgetActionObject in widgetActions) {
      switch (widgetActionObject.widgetAction) {
        case WidgetAction.skipRest:
          break;

        case WidgetAction.showWidget:
          jobQueue.addJob(() {
            widgetActionObject.widgetObject.element.classes.remove(
              Constants.classHidden,
            );
          });

          break;

        case WidgetAction.hideWidget:
          jobQueue.addJob(() {
            widgetActionObject.widgetObject.element.classes.add(
              Constants.classHidden,
            );
          });

          break;

        case WidgetAction.dispose:
          disposeWidgets(
            context: widgetActionObject.widgetObject.context,
            flagPreserveTarget: false,
          );

          break;

        case WidgetAction.updateWidget:
          var widgetObject = widgetActionObject.widgetObject;

          // publish update

          var newDescription = widgetObject.renderObject.update(
            updateType: updateType,
            newConfiguration: widgetObject.configuration,
            oldConfiguration: widgetObject.configuration,
          ); // bit of mess ^ but required

          widgetObject.frameworkRebindElementDescription(newDescription);

          applyDescription(
            jobQueue: jobQueue,
            description: newDescription,
            element: widgetObject.element,
          );

          // call update on child widgets

          updateWidgetsUnderContext(
            jobQueue: jobQueue,
            updateType: updateType,
            parentContext: widgetObject.context,
            flagAddIfNotFound: true,
            widgets: widgetObject.widget.widgetChildren,
          );

          break;
      }
    }
  }

  /// Clean existing widgets/elements
  ///
  void cleanParentContents({
    required BuildContext parentContext,
    required JobQueue jobQueue,
  }) {
    var parentWidgetObject = services.walker.getWidgetObject(
      parentContext,
    );

    disposeWidgetObjects(
      widgetObject: parentWidgetObject,
      flagPreserveTarget: true,
      jobQueue: jobQueue,
    );

    jobQueue.addJob(() {
      Element? parentElement;

      if (null != parentWidgetObject) {
        parentElement = parentWidgetObject.element;
      } else {
        parentElement = document.getElementById(parentContext.key.value);
      }

      parentElement?.innerHtml = '';
    });
  }

  void disposeWidgetObjects({
    WidgetObject? widgetObject,
    bool flagPreserveTarget = false,
    required JobQueue jobQueue,
  }) {
    if (null == widgetObject) {
      return;
    }

    // cascade dispose to its childs first

    if (widgetObject.renderNode.children.isNotEmpty) {
      for (final childElement in [...widgetObject.renderNode.children]) {
        disposeWidgetObjects(
          widgetObject: services.walker.getWidgetObject(
            childElement.context,
          ),
          jobQueue: jobQueue,
        );
      }
    }

    // if widget itself has to be preserved

    if (flagPreserveTarget) {
      return;
    }

    widgetObject
      ..renderObject.beforeUnMount()
      ..renderNode.detach();

    jobQueue.addJob(() {
      widgetObject.element.remove();
    });

    services.walker.unRegisterWidgetObject(widgetObject);

    if (services.debug.widgetLogs) {
      print('Dispose: ${widgetObject.context}');
    }
  }

  void applyDescription({
    required Element element,
    ElementDescription? description,
    JobQueue? jobQueue,
  }) {
    if (null == description) {
      return;
    }

    void job() {
      if (description.attributes.isNotEmpty) {
        description.attributes.forEach((key, value) {
          if (null != value) {
            element.setAttribute(key, value);
          } else {
            element.removeAttribute(key);
          }
        });
      }

      if (description.dataset.isNotEmpty) {
        description.dataset.forEach((key, value) {
          if (null != value) {
            element.dataset[key] = value;
          } else {
            element.dataset.remove(key);
          }
        });
      }

      description.styleProperties.forEach((key, value) {
        if (null != value) {
          element.style.setProperty(key, value);
        } else {
          element.style.removeProperty(key);
        }
      });

      if (null != description.textContents) {
        element.innerText = description.textContents!;
      }

      if (null != description.rawContents) {
        element.setInnerHtml(description.rawContents, validator: const _None());
      }
    }

    if (null != jobQueue) {
      jobQueue.addJob(job);
    } else {
      job();
    }
  }
}

/// A node validator that won't validate...
///
class _None implements NodeValidator {
  const _None();

  @override
  allowsElement(_) => true;

  @override
  allowsAttribute(_, __, ___) => true;
}
