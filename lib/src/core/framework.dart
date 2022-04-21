import 'dart:html';

import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/common/objects/widget_action_object.dart';
import 'package:rad/src/core/common/objects/widget_update_object.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_dispose_task.dart';
import 'package:rad/src/core/services/scheduler/events/send_next_task_event.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';

class Framework with ServicesResolver {
  /// Root context.
  ///
  final BuildContext rootContext;

  /// Whether a framework task is in processing.
  ///
  var _isTaskInProcessing = false;

  /// Resolve services reference.
  ///
  Services get services => resolveServices(rootContext);

  /// Create framework instance.
  ///
  /// Each app start spin a framework instance that handles app's state
  /// and build process.
  ///
  Framework(this.rootContext);

  /// Tear down framework state.
  ///
  /// Should be called only during testing.
  ///
  void tearDown() {
    // gracefully dispose widgets

    var widgetKeys = services.walker.dumpWidgetKeys();

    for (var widgetKey in widgetKeys) {
      disposeWidget(
        widgetObject: services.walker.getWidgetObject(widgetKey),
      );
    }
  }

  /// Framework's task processing unit.
  ///
  void taskProcessor(SchedulerTask task) {
    if (_isTaskInProcessing) return;

    try {
      _isTaskInProcessing = true;

      // run before-task callback

      var beforeCallback = task.beforeTaskCallback;

      if (null != beforeCallback) {
        beforeCallback();
      }

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

      // run after-task callback

      var afterCallback = task.afterTaskCallback;

      if (null != afterCallback) {
        afterCallback();
      }
    } finally {
      _isTaskInProcessing = false;

      services.scheduler.addEvent(SendNextTaskEvent());
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
    if (widgets.isEmpty) return;

    if (flagCleanParentContents) {
      var widgetType = parentContext.widgetConcreteType;

      if (Constants.contextTypeBigBang == widgetType) {
        var element = document.getElementById(parentContext.key.value);

        if (null == element) {
          return services.debug.exception(
            "Unable to find target to mount app. Make sure your DOM has "
            "element with key #$parentContext",
          );
        }

        element.innerHtml = "";
      } else {
        disposeWidget(
          flagPreserveTarget: true,
          widgetObject: services.walker.getWidgetObject(
            parentContext.key.value,
          ),
        );
      }
    }

    for (final widget in widgets) {
      // check whether key is provided explicitly in widget constructor

      var isKeyProvided = Constants.contextKeyNotSet != widget.initialKey;

      // ensure key is not using system prefix

      if (services.debug.developmentMode) {
        if (isKeyProvided && widget.initialKey.hasSystemPrefix) {
          return services.debug.exception(
            "Keys starting with ${Constants.contextGenKeyPrefix} are reserved "
            "for framework.",
          );
        }
      }

      // get widget's global key

      var widgetKey = isKeyProvided
          ? services.keyGen.getGlobalKeyUsingKey(
              widget.initialKey,
              parentContext,
            )
          : services.keyGen.generateGlobalKey();

      // create widget configuration

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

      if (services.debug.widgetLogs) {
        print("Build: $buildContext");
      }

      // create widget object

      var widgetObject = WidgetObject(
        configuration: configuration,
        renderObject: renderObject,
      );

      services.walker.registerWidgetObject(widgetObject);

      widgetObject.renderObject.beforeMount();

      widgetObject.mount(mountAtIndex: mountAtIndex);

      widgetObject.renderObject.afterMount();

      widgetObject.renderObject.render(
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
        var alreadySelected = updateObjects.containsKey(child.id);

        if (!alreadySelected) {
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
              widgetObject: services.walker.getWidgetObject(childElement.id),
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
        var widgetObject = services.walker.getWidgetObject(elementId);

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
              if (services.debug.frameworkLogs) {
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

            widgetObject.renderObject.update(
              element: widgetObject.element,
              updateType: updateType,
              newConfiguration: newConfiguration,
              oldConfiguration: oldConfiguration,
            );
          } else {
            if (services.debug.widgetLogs) {
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
    var widgetObject = services.walker.getWidgetObject(parentContext.key.value);

    if (null == widgetObject) return;

    var widgetActionObjects = <WidgetActionObject>[];

    childrenLoop:
    for (final child in flagIterateInReverseOrder
        ? widgetObject.element.children.reversed
        : widgetObject.element.children) {
      var childWidgetObject = services.walker.getWidgetObject(child.id);

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
          var widgetObject = widgetActionObject.widgetObject;

          // publish update

          widgetActionObject.widgetObject.renderObject.update(
            element: widgetObject.element,
            updateType: updateType,
            newConfiguration: widgetObject.configuration,
            oldConfiguration: widgetObject.configuration,
          ); // bit of mess ^ but required

          updateChildren(
            widgets: widgetObject.renderObject.context.widget.widgetChildren,
            parentContext: widgetObject.context,
            updateType: updateType,
          );

          break;
      }
    }
  }

  /// Update a dependent widget(using its context).
  ///
  void updateDependentContext(BuildContext context) {
    var widgetObject = services.walker.getWidgetObject(context.key.value);

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
          widgetObject: services.walker.getWidgetObject(childElement.id),
        );
      }
    }

    if (flagPreserveTarget) return;

    // nothing to dispose if its a body tag

    if (widgetObject.element == document.body) {
      return;
    }

    // nothing to dispose if its not a widget

    if (null == widgetObject.element.dataset[Constants.attrConcreteType]) {
      return;
    }

    widgetObject.renderObject.beforeUnMount();

    services.walker.unRegisterWidgetObject(widgetObject);

    widgetObject.element.remove();

    if (services.debug.widgetLogs) {
      print("Dispose: ${widgetObject.context}");
    }
  }

  void _hideElement(Element element) {
    element.classes.add('rad-hidden');
  }

  void _showElement(Element element) {
    element.classes.remove('rad-hidden');
  }
}
