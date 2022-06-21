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
import 'package:rad/src/core/renderer/reconciler.dart';
import 'package:rad/src/core/renderer/widget_action_object.dart';
import 'package:rad/src/core/renderer/widget_update_object.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Renderer.
///
class Renderer with ServicesResolver {
  /// Root context.
  ///
  final BuildContext rootContext;

  /// Reconciler instance.
  ///
  final reconciler = Reconciler();

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
      cleanRenderElement(
        renderElement: parentRenderElement,
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
    //
    // whether to preserve the widget itself
    //
    required bool flagPreserveTarget,
    //
    // -- optional --
    //
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    // ------------------------------------ //

    if (flagPreserveTarget) {
      cleanRenderElement(
        renderElement: renderElement,
        jobQueue: queue,
      );
    } else {
      disposeRenderElement(
        renderElement: renderElement,
        jobQueue: queue,
      );
    }

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
    var updates = reconciler.prepareUpdates(
      widgets: widgets,
      parentRenderElement: parentRenderElement,
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

          cleanRenderElement(
            renderElement: parentRenderElement,
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

  /// Clean a render element.
  ///
  void cleanRenderElement({
    required RenderElement renderElement,
    required JobQueue jobQueue,
  }) {
    // Clean associated dom node

    if (renderElement.hasDomNode) {
      jobQueue.addJob(() {
        renderElement.domNode?.innerHtml = '';
      });
    } else {
      // If render element doesn't have a dom node then it's a single child
      // widget and we've to find and remove the nearest dom node in descendants

      var domNode = renderElement.findClosestDomNodeInDescendants();

      if (null != domNode) {
        jobQueue.addJob(() {
          domNode.remove();
        });
      }
    }

    // Detach and dispose child elements

    if (renderElement.frameworkChildElements.isNotEmpty) {
      var childElements = renderElement.frameworkEjectChildRenderElements();

      for (final childElement in childElements) {
        disposeDetachedRenderElement(childElement);
      }
    }
  }

  /// Dispose a render element.
  ///
  void disposeRenderElement({
    required RenderElement renderElement,
    required JobQueue jobQueue,
  }) {
    // Add a job to remove associated dom node

    var domNode = renderElement.domNode;

    // If render element doesn't have a dom node then it's a single child
    // widget and we've to find and remove the nearest dom node in descendants

    domNode ??= renderElement.findClosestDomNodeInDescendants();

    jobQueue.addJob(() {
      domNode?.remove();
    });

    // Detach child elements and add a job to clean child elements

    if (renderElement.frameworkChildElements.isNotEmpty) {
      var childElements = renderElement.frameworkEjectChildRenderElements();

      for (final renderElement in childElements) {
        disposeDetachedRenderElement(renderElement);
      }
    }

    // Detach itself

    renderElement.frameworkDetach();

    // Unregister element

    services.walker.unRegisterElement(renderElement);

    // Call lifecycle hooks

    renderElement.frameworkAfterUnMount();

    if (services.debug.widgetLogs) {
      print('Dispose: $renderElement');
    }
  }

  /// Dispose a detached render element.
  ///
  void disposeDetachedRenderElement(RenderElement renderElement) {
    // Dispose child elements

    for (final childElement in renderElement.frameworkChildElements) {
      disposeDetachedRenderElement(childElement);
    }

    // Unregister element

    services.walker.unRegisterElement(renderElement);

    // Call lifecycle hooks

    renderElement.frameworkAfterUnMount();

    if (services.debug.widgetLogs) {
      print('Dispose: $renderElement');
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
}
