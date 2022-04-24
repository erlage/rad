import 'dart:html';

import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_action_object.dart';
import 'package:rad/src/core/common/objects/widget_update_object.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_dispose_task.dart';
import 'package:rad/src/core/services/scheduler/events/send_next_task_event.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';

class Framework with ServicesResolver {
  final BuildContext rootContext;

  var _taskListenerKey = '';
  var _isTaskInProcessing = false;

  Services get services => resolveServices(rootContext);

  Framework(this.rootContext);

  /// Initialize framework state.
  ///
  void initState() {
    _taskListenerKey = services.keyGen.generateRandomKey();

    services.scheduler.addTaskListener(_taskListenerKey, processTask);
  }

  /// Dispose framework state.
  ///
  void dispose() {
    var widgetKeys = services.walker.dumpWidgetKeys();

    for (var widgetKey in widgetKeys) {
      disposeWidget(
        renderObject: services.walker.getRenderObject(widgetKey),
      );
    }

    services.scheduler.removeTaskListener(_taskListenerKey);
  }

  /// Process a scheduled task.
  ///
  void processTask(SchedulerTask task) {
    if (_isTaskInProcessing) {
      return;
    }

    try {
      _isTaskInProcessing = true;

      if (null != task.beforeTaskCallback) {
        task.beforeTaskCallback!();
      }

      _runTask(task);

      if (null != task.afterTaskCallback) {
        task.afterTaskCallback!();
      }
    } finally {
      _isTaskInProcessing = false;

      services.scheduler.addEvent(SendNextTaskEvent(_taskListenerKey));
    }
  }

  /// Build children under given context.
  ///
  void buildChildren({
    // widgets to build
    required List<Widget> widgets,
    required BuildContext parentContext,
    //
    // -- options --
    //
    int? mountAtIndex, // Parent's children list index
    //
    // -- flags --
    //
    flagCleanParentContents = true,
    //
  }) {
    if (widgets.isEmpty) {
      return;
    }

    if (flagCleanParentContents) {
      _cleanContext(parentContext);
    }

    _buildWidgetsUnderContext(
      widgets: widgets,
      parentContext: parentContext,
      mountAtIndex: mountAtIndex,
    );
  }

  /// Manage child widgets.
  ///
  /// Method will call [widgetActionCallback] for each child's widget object.
  /// Whatever action the [widgetActionCallback] callback returns, framework
  /// will execute it.
  ///
  void manageChildren({
    required BuildContext parentContext,
    required WidgetActionCallback widgetActionCallback,
    //
    // -- options --
    //
    required UpdateType updateType,
    //
    // -- flags --
    //
    bool flagIterateInReverseOrder = false,
  }) {
    var widgetActions = _prepareWidgetActions(
      parentContext: parentContext,
      flagIterateInReverseOrder: flagIterateInReverseOrder,
      widgetActionCallback: widgetActionCallback,
    );

    _dispatchWidgetActions(
      parentContext: parentContext,
      widgetActions: widgetActions,
      updateType: updateType,
    );
  }

  /// Update a dependent widget(using its context).
  ///
  void updateDependentContext(BuildContext context) {
    var renderObject = services.walker.getRenderObject(context.key.value);

    if (null != renderObject) {
      renderObject.update(
        element: renderObject.context.element,
        updateType: UpdateType.dependencyChanged,
        //
        // it's a change in dependency not configuration,
        // so both are same configurations are same
        //
        oldConfiguration: renderObject.context.configuration,
        newConfiguration: renderObject.context.configuration,
      );
    }
  }

