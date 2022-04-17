import 'dart:html';

import 'package:rad/src/core/types.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/services/utils.dart';
import 'package:rad/src/core/services/debug.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/services/framework_registry.dart';
import 'package:rad/src/core/foundation/scheduler/abstract.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/common/widget_object.dart';
import 'package:rad/src/core/foundation/common/framework_services.dart';
import 'package:rad/src/core/foundation/common/widget_action_object.dart';
import 'package:rad/src/core/foundation/common/widget_update_object.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/widgets_dispose_task.dart';
import 'package:rad/src/core/foundation/scheduler/events/send_next_task_event.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/widgets_update_dependent_task.dart';

class Framework {
  /// Services offered/used by the framework.
  ///
  final _services = FrameworkServices();

  /// Whether a framework task is in processing.
  ///
  var _isTaskInProcessing = false;

  /// Root context refers to the context that was used to bootstrap
  /// the framework build process.
  ///
  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  /// Initialize framework.
  ///
  /// Each app instance should have exactly one corresponding framework instance.
  ///
  /// Typically, startApp creates root context(for app) and provide it to framework instance
  /// via this method. Framework will register all services that depends on app's root context.
  ///
  void init(BuildContext context) {
    _rootContext = context;

    _services.walker.init();
    _services.scheduler.init(_taskProcessor);

    FrameworkRegistry.instance.registerServices(rootContext, _services);
  }

