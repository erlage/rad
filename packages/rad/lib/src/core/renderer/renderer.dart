import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/renderer/dumb_node_validator.dart';
import 'package:rad/src/core/renderer/job_queue.dart';
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
    services.rootElement.domNode?.innerHtml = '';
  }

  void dispose() {
    disposeWidget(
      renderElement: services.rootElement,
      flagPreserveTarget: true,
    );

    services.rootElement.domNode?.innerHtml = '';
  }

  void render({
    //
    // -- widgets to render --
    //
    required List<Widget> widgets,
    //
    // -- render element of parent widget --
    //
    required RenderElement parentRenderElement,
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
        parentRenderElement: parentRenderElement,
        jobQueue: queue,
      );
    }

    // create temp space for holding new widgets

    var remnantRenderElement = RemnantElement.create(services);

    // build widgets under temp space

    buildWidgetsUnderContext(
      widgets: widgets,
      parentDomNode: remnantRenderElement.domNode!,
      parentRenderElement: remnantRenderElement,
      jobQueue: queue,
    );

    // mount widgets from temp space

    mountWidgets(
      parentRenderElement: parentRenderElement,
      mountAtIndex: mountAtIndex,
      remnantRenderElement: remnantRenderElement,
      jobQueue: queue,
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
    //
    // -- render element of parent widget --
    //
    required RenderElement parentRenderElement,
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
      parentRenderElement: parentRenderElement,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  /// Re-render a specific widget
  ///
  void reRenderContext({
    //
    // -- element(context) of widget to re-render --
    //
    required RenderElement renderElement,
    //
    // -- optional --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    updateWidgetsUnderContext(
      jobQueue: queue,
      widgets: [renderElement.widget],
      updateType: UpdateType.dependencyChanged,
      parentRenderElement: renderElement.frameworkParent!,
      flagAddIfNotFound: true,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  /// Visit child widgets.
  ///
  /// Method will call [widgetActionCallback] for each child's elements.
  /// Whatever action the [widgetActionCallback] callback returns, framework
  /// will execute it.
  ///
  void visitWidgets({
    //
    // -- render element of parent of child widgets to visit --
    //
    required RenderElement parentRenderElement,
    //
    // -- callback --
    //
    required WidgetActionsBuilder widgetActionCallback,
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
      parentRenderElement: parentRenderElement,
      flagIterateInReverseOrder: flagIterateInReverseOrder,
      widgetActionCallback: widgetActionCallback,
    );

    dispatchWidgetActions(
      jobQueue: queue,
      updateType: updateType,
      parentRenderElement: parentRenderElement,
      widgetActions: widgetActions,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  void disposeWidget({
    //
    // -- widgets to dispose under context --
    //
    required RenderElement renderElement,
    required bool flagPreserveTarget,
    //
    // -- optional --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    disposeRenderElement(
      renderElement: renderElement,
      flagPreserveTarget: flagPreserveTarget,
      jobQueue: queue,
    );

    // ------------------------------------ //

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Methods that could be private
  |--------------------------------------------------------------------------
  */

  /// Build widget.
  ///
  RenderElement createRenderElement({
    required Widget widget,
    required RenderElement parentRenderElement,
    required JobQueue jobQueue,
  }) {
    // 1. Create render element

    var renderElement = widget.createRenderElement(parentRenderElement);

    // 2. Create dom node(if widget.correspondingTag is non-null)

    Element? domNode;

    var tagName = widget.correspondingTag?.nativeName;

    if (null != tagName) {
      domNode = document.createElement(tagName);

      renderElement.frameworkBindDomNode(domNode: domNode);
    }

    // 3. Register element

    services.walker.registerElement(renderElement);

    // 3. Create description

    var domNodeDescription = renderElement.frameworkRender(widget: widget);

    // 4. Apply description(if widget has a associated dom dom node)

    if (null != domNode && null != domNodeDescription) {
      // without queue as dom node is in mem
      applyDescription(domNode: domNode, description: domNodeDescription);
    }

    // 5. Register event listeners

    var bubbleEventListeners = widget.widgetEventListeners;
    var captureEventListeners = widget.widgetCaptureEventListeners;

    if (captureEventListeners.isNotEmpty) {
      services.events.setupEventListeners(captureEventListeners);
    }

    if (bubbleEventListeners.isNotEmpty) {
      services.events.setupEventListeners(bubbleEventListeners);
    }

    jobQueue.addPostDispatchCallback(renderElement.frameworkAfterMount);

    if (services.debug.widgetLogs) {
      print('Build widget: $renderElement');
    }

    return renderElement;
  }

  /// Build widgets under a available parent dom node and parent render element.
  ///
  void buildWidgetsUnderContext({
    required List<Widget> widgets,
    required Element parentDomNode,
    required RenderElement parentRenderElement,
    required JobQueue jobQueue,
  }) {
    for (final widget in widgets) {
      // 1. Create render element

      var renderElement = createRenderElement(
        widget: widget,
        parentRenderElement: parentRenderElement,
        jobQueue: jobQueue,
      );

      // 2. Add render element to element tree

      parentRenderElement.frameworkAppendFresh(renderElement);

      // 3. Add dom node to dom tree(if current widget has)

      var currentDomNode = renderElement.domNode;

      if (null != currentDomNode) {
        parentDomNode.append(renderElement.domNode!);
      }

      // 4. Build child widgets

      var childWidgets = renderElement.childWidgets;

      if (childWidgets.isNotEmpty) {
        buildWidgetsUnderContext(
          widgets: childWidgets,
          parentDomNode: currentDomNode ?? parentDomNode,
          parentRenderElement: renderElement,
          jobQueue: jobQueue,
        );
      }
    }
  }

  /// Update widgets.
  ///
  void updateWidgetsUnderContext({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required UpdateType updateType,
    required bool flagAddIfNotFound,
    required JobQueue jobQueue,
  }) {
    var updates = prepareUpdates(
      widgets: widgets,
      parentRenderElement: parentRenderElement,
      parentContext: parentRenderElement,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    publishUpdates(
      updates: updates,
      updateType: updateType,
      parentRenderElement: parentRenderElement,
      flagAddIfNotFound: flagAddIfNotFound,
      jobQueue: jobQueue,
    );
  }

  /// Publish widget updates.
  ///
  void publishUpdates({
    required Iterable<WidgetUpdateObject> updates,
    required RenderElement parentRenderElement,
    required UpdateType updateType,
    required bool flagAddIfNotFound,
    required JobQueue jobQueue,
  }) {
    for (final updateObject in updates) {
      switch (updateObject.widgetUpdateType) {
        case WidgetUpdateType.dispose:
          updateObject as WidgetUpdateObjectActionDispose;

          disposeWidget(
            jobQueue: jobQueue,
            flagPreserveTarget: false,
            renderElement: updateObject.existingElement,
          );

          break;

        case WidgetUpdateType.disposeMultiple:
          updateObject as WidgetUpdateObjectActionDisposeMultiple;

          var iterable = updateObject.elementsToDispose;

          for (final renderElement in iterable) {
            disposeWidget(
              jobQueue: jobQueue,
              flagPreserveTarget: false,
              renderElement: renderElement,
            );
          }

          break;

        case WidgetUpdateType.cleanParent:
          updateObject as WidgetUpdateObjectActionCleanParent;

          cleanParentContents(
            parentRenderElement: parentRenderElement,
            jobQueue: jobQueue,
          );

          break;

        case WidgetUpdateType.add:
          updateObject as WidgetUpdateObjectActionAdd;

          if (services.debug.widgetLogs) {
            print(
              'Add ${updateObject.widgets.length} missing widgets: '
              ' under: $parentRenderElement',
            );
          }

          render(
            jobQueue: jobQueue,
            widgets: updateObject.widgets,
            mountAtIndex: updateObject.mountAtIndex,
            parentRenderElement: parentRenderElement,
            flagCleanParentContents: false,
          );

          break;

        case WidgetUpdateType.addAllWithoutClean:
          updateObject as WidgetUpdateObjectActionAddAllWithoutClean;

          render(
            mountAtIndex: null,
            widgets: updateObject.widgets,
            parentRenderElement: parentRenderElement,
            flagCleanParentContents: false,
            jobQueue: jobQueue,
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
    var newMountAtIndex = updateObject.newMountAtIndex;
    var matchedRenderElement = updateObject.existingRenderElement;

    var newWidget = updateObject.widget;
    var oldWidget = matchedRenderElement.widget;

    /*
    |------------------------------------------------------------------------
    | update widget mount position if requested
    |------------------------------------------------------------------------
    */

    if (null != newMountAtIndex) {
      // 1. Get dom node for remount

      var domNode = matchedRenderElement.domNode;
      domNode ??= matchedRenderElement.findClosestDomNodeInDescendants();

      // 2. Parent render element

      var parentRenderElement = matchedRenderElement.frameworkParent;

      if (null != parentRenderElement) {
        // 3. Re mount render element

        parentRenderElement.frameworkInsertAt(
          matchedRenderElement,
          newMountAtIndex,
        );

        // 4. Re mount dom node

        jobQueue.addJob(() {
          if (null == domNode) {
            return;
          }

          var parentDomNode = domNode.parent;

          parentDomNode?.insertBefore(
            domNode,
            parentDomNode.children[newMountAtIndex],
          );
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

    var updateTypeForChildWidgets = updateType;

    if (UpdateType.dependencyChanged == updateType) {
      updateTypeForChildWidgets = UpdateType.undefined;
    } else if (UpdateType.visitorUpdate == updateType) {
      updateTypeForChildWidgets = UpdateType.undefined;
    } else {
      if (oldWidget == newWidget) {
        if (services.debug.frameworkLogs) {
          print('Short-circuit: $matchedRenderElement');
        }

        return;
      }
    }

    /*
    |------------------------------------------------------------------------
    | rebind widget instance, always
    |------------------------------------------------------------------------
    */

    matchedRenderElement.frameworkRebindWidget(
      newWidget: newWidget,
      oldWidget: oldWidget,
      updateType: updateType,
    );

    /*
    |------------------------------------------------------------------------
    | check whether widget itself has to be updated
    |------------------------------------------------------------------------
    */

    var shouldUpdateWidget = newWidget.shouldUpdateWidget(oldWidget);

    if (shouldUpdateWidget) {
      if (services.debug.frameworkLogs) {
        print('Update widget: $matchedRenderElement');
      }

      // update element, store results in a var as this
      // hook can return a dom node description patch

      var domNodePatch = matchedRenderElement.frameworkUpdate(
        updateType: updateType,
        oldWidget: oldWidget,
        newWidget: newWidget,
      );

      // apply patch (if previous call to update returned non-null patch)

      if (null != domNodePatch && matchedRenderElement.hasDomNode) {
        applyDescription(
          jobQueue: jobQueue,
          description: domNodePatch,
          domNode: matchedRenderElement.domNode!,
        );
      }
    } else {
      if (services.debug.widgetLogs) {
        print('Skipped: $matchedRenderElement');
      }
    }

    /*
    |------------------------------------------------------------------------
    | run update on child nodes
    |------------------------------------------------------------------------
    */

    // get permission from widget which owns the child widgets

    var shouldUpdateChildWidgets = newWidget.shouldUpdateWidgetChildren(
      oldWidget,
      shouldUpdateWidget,
    );

    // i hope its not granted

    if (shouldUpdateChildWidgets) {
      updateWidgetsUnderContext(
        jobQueue: jobQueue,
        updateType: updateTypeForChildWidgets,
        parentRenderElement: matchedRenderElement,
        flagAddIfNotFound: flagAddIfNotFound,
        widgets: matchedRenderElement.childWidgets,
      );
    }
  }

  /// Mount widgets.
  ///
  /// This process mount both the elements and HTML dom nodes on element tree
  /// and DOM respectively. Updates on element tree are synchoronous while DOM
  /// updates are queued and dispatched in a batch.
  ///
  void mountWidgets({
    //
    // -- element that's holding new widgets --
    //
    required RemnantElement remnantRenderElement,
    //
    // -- element which is expecting new widgets --
    //
    required RenderElement parentRenderElement,
    //
    // -- mount at index --
    //
    required int? mountAtIndex,
    //
    required JobQueue jobQueue,
  }) {
    /*
    |--------------------------------------------------------------------------
    | Prepare
    |--------------------------------------------------------------------------
    */

    // create copy of new elements list for iterator

    var renderElements = remnantRenderElement.frameworkChildElements;

    // store reference of first render element from new widgets

    var firstRenderElementInNewWidgets = renderElements.first;

    /*
    |--------------------------------------------------------------------------
    | Add nodes to element tree
    |--------------------------------------------------------------------------
    */

    if (null != mountAtIndex) {
      //
      // if mount at specific index
      //

      parentRenderElement.frameworkInsertAllFreshAt(
        renderElements,
        mountAtIndex,
      );
    } else {
      //
      // else append
      //
      parentRenderElement.frameworkAppendAllFresh(renderElements);
    }

    // 2. Find closest widget that has an dom node in dom and get mount location

    var currentParentRenderElement = parentRenderElement;

    if (!currentParentRenderElement.hasDomNode) {
      // if parent has no dom node and mountAtIndex is null then its a
      // widgetbuildtask for in-direct child widgets.
      //
      // e.g a stateful widget doesn't have direct childs but issue a build
      // widgets task for in-direct childs. those indirect childs has to be
      // mounted on a specific position in parent's dom node when changed or
      // added
      var requiresMountAtSpecificPosition = null == mountAtIndex;

      // a render node in path between parent render node(that has dom
      // node) and the widget that we're going to mount. this render node is
      // immediate to parent render node.
      var immediateRenderElement = firstRenderElementInNewWidgets;

      while (true) {
        if (currentParentRenderElement.hasDomNode) {
          break;
        }

        immediateRenderElement = currentParentRenderElement;

        var parent = currentParentRenderElement.frameworkParent;

        if (null == parent) {
          break;
        }

        currentParentRenderElement = parent;
      }

      if (requiresMountAtSpecificPosition) {
        mountAtIndex =
            currentParentRenderElement.frameworkChildElements.indexOf(
          immediateRenderElement,
        );
      }
    }

    // 3. Get dom node for mounting

    var mountTargetDomNode = currentParentRenderElement.domNode;

    if (null == mountTargetDomNode) {
      services.debug.exception(
        'Unable to locate target dom node #$currentParentRenderElement in HTML'
        ' document',
      );

      return;
    }

    // 4. Prepare new dom nodes for mounting

    var documentFragment = DocumentFragment();

    for (final node in remnantRenderElement.domNode!.children) {
      documentFragment.append(node);
    }

    // 5. Add a mount job

    jobQueue.addJob(() {
      // if mount is requested at a specific index
      //
      if (null != mountAtIndex && mountAtIndex >= 0) {
        //
        // if index is available
        //
        if (mountTargetDomNode.children.length > mountAtIndex) {
          //
          // mount at specific index
          //
          mountTargetDomNode.insertBefore(
            documentFragment,
            mountTargetDomNode.children[mountAtIndex],
          );

          return;
        }
      }

      mountTargetDomNode.append(documentFragment);
    });
  }

  /// Prepare list of widget actions(by iterating widgets under a context).
  ///
  List<WidgetActionObject> prepareWidgetActions({
    required RenderElement parentRenderElement,
    required WidgetActionsBuilder widgetActionCallback,
    required bool flagIterateInReverseOrder,
  }) {
    var widgetActionObjects = <WidgetActionObject>[];

    var children = parentRenderElement.frameworkChildElements;

    var iterable = flagIterateInReverseOrder ? children.reversed : children;

    childrenLoop:
    for (final renderElement in iterable) {
      var widgetActions = widgetActionCallback(renderElement);

      for (final widgetAction in widgetActions) {
        widgetActionObjects.add(
          WidgetActionObject(widgetAction, renderElement),
        );

        if (WidgetAction.skipRest == widgetAction) {
          break childrenLoop;
        }
      }
    }

    return widgetActionObjects;
  }

  void dispatchWidgetActions({
    required RenderElement parentRenderElement,
    required List<WidgetActionObject> widgetActions,
    required UpdateType updateType,
    required JobQueue jobQueue,
  }) {
    for (final widgetActionObject in widgetActions) {
      switch (widgetActionObject.widgetAction) {
        case WidgetAction.skipRest:
          break;

        case WidgetAction.showWidget:
          var domNode = widgetActionObject.element.findClosestDomNode();

          jobQueue.addJob(() {
            domNode.classes.remove(
              Constants.classHidden,
            );
          });

          break;

        case WidgetAction.hideWidget:
          var domNode = widgetActionObject.element.findClosestDomNode();

          jobQueue.addJob(() {
            domNode.classes.add(
              Constants.classHidden,
            );
          });

          break;

        case WidgetAction.dispose:
          disposeWidget(
            renderElement: widgetActionObject.element,
            flagPreserveTarget: false,
          );

          break;

        case WidgetAction.updateWidget:
          var renderElement = widgetActionObject.element;
          var widget = renderElement.widget;

          // call update and stop result as this call can return dom patch

          var domPatch = renderElement.update(
            updateType: updateType,
            newWidget: widget,
            oldWidget: widget,
          ); // bit of mess ^ but required

          if (null != domPatch && renderElement.hasDomNode) {
            applyDescription(
              jobQueue: jobQueue,
              description: domPatch,
              domNode: renderElement.domNode!,
            );
          }

          // call update on child widgets

          var shouldUpdateWidgetChild = widget.shouldUpdateWidgetChildren(
            widget,
            true,
          );

          if (shouldUpdateWidgetChild) {
            updateWidgetsUnderContext(
              jobQueue: jobQueue,
              updateType: updateType,
              parentRenderElement: renderElement,
              flagAddIfNotFound: true,
              widgets: renderElement.childWidgets,
            );

            break;
          }
      }
    }
  }

  /// Clean existing widgets/dom nodes
  ///
  void cleanParentContents({
    required RenderElement parentRenderElement,
    required JobQueue jobQueue,
  }) {
    disposeRenderElement(
      renderElement: parentRenderElement,
      flagPreserveTarget: true,
      flagEnqeueChildElementRemoval: false,
      jobQueue: jobQueue,
    );

    jobQueue.addJob(() {
      parentRenderElement.domNode?.innerHtml = '';
    });
  }

  /// Dispose render element and descendants.
  ///
  /// [flagPreserveTarget] - Whether to remove descendants but preserve the
  /// widget itself.
  ///
  /// [flagEnqeueTargetElementRemoval] - Whether to remove [renderElement]'s
  /// dom node from DOM by making a explict call to domNode.remove
  ///
  /// [flagEnqeueChildElementRemoval] - Whether to remove ecah children of
  /// [renderElement] from DOM by making a explict call to domNode.remove
  ///
  void disposeRenderElement({
    //
    // -- render element to dispose --
    //
    RenderElement? renderElement,
    //
    // -- flags --
    //
    bool flagPreserveTarget = false,
    bool flagEnqeueTargetElementRemoval = true,
    bool flagEnqeueChildElementRemoval = true,
    //
    // -- job queue --
    //
    required JobQueue jobQueue,
  }) {
    if (null == renderElement) {
      return;
    }

    // cascade dispose to its childs first

    var children = [...renderElement.frameworkChildElements];

    if (children.isNotEmpty) {
      for (final childRenderElement in children) {
        disposeRenderElement(
          renderElement: childRenderElement,
          //
          // child should be removed
          //
          flagPreserveTarget: false,
          //
          // whether to enqeue child's dom node removal depends on flag
          // if parent is cleaning all objects, then it should be false
          //
          flagEnqeueTargetElementRemoval: flagEnqeueChildElementRemoval,
          //
          // since child will be removed, there's no need to enqeue removals
          // of childs of child's dom node.
          //
          flagEnqeueChildElementRemoval: false,
          //
          jobQueue: jobQueue,
        );
      }
    }

    if (!flagPreserveTarget) {
      if (flagEnqeueTargetElementRemoval) {
        var domNode = renderElement.domNode;

        if (null != domNode) {
          jobQueue.addJob(domNode.remove);
        }
      }

      renderElement
        ..frameworkBeforeUnMount()
        ..frameworkDetach();

      services.walker.unRegisterElement(renderElement);

      if (services.debug.widgetLogs) {
        print('Dispose: $renderElement');
      }
    }
  }

  void applyDescription({
    required Element domNode,
    required DomNodePatch description,
    JobQueue? jobQueue,
  }) {
    void job() {
      var dataset = description.dataset;
      var attributes = description.attributes;
      var rawContents = description.rawContents;
      var textContents = description.textContents;

      if (null != attributes) {
        if (attributes.isNotEmpty) {
          attributes.forEach((key, value) {
            if (null != value) {
              domNode.setAttribute(key, value);
            } else {
              domNode.removeAttribute(key);
            }
          });
        }
      }

      if (null != dataset) {
        if (dataset.isNotEmpty) {
          dataset.forEach((key, value) {
            if (null != value) {
              domNode.dataset[key] = value;
            } else {
              domNode.dataset.remove(key);
            }
          });
        }
      }

      if (null != textContents) {
        domNode.innerText = textContents;
      }

      if (null != rawContents) {
        domNode.setInnerHtml(
          rawContents,
          validator: const DumbNodeValidator(),
        );
      }
    }

    if (null != jobQueue) {
      jobQueue.addJob(job);
    } else {
      job();
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Below methods tries to match new widgets with exisiting widgets and 
  | prepare dom operations that are required to bring DOM into desired state.
  |
  | This is probably the place where small optimisations can make big 
  | improvements.
  |--------------------------------------------------------------------------
  */

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
  /// Previous algorithm was of complexity O(n^2) but very lightweight compares
  /// to this one. It might be better to use previous algorithm when sum of
  /// number of childs(under both nodes that we're comparing) is small.
  ///
  Iterable<WidgetUpdateObject> _prepareUpdatesUsingRadAlgo({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required BuildContext parentContext,
    required bool flagAddIfNotFound,
  }) {
    // -------------------------

    var keyGenService = services.keyGen;

    var hasherForOldNodes = keyGenService.createCompatibilityHashGenerator();
    var hasherForNewNodes = keyGenService.createCompatibilityHashGenerator();

    // -------------------------

    // System action to take on a widget
    var preparedUpdates = <WidgetUpdateObject>[];

    var oldNodeHashToElementMap = <String, RenderElement>{};
    var oldNodeHashToPositionMap = <String, int>{};

    // --------------------------------------------------
    // Phase-1 | Collect data from old nodes
    // --------------------------------------------------

    // prepare hash map from existing render elements
    var oldPositionIndex = -1;
    for (final renderElement in parentRenderElement.frameworkChildElements) {
      oldPositionIndex++;

      // Unique hash. Can be used to find a matching widget at the same level of
      // tree.
      //
      var oldNodeHash = hasherForOldNodes.createCompatibilityHash(
        widgetKey: renderElement.key,
        widgetRuntimeType: renderElement.widgetRuntimeType,
      );

      oldNodeHashToPositionMap[oldNodeHash] = oldPositionIndex;
      oldNodeHashToElementMap[oldNodeHash] = renderElement;
    }

    // --------------------------------------------------
    // Phase-2 | Traverse new widgets and prepare updates
    // --------------------------------------------------

    // for keeping track of nodes that were missing and added or moved to top
    var slippedInNodesCount = 0;

    // for keeping tack of last widget that's inserted
    WidgetUpdateObjectActionAdd? lastAddedWidgetAction;

    // for keeping track of new widget's position
    var newPositionIndex = -1;
    for (final widget in widgets) {
      newPositionIndex++;

      var newNodeHash = hasherForNewNodes.createCompatibilityHash(
        widgetKey: widget.key,
        widgetRuntimeType: '${widget.runtimeType}',
      );

      var existingRenderNode = oldNodeHashToElementMap.remove(newNodeHash);

      // if matching node not found
      if (null == existingRenderNode) {
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
            lastAddedWidgetAction.appendAnotherWidget(widget);

            continue;
          }
        }

        lastAddedWidgetAction = WidgetUpdateObjectActionAdd(
          widgets: [widget],
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
          widget: widget,
          newMountAtIndex: mountAtIndex,
          widgetPositionIndex: newPositionIndex,
          existingRenderElement: existingRenderNode,
        ),
      );
    }

    // --------------------------------------------------
    // Phase-3 | Deal with obsolute nodes
    // --------------------------------------------------

    if (oldNodeHashToElementMap.isNotEmpty) {
      preparedUpdates.insert(
        0,
        WidgetUpdateObjectActionDisposeMultiple(
          oldNodeHashToElementMap.values,
        ),
      );
    }

    // -------------------------

    keyGenService.disposeHashGenerator(hasherForOldNodes);
    keyGenService.disposeHashGenerator(hasherForNewNodes);

    // -------------------------

    return preparedUpdates;
  }
}