  /// Update childrens under provided context.
  ///
  void updateChildren({
    // widgets to build
    required List<Widget> widgets,
    required BuildContext parentContext,
    //
    // -- options --
    //
    required UpdateType updateType,
    //
    // -- flags for special nodes --
    //
    flagHideObsoluteChildren = false,
    flagDisposeObsoluteChildren = true,
    //
    // -- flags for widgets that aren't found in tree --
    //
    flagAddIfNotFound = true, // add childs right where they are missing
    flagAddAsAppendMode = false, // append mode, always add childs to the end
    //
    // -- hard flags, can cause subtree rebuilds --
    //
    flagTolerateChildrenCountMisMatch = true,
    //
  }) {
    if (widgets.isEmpty) return;

    // convenience function that dispatches complete rebuild.

    void dispatchCompleteRebuild() {
      buildChildren(
        widgets: widgets,
        parentContext: parentContext,
      );
    }

    var parent = document.getElementById(parentContext.key.value);

    if (null == parent) {
      return dispatchCompleteRebuild();
    }

    // ensure children count match if flag is on

    if (!flagTolerateChildrenCountMisMatch) {
      if (parent.children.length != widgets.length) {
        return dispatchCompleteRebuild();
      }
    }

    // list of updates  {Node index}: existing {WidgetObject}

    var updateObjects = <String, WidgetUpdateObject>{};

    // prepare updates

    widgetLoop:
    for (final widget in widgets) {
      for (final child in parent.children) {
        var isAlreadySelectedForUpdate = updateObjects.containsKey(child.id);

        if (!isAlreadySelectedForUpdate) {
          // whether old and new widgets has same type.

          var newWidgetRuntimeType = "${widget.runtimeType}";
          var oldWidgetRuntimeType = child.dataset[Constants.attrRuntimeType];

          if (oldWidgetRuntimeType == newWidgetRuntimeType) {
            // assume we are going to replace old widget with new one

            var shouldUpdate = true;

            // check whether old or new widget has keys

            var hadKey = !child.id.startsWith(Constants.contextGenKeyPrefix);
            var hasKey = Constants.contextKeyNotSet != widget.initialKey;

            // if any one of them has/had keys, then try matching keys

            if (hasKey || hadKey) {
              var globalKey = services.keyGen.getGlobalKeyUsingKey(
                widget.initialKey,
                parentContext,
              );

              if (globalKey.value != child.id) {
                // key not matched
                // skip this one

                shouldUpdate = false;
              }
            }

            if (shouldUpdate) {
              updateObjects[child.id] = WidgetUpdateObject(widget, child.id);

              continue widgetLoop;
            }
          }
        }
      }

      // child is missing

      if (!flagTolerateChildrenCountMisMatch) {
        return dispatchCompleteRebuild();
      }

      // if flag is on for missing childs

      if (flagAddIfNotFound) {
        var randomKey = "_${services.keyGen.generateRandomKey()}";

        updateObjects[randomKey] = WidgetUpdateObject(widget, null);
      }
    }

    // deal with obsolute nodes

    if (flagHideObsoluteChildren || flagDisposeObsoluteChildren) {
      for (final childElement in parent.children) {
        if (!updateObjects.containsKey(childElement.id)) {
          if (flagDisposeObsoluteChildren) {
            disposeWidget(
              renderObject: services.walker.getRenderObject(childElement.id),
              flagPreserveTarget: false,
            );
          } else if (flagHideObsoluteChildren) {
            _hideElement(childElement);
          }
        }
      }
    }

    // publish widget updates

    var updateIndex = updateObjects.keys.toList();

    updateIndex.asMap().forEach((index, elementId) {
      var updateObject = updateObjects[elementId]!;

      if (null != updateObject.existingElementId) {
        var renderObject = services.walker.getRenderObject(elementId);

        // if found

        if (null != renderObject) {
          var newWidget = updateObject.widget;

          var oldWidget = renderObject.context.widget;

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
                  "Short-circuit rebuild: ${renderObject.context}",
                );

                return;
              }
            }
          }

          var oldConfiguration = renderObject.context.configuration;

          var isChanged = newWidget.isConfigurationChanged(oldConfiguration);

          if (isChanged) {
            var newConfiguration = newWidget.createConfiguration();

            renderObject.context.frameworkRebindConfiguration(newConfiguration);

            renderObject.context.frameworkRebindWidget(newWidget);

            // call hook

            renderObject.afterWidgetRebind(updateType, oldWidget);

            // publish update

            renderObject.update(
              updateType: updateType,
              element: renderObject.context.element,
              newConfiguration: newConfiguration,
              oldConfiguration: oldConfiguration,
            );
          } else {
            if (services.debug.widgetLogs) {
              print("Skipped: ${renderObject.context}");
            }
          }

          // whether old widget happen to have child widgets
          var hadChilds = oldWidget.widgetChildren.isNotEmpty;

          // whether new widget has any childs
          var hasChilds = updateObject.widget.widgetChildren.isNotEmpty;

          // if new widget has no childs but old had, we have to remove
          // those orphan childs.

          if (hadChilds && !hasChilds) {
            disposeWidget(renderObject: renderObject, flagPreserveTarget: true);
          } else {
            // else update childs
            // doesn't matter whether new has or not.

            updateChildren(
              widgets: updateObject.widget.widgetChildren,
              parentContext: renderObject.context,
              updateType: updateType,
            );
          }
        } else {
          if (!flagTolerateChildrenCountMisMatch) {
            return dispatchCompleteRebuild();
          }
        }
      } else {
        if (flagAddIfNotFound) {
          if (services.debug.widgetLogs) {
            print(
              "Add missing child of type: ${updateObject.widget.runtimeType}"
              " under: $parentContext",
            );
          }

          buildChildren(
            widgets: [updateObject.widget],
            parentContext: parentContext,
            flagCleanParentContents: false,
            mountAtIndex: flagAddAsAppendMode ? null : index,
          );
        }
      }
    });
  }

  /// Dispose widgets and its child widgets.
  ///
  void disposeWidget({
    RenderObject? renderObject,
    bool flagPreserveTarget = false,
  }) {
    if (null == renderObject) {
      return;
    }

    // cascade dispose to its childs first

    if (renderObject.context.element.hasChildNodes()) {
      for (final childElement in renderObject.context.element.children) {
        disposeWidget(
          renderObject: services.walker.getRenderObject(childElement.id),
        );
      }
    }

    if (flagPreserveTarget) {
      return;
    }

    var element = renderObject.context.element;

    // nothing to dispose if its a body tag

    if (element == document.body) {
      return;
    }

    // nothing to dispose if its not a widget

    if (null == element.dataset[Constants.attrConcreteType]) {
      return;
    }

    renderObject.beforeUnMount();

    _unMountContext(renderObject.context);

    services.walker.unRegisterRenderObject(renderObject);

    if (services.debug.widgetLogs) {
      print("Dispose: ${renderObject.context}");
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Internals
  |--------------------------------------------------------------------------
  */

  GlobalKey _createWidgetKey(Widget widget, BuildContext parentContext) {
    GlobalKey generatedKey;

    // whether key is provided explicitly in widget constructor

    var isKeyProvided = Constants.contextKeyNotSet != widget.initialKey;

    // ensure key is not using system prefix
    // if in dev mode

    if (services.debug.additionalChecks) {
      if (isKeyProvided && widget.initialKey.hasSystemPrefix) {
        services.debug.exception(
          "Keys starting with ${Constants.contextGenKeyPrefix} are reserved "
          "for framework.",
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

  void _runTask(SchedulerTask task) {
    switch (task.taskType) {
      case SchedulerTaskType.build:
        task as WidgetsBuildTask;

        buildChildren(
          widgets: task.widgets,
          parentContext: task.parentContext,
          mountAtIndex: task.mountAtIndex,
          flagCleanParentContents: task.flagCleanParentContents,
        );

        break;

      case SchedulerTaskType.update:
        task as WidgetsUpdateTask;

        updateChildren(
          widgets: task.widgets,
          updateType: task.updateType,
          parentContext: task.parentContext,
          flagAddIfNotFound: task.flagAddIfNotFound,
          flagAddAsAppendMode: task.flagAddAsAppendMode,
          flagHideObsoluteChildren: task.flagHideObsoluteChildren,
          flagDisposeObsoluteChildren: task.flagDisposeObsoluteChildren,
          flagTolerateChildrenCountMisMatch:
              task.flagTolerateChildrenCountMisMatch,
        );

        break;

      case SchedulerTaskType.manage:
        task as WidgetsManageTask;

        manageChildren(
          parentContext: task.parentContext,
          updateType: task.updateType,
          widgetActionCallback: task.widgetActionCallback,
          flagIterateInReverseOrder: task.flagIterateInReverseOrder,
        );

        break;

      case SchedulerTaskType.dispose:
        task as WidgetsDisposeTask;

        disposeWidget(
          renderObject: task.renderObject,
          flagPreserveTarget: task.flagPreserveTarget,
        );

        break;

      case SchedulerTaskType.updateDependent:
        task as WidgetsUpdateDependentTask;

        updateDependentContext(task.widgetContext);

        break;

      case SchedulerTaskType.stimulateListener:
        // do nothing..
        break;
    }
  }

  void _buildWidgetsUnderContext({
    required List<Widget> widgets,
    required BuildContext parentContext,
    int? mountAtIndex,
  }) {
    for (final widget in widgets) {
      var context = BuildContext.fromParent(
        key: _createWidgetKey(widget, parentContext),
        widget: widget,
        parentContext: parentContext,
      );

      var renderObject = widget.createRenderObject(context);

      services.walker.registerRenderObject(renderObject);

      renderObject.beforeMount();

      _mountContext(context: context, mountAtIndex: mountAtIndex);

      renderObject
        ..afterMount()
        ..render(
          context.element,
          context.configuration,
        );

      // build child(if any)

      buildChildren(widgets: widget.widgetChildren, parentContext: context);
    }
  }

  /// Prepare list of widget actions(by iterating widgets under a context).
  ///
  /// Actions will be collected from callback [widgetActionCallback] which will
  /// be called for each widget under provided context.
  ///
  List<WidgetActionObject> _prepareWidgetActions({
    required BuildContext parentContext,
    required WidgetActionCallback widgetActionCallback,
    bool flagIterateInReverseOrder = false,
  }) {
    var renderObject = services.walker.getRenderObject(parentContext.key.value);

    if (null == renderObject) {
      return [];
    }

    var widgetActionObjects = <WidgetActionObject>[];

    var children = renderObject.context.element.children;

    var iterable = flagIterateInReverseOrder ? children.reversed : children;

    childrenLoop:
    for (final child in iterable) {
      var childRenderObject = services.walker.getRenderObject(child.id);

      if (null != childRenderObject) {
        var widgetActions = widgetActionCallback(childRenderObject);

        for (final widgetAction in widgetActions) {
          widgetActionObjects.add(
            WidgetActionObject(widgetAction, childRenderObject),
          );

          if (WidgetAction.skipRest == widgetAction) {
            break childrenLoop;
          }
        }
      }
    }

    return widgetActionObjects;
  }

  /// Dispatch widget actions.
  ///
  void _dispatchWidgetActions({
    required BuildContext parentContext,
    required List<WidgetActionObject> widgetActions,
    required UpdateType updateType,
  }) {
    for (final widgetActionObject in widgetActions) {
      switch (widgetActionObject.widgetAction) {
        case WidgetAction.skipRest:
          break;

        case WidgetAction.showWidget:
          _showElement(widgetActionObject.renderObject.context.element);

          break;

        case WidgetAction.hideWidget:
          _hideElement(widgetActionObject.renderObject.context.element);

          break;

        case WidgetAction.dispose:
          disposeWidget(renderObject: widgetActionObject.renderObject);

          break;

        case WidgetAction.updateWidget:
          var renderObject = widgetActionObject.renderObject;

          // publish update

          renderObject.update(
            element: renderObject.context.element,
            updateType: updateType,
            newConfiguration: renderObject.context.configuration,
            oldConfiguration: renderObject.context.configuration,
          ); // bit of mess ^ but required

          // call update on child widgets

          updateChildren(
            updateType: updateType,
            parentContext: renderObject.context,
            widgets: renderObject.context.widget.widgetChildren,
          );

          break;
      }
    }
  }

  /// Clean widget context.
  ///
  void _cleanContext(BuildContext context) {
    var isRoot = Constants.contextTypeBigBang == context.widgetConcreteType;

    if (isRoot) {
      _cleanElement(context.key.value);

      return;
    }

    disposeWidget(
      flagPreserveTarget: true,
      renderObject: services.walker.getRenderObject(
        context.key.value,
      ),
    );
  }

  void _mountContext({
    required BuildContext context,
    int? mountAtIndex,
  }) {
    // we can't use node.parent here cus root widget's parent can be null

    var parentElement = document.getElementById(context.parent.key.value);

    if (null != parentElement) {
      // if mount is requested at a specific index

      if (null != mountAtIndex) {
        // if index is available

        if (mountAtIndex >= 0 && parentElement.children.length > mountAtIndex) {
          // mount at specific index

          parentElement.insertBefore(
            context.element,
            parentElement.children[mountAtIndex],
          );

          context.frameworkSetIsMounted(true);

          return;
        }
      }

      // else append

      parentElement.append(context.element);

      context.frameworkSetIsMounted(true);
    }
  }

  void _unMountContext(BuildContext context) {
    context
      ..frameworkSetIsMounted(false)
      ..element.remove();
  }

  void _cleanElement(String elementId) {
    var element = document.getElementById(elementId);

    if (null == element) {
      return services.debug.exception(
        "Unable to find target. Make sure your DOM has "
        "element with key #$elementId",
      );
    }

    element.innerHtml = "";

    return;
  }

  void _hideElement(Element element) {
    element.classes.add('rad-hidden');
  }

  void _showElement(Element element) {
    element.classes.remove('rad-hidden');
  }
}
