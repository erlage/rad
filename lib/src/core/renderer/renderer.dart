import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/renderer/job_queue.dart';
import 'package:rad/src/core/renderer/render_node.dart';
import 'package:rad/src/core/renderer/tree_fragment.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/renderer/widget_action_object.dart';
import 'package:rad/src/core/renderer/widget_update_object.dart';
import 'package:rad/src/core/common/objects/element_description.dart';

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

    for (var widgetObject in widgetObjects) {
      disposeWidgets(
        context: widgetObject.context,
        flagPreserveTarget: false,
      );
    }

    document.getElementById(rootContext.appTargetId)?.innerHtml = '';
  }

  /// Create a key for widget.
  ///
  GlobalKey createWidgetKey(Widget widget, BuildContext parentContext) {
    GlobalKey generatedKey;

    // whether key is provided explicitly in widget constructor

    var isKeyProvided = Constants.contextKeyNotSet != widget.initialKey;

    // ensure key is not using system prefix
    // if in dev mode

    if (services.debug.additionalChecks) {
      if (isKeyProvided && widget.initialKey.hasSystemPrefix) {
        services.debug.exception(
          'Keys starting with ${Constants.contextGenKeyPrefix} are reserved '
          'for framework.',
        );
      }
    }

    if (isKeyProvided) {
      generatedKey = services.keyGen.getGlobalKeyUsingKey(
        widget.initialKey,
        parentContext,
      );
    } else {
      generatedKey = services.keyGen.generateGlobalKey();
    }

    return generatedKey;
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
        ..renderObject.beforeMount()
        ..frameworkUpdateMountStatus(true)
        ..renderObject.afterMount();
    });

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
    for (var widget in widgets) {
      var context = BuildContext.fromParent(
        key: createWidgetKey(widget, parentContext),
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
  /// This function is intedended to be called only by [buildWidgetsUnderFragment].
  /// Calling it on a parent context whos element is mounted on real document
  /// will slow down things.
  ///
  void buildWidgetsAndActivelyLinkElements({
    required List<Widget> widgets,
    required BuildContext parentContext,
    required WidgetObject parentWidgetObject,
    required JobQueue jobQueue,
  }) {
    for (var widget in widgets) {
      var context = BuildContext.fromParent(
        key: createWidgetKey(widget, parentContext),
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

    // list of updates  {Node index}: existing {WidgetObject}

    var updateObjects = prepareUpdates(
      widgets: widgets,
      parent: parentNode,
      parentContext: parentContext,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    // deal with obsolute nodes

    for (final childElement in [...parentNode.children]) {
      if (!updateObjects.containsKey(childElement.context.key.value)) {
        disposeWidgets(
          jobQueue: jobQueue,
          flagPreserveTarget: false,
          context: childElement.context,
        );
      }
    }

    // publish widget updates

    var index = -1;
    for (var updateObject in updateObjects.values) {
      index++;

      var newWidget = updateObject.widget;
      var matchedNode = updateObject.node;

      if (null != matchedNode) {
        var widgetObject = services.walker.getWidgetObject(
          matchedNode.context,
        );

        if (null != widgetObject) {
          var oldWidget = widgetObject.widget;

          if (UpdateType.dependencyChanged == updateType) {
            // if it's a inherited widget update, we allow immediate childs
            // to build without checking whether they are const or not.

            // but if they further have child widgets of their owns, we want
            // the framework to short-circuit rebuild if possible, this can be
            // acheived by resetting update type to something else

            updateType = UpdateType.undefined;
          } else {
            if (oldWidget == newWidget) {
              if (services.debug.frameworkLogs) {
                print(
                  'Short-circuit rebuild: ${widgetObject.context}',
                );

                continue;
              }
            }
          }

          // check whether anything else has to be updated.
          var oldConfiguration = widgetObject.configuration;
          var isChanged = newWidget.isConfigurationChanged(oldConfiguration);

          if (isChanged) {
            var newConfiguration = newWidget.createConfiguration();

            widgetObject
              ..frameworkRebindWidget(newWidget)
              ..frameworkRebindWidgetConfiguration(newConfiguration);

            widgetObject.renderObject.afterWidgetRebind(
              newWidget: newWidget,
              oldWidget: oldWidget,
              updateType: updateType,
            );

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
            if (oldWidget.shouldAlwaysRebindWidget) {
              widgetObject
                ..frameworkRebindWidget(newWidget)
                ..renderObject.afterWidgetRebind(
                  updateType: updateType,
                  oldWidget: oldWidget,
                  newWidget: newWidget,
                );
            }

            if (services.debug.widgetLogs) {
              print('Skipped: ${widgetObject.context}');
            }
          }

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
        }
      } else {
        if (services.debug.widgetLogs) {
          print(
            'Add missing child of type: ${updateObject.widget.runtimeType}'
            ' under: $parentContext',
          );
        }

        render(
          jobQueue: jobQueue,
          widgets: [newWidget],
          mountAtIndex: index,
          parentContext: parentContext,
          flagCleanParentContents: false,
        );
      }
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
        for (var node in treeFragment.renderNodes) {
          index++;

          parentWidgetObject.renderNode.insertAt(node, index);
        }
      } else {
        //
        // append
        //
        for (var node in treeFragment.renderNodes) {
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
          'Unable to locate target element #${parentContext.key.value} in HTML document',
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

  /// Prepare updates.
  ///
  Map<String, WidgetUpdateObject> prepareUpdates({
    required RenderNode parent,
    required List<Widget> widgets,
    required BuildContext parentContext,
    required bool flagAddIfNotFound,
  }) {
    var updateObjects = <String, WidgetUpdateObject>{};

    var nodes = <RenderNode>[];
    var poppedNodes = <RenderNode>[];
    var hashedNodes = <String, RenderNode>{}; // for hash join

    // prepare list of existing nodes

    for (var node in parent.children.reversed) {
      if (node.context.key.hasSystemPrefix) {
        nodes.add(node);
      } else {
        hashedNodes[node.matchKey] = node;
      }
    }

    for (var newWidget in widgets) {
      //
      // prepare new widget's data for matching
      //
      var newWidgetRuntimeType = '${newWidget.runtimeType}';
      var newWidgetHasKey = Constants.contextKeyNotSet != newWidget.initialKey;
      var newWidgetId = services.keyGen
          .getGlobalKeyUsingKey(
            newWidget.initialKey,
            parentContext,
          )
          .value;

      // id of element that's matched with the current widget
      //
      RenderNode? matchedNode;

      if (newWidgetHasKey) {
        //
        // do hash join
        //
        var hashKey = '$newWidgetRuntimeType$newWidgetId';

        matchedNode = hashedNodes[hashKey];

        //
        //
      } else {
        //
        // do merge join(kind of)
        //
        while (true) {
          //
          if (nodes.isNotEmpty) {
            //
            // get element
            //
            var node = nodes.removeLast();

            var oldWidgetRuntimeType = node.context.widgetRuntimeType;
            //
            // try matching runtime types
            //
            if (oldWidgetRuntimeType == newWidgetRuntimeType) {
              //
              // widget matched!
              //
              matchedNode = node;

              break;
            }
            //
            // else add current element to popped list
            //
            poppedNodes.add(node);
            //
          } else {
            //
            // widget doesn't match with any element
            // reset popped elements for next widget
            //
            if (poppedNodes.isNotEmpty) {
              nodes.addAll(poppedNodes.reversed);

              poppedNodes = [];
            }

            // current widget has to be rendered from scratch
            // as it failed to match any element(popped all)
            // so break for current widget
            //
            break;
          }
        }
      }

      if (null != matchedNode) {
        //
        // if a matching element found
        //
        updateObjects[matchedNode.context.key.value] = WidgetUpdateObject(
          newWidget,
          matchedNode,
        );
      } else {
        //
        // else add if flags are correct
        //
        if (flagAddIfNotFound) {
          var newKey = services.keyGen.generateRandomKey();

          updateObjects[newKey] = WidgetUpdateObject(newWidget, null);
        }
      }
    }

    return updateObjects;
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

      if (description.classes.isNotEmpty) {
        description.classes.forEach((className, whetherToAdd) {
          if (whetherToAdd) {
            element.classes.add(className);
          } else {
            element.classes.remove(className);
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

      description.eventListenersToRemove.forEach((key, value) {
        element.removeEventListener(fnMapDomEventType(key), value);
      });

      description.eventListenersToAdd.forEach((key, value) {
        element.addEventListener(fnMapDomEventType(key), value);
      });
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
