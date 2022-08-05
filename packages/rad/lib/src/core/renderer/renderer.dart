// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
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
@internal
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
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required int? mountAtIndex,
    required bool flagCleanParentContents,
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

    var temporaryRenderElement = TemporaryElement.create(
      services: services,
      futureParentRenderElement: parentRenderElement,
    );

    // build widgets under temp space

    buildWidgetsUnderContext(
      widgets: widgets,
      parentDomNode: temporaryRenderElement.domNode!,
      parentRenderElement: temporaryRenderElement,
      jobQueue: queue,
    );

    // mount widgets from temp space

    mountWidgets(
      parentRenderElement: parentRenderElement,
      mountAtIndex: mountAtIndex,
      temporaryRenderElement: temporaryRenderElement,
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
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required UpdateType updateType,
    required bool flagAddIfNotFound,
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    updateWidgetsUnderContext(
      jobQueue: queue,
      widgets: widgets,
      updateType: updateType,
      parentRenderElement: parentRenderElement,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  /// Re-render a specific widget
  ///
  void reRenderContext({
    required RenderElement renderElement,
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

    var update = WidgetUpdateObjectActionUpdate(
      widget: renderElement.widget,
      widgetPositionIndex: 0, // not-known
      existingRenderElement: renderElement,
      newMountAtIndex: null,
    );

    processWidgetUpdateObjectActionUpdate(
      updateObject: update,
      updateType: UpdateType.dependencyChanged,
      flagAddIfNotFound: true,
      jobQueue: queue,
    );

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
    required RenderElement parentRenderElement,
    required WidgetActionsBuilder widgetActionCallback,
    required UpdateType updateType,
    bool flagIterateInReverseOrder = false,
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

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

    if (null == jobQueue) {
      queue.dispatchJobs();
    }
  }

  void disposeWidget({
    required RenderElement renderElement,
    required bool flagPreserveTarget,
    JobQueue? jobQueue,
  }) {
    var queue = jobQueue ?? JobQueue();

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
    var renderElement = widget.createRenderElement(parentRenderElement);

    Element? domNode;

    var tagName = widget.correspondingTag?.nativeValue;
    if (null != tagName) {
      domNode = document.createElement(tagName);

      renderElement.frameworkBindDomNode(domNode: domNode);
    }

    renderElement.frameworkInitRenderElement();

    // -----------------------------

    var domNodePatch = renderElement.frameworkRender(widget: widget);
    if (null != domNode && null != domNodePatch) {
      applyDomNodePatch(domNode: domNode, description: domNodePatch);
    }

    if (renderElement.frameworkHasEventListenerOfType(
      RenderEventType.didRender,
    )) {
      jobQueue.addPostDispatchCallback(
        () => renderElement.frameworkDispatchRenderEvent(
          RenderEventType.didRender,
        ),
      );
    }

    // -----------------------------

    // Register DOM event listeners

    var bubbleEventListeners = widget.widgetEventListeners;
    var captureEventListeners = widget.widgetCaptureEventListeners;

    if (captureEventListeners.isNotEmpty) {
      services.events.setupEventListeners(captureEventListeners);
    }

    if (bubbleEventListeners.isNotEmpty) {
      services.events.setupEventListeners(bubbleEventListeners);
    }

    if (DEBUG_BUILD) {
      if (services.debug.widgetLogs) {
        print('Build widget: $renderElement');
      }
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

      var widgetChildren = renderElement.widgetChildren;

      if (widgetChildren.isNotEmpty) {
        buildWidgetsUnderContext(
          widgets: widgetChildren,
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

        case WidgetUpdateType.cleanParent:
          updateObject as WidgetUpdateObjectActionCleanParent;

          cleanRenderElement(
            renderElement: parentRenderElement,
            jobQueue: jobQueue,
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

        case WidgetUpdateType.add:
          updateObject as WidgetUpdateObjectActionAdd;

          if (DEBUG_BUILD) {
            if (services.debug.widgetLogs) {
              print(
                'Add ${updateObject.widgets.length} missing widgets: '
                ' under: $parentRenderElement',
              );
            }
          }

          render(
            jobQueue: jobQueue,
            widgets: updateObject.widgets,
            mountAtIndex: updateObject.mountAtIndex,
            parentRenderElement: parentRenderElement,
            flagCleanParentContents: false,
          );

          break;

        case WidgetUpdateType.dispose:
          updateObject as WidgetUpdateObjectActionDispose;

          disposeWidget(
            jobQueue: jobQueue,
            flagPreserveTarget: false,
            renderElement: updateObject.existingElement,
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

    // if it's a inherited widget update, we allow immediate child widgets
    // to build without checking whether they are const or not.
    //
    // or
    //
    // if it's a update from widget visitor, we allow immediate child widgets
    // to build without checking whether they are const or not.

    // but if they further have child widgets of their owns, we want
    // the framework to short-circuit rebuild if possible, this can be
    // achieved by resetting update type to something else

    var updateTypeForChildWidgets = updateType;

    if (UpdateType.dependencyChanged == updateType) {
      updateTypeForChildWidgets = UpdateType.undefined;
    } else if (UpdateType.visitorUpdate == updateType) {
      updateTypeForChildWidgets = UpdateType.undefined;
    } else {
      if (oldWidget == newWidget) {
        if (DEBUG_BUILD) {
          if (services.debug.frameworkLogs) {
            print('Short-circuit: $matchedRenderElement');
          }
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
      if (DEBUG_BUILD) {
        if (services.debug.frameworkLogs) {
          print('Update widget: $matchedRenderElement');
        }
      }

      var domNodePatch = matchedRenderElement.frameworkUpdate(
        updateType: updateType,
        oldWidget: oldWidget,
        newWidget: newWidget,
      );

      if (null != domNodePatch && matchedRenderElement.hasDomNode) {
        jobQueue.addJob(() {
          applyDomNodePatch(
            description: domNodePatch,
            domNode: matchedRenderElement.domNode!,
          );
        });
      }

      if (matchedRenderElement.frameworkHasEventListenerOfType(
        RenderEventType.didUpdate,
      )) {
        jobQueue.addPostDispatchCallback(
          () => matchedRenderElement.frameworkDispatchRenderEvent(
            RenderEventType.didUpdate,
          ),
        );
      }
    } else {
      if (DEBUG_BUILD) {
        if (services.debug.widgetLogs) {
          print('Skipped: $matchedRenderElement');
        }
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
        widgets: matchedRenderElement.widgetChildren,
      );
    }
  }

  /// Mount widgets.
  ///
  /// This process mount both the elements and HTML dom nodes on element tree
  /// and DOM respectively. Updates on element tree are synchronous while DOM
  /// updates are queued and dispatched in a batch.
  ///
  void mountWidgets({
    required TemporaryElement temporaryRenderElement,
    required RenderElement parentRenderElement,
    required int? mountAtIndex,
    required JobQueue jobQueue,
  }) {
    /*
    |--------------------------------------------------------------------------
    | Prepare
    |--------------------------------------------------------------------------
    */

    var renderElements = temporaryRenderElement.frameworkChildElements;

    var firstRenderElementInNewWidgets = renderElements.first;

    /*
    |--------------------------------------------------------------------------
    | Add nodes to element tree
    |--------------------------------------------------------------------------
    */

    if (null == mountAtIndex) {
      parentRenderElement.frameworkAppendAllFresh(renderElements);
    } else {
      parentRenderElement.frameworkInsertAllFreshAt(
        renderElements,
        mountAtIndex,
      );
    }

    // 2. Find closest widget that has an dom node in dom and get mount location

    var currentParentRenderElement = parentRenderElement;

    if (!currentParentRenderElement.hasDomNode) {
      // if parent has no dom node and mountAtIndex is null then its a
      // WidgetBuildTask for in-direct child widgets.
      //
      // e.g a stateful widget doesn't have direct child widgets but issue a
      // build widgets task for in-direct child widgets. those indirect child
      // widgets has to be mounted on a specific position in parent's dom node
      // when changed or added
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
      if (DEBUG_BUILD) {
        services.debug.exception(
          'Unable to locate target dom node #$currentParentRenderElement in '
          'HTML document',
        );
      }

      return;
    }

    // 4. Prepare new dom nodes for mounting

    var documentFragment = DocumentFragment();

    for (final node in temporaryRenderElement.domNode!.children) {
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

          var domPatch = renderElement.frameworkUpdate(
            updateType: updateType,
            newWidget: widget,
            oldWidget: widget,
          ); // bit of mess ^ but required

          if (null != domPatch && renderElement.hasDomNode) {
            jobQueue.addJob(() {
              applyDomNodePatch(
                description: domPatch,
                domNode: renderElement.domNode!,
              );
            });
          }

          if (renderElement.frameworkHasEventListenerOfType(
            RenderEventType.didUpdate,
          )) {
            jobQueue.addPostDispatchCallback(
              () => renderElement.frameworkDispatchRenderEvent(
                RenderEventType.didUpdate,
              ),
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
              widgets: renderElement.widgetChildren,
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
        disposeDetachedRenderElement(
          renderElement: childElement,
          jobQueue: jobQueue,
        );
      }
    }
  }

  /// Dispose a render element.
  ///
  void disposeRenderElement({
    required RenderElement renderElement,
    required JobQueue jobQueue,
  }) {
    var domNode = renderElement.domNode;

    // If render element doesn't have a dom node then it's a single child
    // widget and we've to find and remove the nearest dom node in descendants

    domNode ??= renderElement.findClosestDomNodeInDescendants();

    jobQueue.addJob(() {
      domNode?.remove();
    });

    // Detach child elements

    if (renderElement.frameworkChildElements.isNotEmpty) {
      var childElements = renderElement.frameworkEjectChildRenderElements();

      if (renderElement.frameworkContainsUnMountListeners) {
        for (final renderElement in childElements) {
          disposeDetachedRenderElement(
            renderElement: renderElement,
            jobQueue: jobQueue,
          );
        }
      }
    }

    // Detach itself

    renderElement.frameworkDetach();

    // Call lifecycle hooks

    renderElement.frameworkDispatchRenderEvent(
      RenderEventType.willUnMount,
    );

    if (renderElement.frameworkHasEventListenerOfType(
      RenderEventType.didUnMount,
    )) {
      jobQueue.addPostDispatchCallback(
        () => renderElement.frameworkDispatchRenderEvent(
          RenderEventType.didUnMount,
        ),
      );
    }

    if (DEBUG_BUILD) {
      if (services.debug.widgetLogs) {
        print('Dispose: $renderElement');
      }
    }
  }

  /// Dispose a detached render element.
  ///
  void disposeDetachedRenderElement({
    required RenderElement renderElement,
    required JobQueue jobQueue,
  }) {
    if (renderElement.frameworkContainsUnMountListeners) {
      for (final childElement in renderElement.frameworkChildElements) {
        disposeDetachedRenderElement(
          renderElement: childElement,
          jobQueue: jobQueue,
        );
      }
    }

    renderElement.frameworkDispatchRenderEvent(
      RenderEventType.willUnMount,
    );

    if (renderElement.frameworkHasEventListenerOfType(
      RenderEventType.didUnMount,
    )) {
      jobQueue.addPostDispatchCallback(
        () => renderElement.frameworkDispatchRenderEvent(
          RenderEventType.didUnMount,
        ),
      );
    }

    if (DEBUG_BUILD) {
      if (services.debug.widgetLogs) {
        print('Dispose: $renderElement');
      }
    }
  }

  void applyDomNodePatch({
    required Element domNode,
    required DomNodePatch description,
  }) {
    var attributes = description.attributes;
    var properties = description.properties;

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

    if (null != properties && properties.isNotEmpty) {
      properties.forEach((key, value) {
        switch (key) {
          case Properties.value:

            // implemented only for
            // - Input elements
            // - TextArea elements

            if (domNode is InputElement) {
              domNode.value = value ?? '';

              break;
            }

            if (domNode is TextAreaElement) {
              domNode.value = value ?? '';
            }

            break;

          case Properties.innerText:
            domNode.innerText = value ?? '';

            break;

          case Properties.innerHtml:
            domNode.setInnerHtml(value, validator: const DumbNodeValidator());

            break;
        }
      });
    }
  }
}
