import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/renderer/dumb_node_validator.dart';
import 'package:rad/src/core/renderer/job_queue.dart';
import 'package:rad/src/core/renderer/render_node.dart';
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
      disposeWidget(
        context: widgetObject.context,
        flagPreserveTarget: false,
      );
    }

    document.getElementById(rootContext.appTargetId)?.innerHtml = '';
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

    // create temp nodes for holding new widgets

    var tempDomNode = document.createElement('div');
    var tempRenderNode = RenderNode(parentContext);

    // build widgets under temp nodes

    buildWidgetsUnderContext(
      widgets: widgets,
      parentElement: tempDomNode,
      parentRenderNode: tempRenderNode,
      jobQueue: queue,
    );

    // mount widgets from temp nodes

    mountWidgets(
      parentContext: parentContext,
      mountAtIndex: mountAtIndex,
      containerElement: tempDomNode,
      containerRenderNode: tempRenderNode,
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

  void disposeWidget({
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

    disposeWidgetObject(
      widgetObject: services.walker.getWidgetObject(context),
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
  WidgetObject createWidgetObject({
    required Widget widget,
    required BuildContext parentContext,
    required JobQueue jobQueue,
  }) {
    // 1. Create key

    var key = services.keyGen.computeWidgetKey(
      widget: widget,
      parentContext: parentContext,
    );

    // 2. Create context

    var context = BuildContext.fromParent(
      key: key,
      widget: widget,
      parentContext: parentContext,
    );

    // 3. Create render node, config and render object of widget

    var renderNode = RenderNode(context);
    var configuration = widget.createConfiguration();
    var renderObject = widget.createRenderObject(context);

    // 4. Create dom node(if widget.correspondingTag is non-null)

    Element? domNode;

    var tagName = widget.correspondingTag?.nativeName;

    if (null != tagName) {
      domNode = document.createElement(tagName);
    }

    // 5. Wrap all objects in single object

    var widgetObject = WidgetObject(
      widget: widget,
      context: context,
      domNode: domNode,
      configuration: configuration,
      renderNode: renderNode,
      renderObject: renderObject,
    );

    services.walker.registerWidgetObject(widgetObject);

    // 6. Create description

    var description = renderObject.render(
      configuration: configuration,
    );

    widgetObject.frameworkRebindElementDescription(description);

    // 7. Apply description(if widget has a associated dom dom node)

    if (null != domNode) {
      // without queue as dom node is in mem
      applyDescription(domNode: domNode, description: description);
    }

    // 8. Register event listeners

    services.events
      ..setupEventListeners(widget.widgetEventListeners)
      ..setupEventListeners(widget.widgetCaptureEventListeners);

    // 9. Register post job callbacks

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

  /// Build widgets under a available parent dom node and parent render node.
  ///
  void buildWidgetsUnderContext({
    required List<Widget> widgets,
    required Element parentElement,
    required RenderNode parentRenderNode,
    required JobQueue jobQueue,
  }) {
    for (final widget in widgets) {
      var widgetObject = createWidgetObject(
        widget: widget,
        parentContext: parentRenderNode.context,
        jobQueue: jobQueue,
      );

      var currentElement = widgetObject.domNode;
      var currentRenderNode = widgetObject.renderNode;

      parentRenderNode.append(currentRenderNode);

      if (null != currentElement) {
        parentElement.append(currentElement);
      }

      if (widget.widgetChildren.isNotEmpty) {
        buildWidgetsUnderContext(
          widgets: widget.widgetChildren,
          parentElement: currentElement ?? parentElement,
          parentRenderNode: currentRenderNode,
          jobQueue: jobQueue,
        );
      }
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
    //
    // -- optionally, if callee already had fetched the parent object --
    //
    WidgetObject? parentObject,
    //
  }) {
    if (null == parentObject) {
      parentObject = services.walker.getWidgetObject(
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
    }

    var updates = prepareUpdates(
      widgets: widgets,
      parentNode: parentObject.renderNode,
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

          disposeWidget(
            jobQueue: jobQueue,
            flagPreserveTarget: false,
            context: updateObject.existingRenderNode.context,
          );

          break;

        case WidgetUpdateType.cleanParent:
          updateObject as WidgetUpdateObjectActionCleanParent;

          cleanParentContents(
            parentContext: parentContext,
            jobQueue: jobQueue,
          );

          break;

        case WidgetUpdateType.add:
          updateObject as WidgetUpdateObjectActionAdd;

          if (services.debug.widgetLogs) {
            print(
              'Add ${updateObject.widgets.length} missing widgets: '
              ' under: $parentContext',
            );
          }

          render(
            jobQueue: jobQueue,
            widgets: updateObject.widgets,
            mountAtIndex: updateObject.mountAtIndex,
            parentContext: parentContext,
            flagCleanParentContents: false,
          );

          break;

        case WidgetUpdateType.addAllWithoutClean:
          updateObject as WidgetUpdateObjectActionAddAllWithoutClean;

          render(
            mountAtIndex: null,
            widgets: updateObject.widgets,
            parentContext: parentContext,
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
        Element? domNodeToReMount;

        if (widgetObject.hasDomNode) {
          domNodeToReMount = widgetObject.domNode;
        } else {
          domNodeToReMount = services.walker.findClosestDomNodeInDescendants(
            widgetObject.context,
          );
        }

        var parentNode = matchedNode.parent;

        if (null != parentNode) {
          parentNode.insertAt(
            matchedNode,
            updateObject.newMountAtIndex,
          );

          jobQueue.addJob(() {
            if (null == domNodeToReMount) {
              return;
            }

            var parentElement = domNodeToReMount.parent;

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
                  domNodeToReMount,
                  parentElement.children[newMountAtIndex],
                );
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

      var updateTypeForChildWidgets = updateType;

      if (UpdateType.dependencyChanged == updateType) {
        updateTypeForChildWidgets = UpdateType.undefined;
      } else if (UpdateType.visitorUpdate == updateType) {
        updateTypeForChildWidgets = UpdateType.undefined;
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
        var domNode = widgetObject.domNode;

        if (null != domNode) {
          applyDescription(
            jobQueue: jobQueue,
            description: newDescription,
            domNode: domNode,
          );
        }
      } else {
        if (services.debug.widgetLogs) {
          print('Skipped: ${widgetObject.context}');
        }
      }

      /*
      |------------------------------------------------------------------------
      | run update on child nodes
      |
      | there are two types of child a widget can have:
      |
      | - direct(provided in widget's widgetChildren getter)
      | - non-direct(rendered by the widget's state)
      |
      | we run updateWidgetsUnderContext() only if there are direct childs 
      | because framework is not responsible for dispatching updates to 
      | non-direct childs of a widget.
      |------------------------------------------------------------------------
      */

      // whether old widget happen to have direct child widgets
      var hadDirectChilds = oldWidget.widgetChildren.isNotEmpty;

      // whether new widget has direct childs
      var hasDirectChilds = updateObject.widget.widgetChildren.isNotEmpty;

      // if widget has or had direct childs, run update
      if (hasDirectChilds || hadDirectChilds) {
        updateWidgetsUnderContext(
          jobQueue: jobQueue,
          updateType: updateTypeForChildWidgets,
          parentContext: widgetObject.context,
          parentObject: widgetObject,
          flagAddIfNotFound: flagAddIfNotFound,
          widgets: updateObject.widget.widgetChildren,
        );
      }
    } else {
      services.debug.exception(Constants.coreError);
    }
  }

  /// Mount widgets.
  ///
  /// This process mount both the render nodes and HTML dom nodes on Render tree
  /// and DOM respectively. Updates on Render tree are synchoronous while DOM
  /// updates are queued and dispatched in a batch.
  ///
  void mountWidgets({
    required JobQueue jobQueue,
    required int? mountAtIndex,
    required Element containerElement,
    required RenderNode containerRenderNode,
    required BuildContext parentContext,
  }) {
    var parentWidgetObject = services.walker.getWidgetObject(
      parentContext,
    );

    // 1. Add nodes to render tree

    var firstRenderNodeInNewWidgets = containerRenderNode.children.first;

    if (null != parentWidgetObject) {
      if (null != mountAtIndex) {
        //
        // mount at specific index
        //
        var index = mountAtIndex - 1;
        for (final node in [...containerRenderNode.children]) {
          index++;

          parentWidgetObject.renderNode.insertAt(node, index);
        }
      } else {
        //
        // append
        //
        for (final node in [...containerRenderNode.children]) {
          parentWidgetObject.renderNode.append(node);
        }
      }
    }

    // 2. Find closest widget that has an dom node in dom and get mount location

    if (null != parentWidgetObject) {
      if (!parentWidgetObject.hasDomNode) {
        // if parent has no dom node and mountAtIndex is null then its a
        // widgetbuildtask for in-direct child widgets.
        //
        // e.g a stateful widget doesn't have direct childs but issue a build
        // widgets task for in-direct childs. those indirect childs has to be
        // mounted on a specific position in parent's dom node
        var requiresMountAtSpecificPosition = null == mountAtIndex;

        // a render node in path between parent render node(that has dom
        // node) and the widget that we're going to mount. this render node is
        // immediate to parent render node.
        var immediateRenderNode = firstRenderNodeInNewWidgets;

        while (true) {
          if (null == parentWidgetObject) {
            break;
          }

          if (parentWidgetObject.hasDomNode) {
            break;
          }

          immediateRenderNode = parentWidgetObject.renderNode;

          parentContext = parentWidgetObject.context.parent;

          parentWidgetObject = services.walker.getWidgetObject(parentContext);
        }

        if (requiresMountAtSpecificPosition && null != parentWidgetObject) {
          mountAtIndex = parentWidgetObject.renderNode.children.indexOf(
            immediateRenderNode,
          );
        }
      }
    }

    // 3. Get dom node for mounting

    Element? mountTargetDomNode;

    if (null != parentWidgetObject) {
      mountTargetDomNode = parentWidgetObject.domNode;
    } else {
      mountTargetDomNode = document.getElementById(parentContext.key.value);
    }

    if (null == mountTargetDomNode) {
      services.debug.exception(
        'Unable to locate target dom node #${parentContext.key.value} in HTML'
        ' document',
      );

      return;
    }

    // 4. Prepare new dom nodes for mounting

    var documentFragment = DocumentFragment();

    for (final node in [...containerElement.childNodes]) {
      documentFragment.append(node);
    }

    // 5. Add a mount job

    jobQueue.addJob(() {
      if (null == mountTargetDomNode) {
        return;
      }

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
    required BuildContext parentContext,
    required WidgetActionsBuilder widgetActionCallback,
    required bool flagIterateInReverseOrder,
  }) {
    var widgetObject = services.walker.getWidgetObject(
      parentContext,
    );

    if (null == widgetObject) {
      return const [];
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
          var domNode = widgetActionObject.widgetObject.context.findDomNode();

          jobQueue.addJob(() {
            domNode.classes.remove(
              Constants.classHidden,
            );
          });

          break;

        case WidgetAction.hideWidget:
          var domNode = widgetActionObject.widgetObject.context.findDomNode();

          jobQueue.addJob(() {
            domNode.classes.add(
              Constants.classHidden,
            );
          });

          break;

        case WidgetAction.dispose:
          disposeWidget(
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
          var domNode = widgetObject.domNode;

          if (null != domNode) {
            applyDescription(
              jobQueue: jobQueue,
              description: newDescription,
              domNode: domNode,
            );
          }

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

  /// Clean existing widgets/dom nodes
  ///
  void cleanParentContents({
    required BuildContext parentContext,
    required JobQueue jobQueue,
  }) {
    var parentWidgetObject = services.walker.getWidgetObject(
      parentContext,
    );

    disposeWidgetObject(
      widgetObject: parentWidgetObject,
      flagPreserveTarget: true,
      flagEnqeueChildElementRemoval: false,
      jobQueue: jobQueue,
    );

    jobQueue.addJob(() {
      Element? parentElement;

      if (null != parentWidgetObject) {
        parentElement = parentWidgetObject.domNode;
      } else {
        parentElement = document.getElementById(parentContext.key.value);
      }

      parentElement?.innerHtml = '';
    });
  }

  /// Dispose widget object and descendants.
  ///
  /// [flagPreserveTarget] - Whether to remove descendants but preserve the
  /// widget itself.
  ///
  /// [flagEnqeueTargetElementRemoval] - Whether to remove [widgetObject]'s
  /// dom node from DOM by making a explict call to domNode.remove
  ///
  /// [flagEnqeueChildElementRemoval] - Whether to remove ecah children of
  /// [widgetObject] from DOM by making a explict call to domNode.remove
  ///
  void disposeWidgetObject({
    WidgetObject? widgetObject,
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
    if (null == widgetObject) {
      return;
    }

    // cascade dispose to its childs first

    var children = widgetObject.renderNode.children;

    if (children.isNotEmpty) {
      for (final childElement in [...children]) {
        disposeWidgetObject(
          widgetObject: services.walker.getWidgetObject(
            childElement.context,
          ),
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
        var domNode = widgetObject.domNode;

        if (null != domNode) {
          jobQueue.addJob(domNode.remove);
        }
      }

      widgetObject
        ..renderObject.beforeUnMount()
        ..renderNode.detach();

      services.walker.unRegisterWidgetObject(widgetObject);

      if (services.debug.widgetLogs) {
        print('Dispose: ${widgetObject.context}');
      }
    }
  }

  void applyDescription({
    required Element domNode,
    DomNodeDescription? description,
    JobQueue? jobQueue,
  }) {
    if (null == description) {
      return;
    }

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
    required RenderNode parentNode,
    required BuildContext parentContext,
    required bool flagAddIfNotFound,
  }) {
    // If there are no new widgets, dispose all the old ones

    if (widgets.isEmpty) {
      return _prepareUpdatesDisposeAll(
        parentNode: parentNode,
        flagAddIfNotFound: flagAddIfNotFound,
      );
    }

    // If there are no old widgets, add all the new ones

    if (parentNode.children.isEmpty) {
      return _prepareUpdatesAddAllWithoutClean(
        widgets: widgets,
        flagAddIfNotFound: flagAddIfNotFound,
      );
    }

    return _prepareUpdatesUsingRadAlgo(
      widgets: widgets,
      parent: parentNode,
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
    required RenderNode parentNode,
    required bool flagAddIfNotFound,
  }) {
    // if there are no old childs to dispose
    if (parentNode.children.isEmpty) {
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
    required RenderNode parent,
    required BuildContext parentContext,
    required bool flagAddIfNotFound,
  }) {
    // -------------------------

    var keyGenService = services.keyGen;

    var hasherForOldNodes = keyGenService.createCompatibilityHashGenerator();
    var hasherForNewNodes = keyGenService.createCompatibilityHashGenerator();

    // -------------------------

    // Widgetkey's hash : System action to take
    var widgetSystemActions = <String, WidgetUpdateObject>{};

    var oldRenderNodesHashMap = <String, RenderNode>{};
    var oldRenderNodesPositions = <String, int>{};
    var oldRenderNodesHashRegistry = <String, String>{};

    // --------------------------------------------------
    // Phase-1 | Collect data from old nodes
    // --------------------------------------------------

    // prepare hash map from existing render nodes
    var oldPositionIndex = -1;
    for (final node in parent.children) {
      oldPositionIndex++;

      var oldNodeKey = node.context.key;

      //
      // Unique hash. Can be used to find a matching widget at the same level of
      // tree.
      //
      var oldNodeHash = hasherForOldNodes.createCompatibilityHash(
        widgetKey: oldNodeKey,
        widgetRuntimeType: node.context.widgetRuntimeType,
      );

      // register hash
      oldRenderNodesHashRegistry[oldNodeKey.value] = oldNodeHash;

      oldRenderNodesPositions[oldNodeHash] = oldPositionIndex;
      oldRenderNodesHashMap[oldNodeHash] = node;
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

      var newKey = keyGenService.computeWidgetKey(
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

        widgetSystemActions[newNodeHash] = lastAddedWidgetAction;

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

    // --------------------------------------------------
    // Phase-3 | Deal with obsolute nodes
    // --------------------------------------------------

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

    keyGenService.disposeHashGenerator(hasherForOldNodes);
    keyGenService.disposeHashGenerator(hasherForNewNodes);

    // -------------------------

    return preparedSystemActions;
  }
}