  /// Tear down framework state.
  ///
  /// Should be called only during testing.
  ///
  void tearDown() {
    // gracefully dispose widgets

    var widgetKeys = _services.walker.dumpWidgetKeys();

    for (var widgetKey in widgetKeys) {
      disposeWidget(widgetObject: _services.walker.getWidgetObject(widgetKey));
    }

    // dispose instances

    _services.walker.tearDown();

    _services.scheduler.tearDown();

    // un register instances from global registry

    FrameworkRegistry.instance.unRegisterServices(rootContext);
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
    if (widgets.isEmpty) return;

    if (flagCleanParentContents) {
      var widgetType = parentContext.widgetConcreteType;

      if (System.contextTypeBigBang == widgetType) {
        var element = document.getElementById(parentContext.key);

        if (null == element) {
          return Debug.exception(
            "Unable to find target to mount app. Make sure your DOM has "
            "element with key #$parentContext",
          );
        }

        element.innerHtml = "";
      } else {
        disposeWidget(
          flagPreserveTarget: true,
          widgetObject: _services.walker.getWidgetObject(parentContext.key),
        );
      }
    }

    for (final widget in widgets) {
      // generate key if not set

      var isKeyProvided = System.contextKeyNotSet != widget.initialKey;

      if (Debug.developmentMode) {
        if (isKeyProvided && widget.initialKey.startsWith("_gen_")) {
          return Debug.exception(
            "Keys starting with _gen_ are reserved for framework.",
          );
        }
      }

      var widgetKey =
          isKeyProvided ? widget.initialKey : Utils.generateWidgetKey();

      var configuration = widget.createConfiguration();

      // create build context

      var buildContext = BuildContext.fromParent(
        key: widgetKey,
        widget: widget,
        parentContext: parentContext,
        widgetConcreteType: widget.concreteType,
        widgetCorrespondingTag: widget.correspondingTag,
        widgetRuntimeType: "${widget.runtimeType}",
      );

      // create render object

      var renderObject = widget.createRenderObject(buildContext);

      if (Debug.widgetLogs) {
        print("Build: $buildContext");
      }

      // create widget object

      var widgetObject = WidgetObject(
        configuration: configuration,
        renderObject: renderObject,
      );

      _services.walker.registerWidgetObject(widgetObject);

      widgetObject.renderObject.beforeMount();

      widgetObject.mount(mountAtIndex: mountAtIndex);

      widgetObject.renderObject.afterMount();

      widgetObject.renderObject.dispatchRender(
        widgetObject.element,
        widgetObject.configuration,
      );

      buildChildren(
        widgets: widgetObject.widget.widgetChildren,
        parentContext: widgetObject.context,
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

    var parent = document.getElementById(parentContext.key);

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
        var alreadySelected = updateObjects.containsKey(child.id);

        if (!alreadySelected) {
          var hasSameType = child.dataset.isNotEmpty &&
              "${widget.runtimeType}" == child.dataset[System.attrRuntimeType];

          if (hasSameType) {
            var hadKey = !child.id.startsWith("_gen_");
            var hasKey = System.contextKeyNotSet != widget.initialKey;

            if ((hasKey || hadKey) && widget.initialKey != child.id) {
              // skip this one
            } else {
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
        var randomKey = "_${Utils.generateRandomKey()}";

        updateObjects[randomKey] = WidgetUpdateObject(widget, null);
      }
    }

    // deal with obsolute nodes

    if (flagHideObsoluteChildren || flagDisposeObsoluteChildren) {
      for (final childElement in parent.children) {
        if (!updateObjects.containsKey(childElement.id)) {
          if (flagDisposeObsoluteChildren) {
            disposeWidget(
              widgetObject: _services.walker.getWidgetObject(childElement.id),
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
        var widgetObject = _services.walker.getWidgetObject(elementId);

        // if found

        if (null != widgetObject) {
          var newWidget = updateObject.widget;

          var oldWidget = widgetObject.renderObject.context.widget;

          if (UpdateType.dependencyChanged == updateType) {
            // if it's a inherited widget update, we allow immediate childs
            // to build without checking whether they are const or not.

            // but if they further have child widgets of their owns, we want
            // the framework to short-circuit rebuild if possible, this can be
            // acheived by resetting update type to something else

            updateType = UpdateType.undefined;
          } else {
            if (oldWidget == newWidget) {
              if (Debug.frameworkLogs) {
                print(
                  "Short-circuit rebuild: ${widgetObject.renderObject.context}",
                );

                return;
              }
            }
          }

          var oldConfiguration = widgetObject.configuration;

          var isChanged = newWidget.isConfigurationChanged(oldConfiguration);

          if (isChanged) {
            // switch to new widget and configuration

            var newConfiguration = newWidget.createConfiguration();

            widgetObject.rebindConfiguration(newConfiguration);

            widgetObject.renderObject.context.rebindWidget(newWidget);

            // call hook

            widgetObject.renderObject.afterWidgetRebind(updateType, oldWidget);

            // publish update

            widgetObject.renderObject.dispatchUpdate(
              element: widgetObject.element,
              updateType: updateType,
              newConfiguration: newConfiguration,
              oldConfiguration: oldConfiguration,
            );
          } else {
            if (Debug.widgetLogs) {
              print("Skipped: ${widgetObject.context}");
            }
          }

          // whether old widget happen to have child widgets
          var hadChilds = oldWidget.widgetChildren.isNotEmpty;

          // whether new widget has any childs
          var hasChilds = updateObject.widget.widgetChildren.isNotEmpty;

          // if new widget has no childs but old had, we have to remove
          // those orphan childs.

          if (hadChilds && !hasChilds) {
            disposeWidget(widgetObject: widgetObject, flagPreserveTarget: true);
          } else {
            // else update childs
            // doesn't matter whether new has or not.

            updateChildren(
              widgets: updateObject.widget.widgetChildren,
              parentContext: widgetObject.context,
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
          if (Debug.widgetLogs) {
            print(
              "Add missing child of type: ${updateObject.widget.runtimeType} under: $parentContext",
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
    UpdateType? updateTypeWhenNecessary,
    //
    // -- flags --
    //
    bool flagIterateInReverseOrder = false,
  }) {
    var widgetObject = _services.walker.getWidgetObject(parentContext.key);

    if (null == widgetObject) return;

    var widgetActionObjects = <WidgetActionObject>[];

    childrenLoop:
    for (final child in flagIterateInReverseOrder
        ? widgetObject.element.children.reversed
        : widgetObject.element.children) {
      var childWidgetObject = _services.walker.getWidgetObject(child.id);

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

    for (final widgetActionObject in widgetActionObjects) {
      switch (widgetActionObject.widgetAction) {
        case WidgetAction.skipRest:
          break;

        case WidgetAction.showWidget:
          _showElement(widgetActionObject.widgetObject.element);

          break;

        case WidgetAction.hideWidget:
          _hideElement(widgetActionObject.widgetObject.element);

          break;

        case WidgetAction.dispose:
          disposeWidget(widgetObject: widgetActionObject.widgetObject);

          break;

        case WidgetAction.updateWidget:
          if (null == updateTypeWhenNecessary) {
            return Debug.exception(
              "Update type note set for publishing update.",
            );
          }

          var widgetObject = widgetActionObject.widgetObject;

          // publish update

          widgetActionObject.widgetObject.renderObject.dispatchUpdate(
            element: widgetObject.element,
            updateType: updateTypeWhenNecessary,
            newConfiguration: widgetObject.configuration,
            oldConfiguration: widgetObject.configuration,
          ); // bit of mess ^ but required

          updateChildren(
            widgets: widgetObject.renderObject.context.widget.widgetChildren,
            parentContext: widgetObject.context,
            updateType: updateTypeWhenNecessary,
          );

          break;
      }
    }
  }

  /// Update a dependent widget(using its context).
  ///
  void updateDependentContext(BuildContext context) {
    var widgetObject = _services.walker.getWidgetObject(context.key);

    if (null != widgetObject) {
      widgetObject.renderObject.update(
        element: widgetObject.element,
        updateType: UpdateType.dependencyChanged,
        //
        // it's a change in dependency not configuration,
        // so both are same
        //
        oldConfiguration: widgetObject.configuration,
        newConfiguration: widgetObject.configuration,
      );
    }
  }

  /// Dispose widgets and its child widgets.
  ///
  void disposeWidget({
    WidgetObject? widgetObject,
    bool flagPreserveTarget = false,
  }) {
    if (null == widgetObject) {
      return;
    }

    // cascade dispose to its childs first

    if (widgetObject.element.hasChildNodes()) {
      for (final childElement in widgetObject.element.children) {
        disposeWidget(
          widgetObject: _services.walker.getWidgetObject(childElement.id),
        );
      }
    }

    if (flagPreserveTarget) return;

    // nothing to dispose if its a body tag

    if (widgetObject.element == document.body) {
      return;
    }

    // nothing to dispose if its not a widget

    if (null == widgetObject.element.dataset[System.attrConcreteType]) {
      return;
    }

    widgetObject.renderObject.beforeUnMount();

    _services.walker.unRegisterWidgetObject(widgetObject);

    widgetObject.element.remove();

    if (Debug.widgetLogs) {
      print("Dispose: ${widgetObject.context}");
    }
  }

  void _taskProcessor(SchedulerTask task) {
    if (_isTaskInProcessing) return;

    try {
      _isTaskInProcessing = true;

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
            updateTypeWhenNecessary: task.updateType,
            widgetActionCallback: task.widgetActionCallback,
            flagIterateInReverseOrder: task.flagIterateInReverseOrder,
          );

          break;

        case SchedulerTaskType.dispose:
          task as WidgetsDisposeTask;

          disposeWidget(
            widgetObject: task.widgetObject,
            flagPreserveTarget: task.flagPreserveTarget,
          );

          break;

        case SchedulerTaskType.updateDependent:
          task as WidgetsUpdateDependentTask;

          updateDependentContext(task.widgetContext);

          break;

        case SchedulerTaskType.stimulateListener:
          // do nothing.. finally block will automatically
          // push a event for getting new tasks after this block.
          break;
      }
    } finally {
      _isTaskInProcessing = false;

      _services.scheduler.addEvent(SendNextTaskEvent());
    }
  }

  void _hideElement(Element element) {
    element.classes.add('rad-hidden');
  }

  void _showElement(Element element) {
    element.classes.remove('rad-hidden');
  }
}
