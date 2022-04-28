import 'dart:html';

import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/common/objects/widget_action_object.dart';
import 'package:rad/src/core/common/objects/widget_update_object.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_dispose_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';

class Framework with ServicesResolver {
  final BuildContext rootContext;

  var _taskListenerKey = '';

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
        widgetObject: services.walker.getWidgetObject(widgetKey),
      );
    }

    services.scheduler.removeTaskListener(_taskListenerKey);
  }

  /// Process a scheduled task.
  ///
  void processTask(SchedulerTask task) {
    if (null != task.beforeTaskCallback) {
      task.beforeTaskCallback!();
    }

    _runTask(task);

    if (null != task.afterTaskCallback) {
      task.afterTaskCallback!();
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
    var widgetObject = services.walker.getWidgetObject(context.key.value);

    if (null != widgetObject) {
      widgetObject.update(
        updateType: UpdateType.dependencyChanged,
        //
        // it's a change in dependency not configuration,
        // so both are same configurations are same
        //
        oldConfiguration: widgetObject.configuration,
        newConfiguration: widgetObject.configuration,
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

    var updateObjects = prepareUpdates(
      parent: parent,
      widgets: widgets,
      parentContext: parentContext,
    );

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

    var i = -1;
    for (var updateObject in updateObjects.values) {
      i++;

      var newWidget = updateObject.widget;
      var existingElementId = updateObject.elementId;

      if (null != existingElementId) {
        var widgetObject = services.walker.getWidgetObject(existingElementId);

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
                  "Short-circuit rebuild: ${widgetObject.context}",
                );

                break;
              }
            }
          }

          var oldConfiguration = widgetObject.configuration;
          var isChanged = newWidget.isConfigurationChanged(oldConfiguration);

          if (isChanged) {
            var newConfiguration = newWidget.createConfiguration();

            widgetObject.rebindWidget(
              widget: newWidget,
              updateType: updateType,
              newConfiguration: newConfiguration,
            );

            // publish update

            widgetObject.update(
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
        if (services.debug.widgetLogs) {
          print(
            "Add missing child of type: ${updateObject.widget.runtimeType}"
            " under: $parentContext",
          );
        }

        buildChildren(
          widgets: [newWidget],
          parentContext: parentContext,
          flagCleanParentContents: false,
          mountAtIndex: i,
        );
      }
    }
  }

  Map<String, WidgetUpdateObject> prepareUpdates({
    required Element parent,
    required List<Widget> widgets,
    required BuildContext parentContext,
  }) {
    var updateObjects = <String, WidgetUpdateObject>{};

    var elements = <Map<String, String?>>[];

    // prepare list of existing elements available

    for (var child in parent.children.reversed) {
      elements.add({
        'id': child.id,
        Constants.attrRuntimeType: child.dataset[Constants.attrRuntimeType]
      });
    }

    for (var newWidget in widgets) {
      //
      // prepare new widget's data for matching
      //
      var newWidgetRuntimeType = "${newWidget.runtimeType}";
      var newWidgetHasKey = Constants.contextKeyNotSet != newWidget.initialKey;
      var newWidgetId = services.keyGen
          .getGlobalKeyUsingKey(
            newWidget.initialKey,
            parentContext,
          )
          .value;

      // assume widget is not matched with the corresponding element
      //
      String? matchedWithId;

      // try matching with the exisitng widget
      //
      if (elements.isNotEmpty) {
        //
        // get element
        //
        var element = elements.removeLast();
        //
        // prepare element's data for matching
        //
        var oldWidgetId = element['id'] ?? '';
        var oldWidgetRuntimeType = element[Constants.attrRuntimeType];
        var oldWidgetHasKey = !oldWidgetId.startsWith(
          Constants.contextGenKeyPrefix,
        );
        //
        // try matching runtime type
        //
        if (oldWidgetRuntimeType == newWidgetRuntimeType) {
          //
          // assume widget is matched
          //
          matchedWithId = oldWidgetId;
          //
          // wait! let's do one more check, see if any of them has/had keys
          //
          if (newWidgetHasKey || oldWidgetHasKey) {
            //
            // then try matching keys
            //
            if (newWidgetId != oldWidgetId) {
              //
              // key not matched, widget is not matched
              //
              matchedWithId = null;
            }
          }
        }
      }

      if (null != matchedWithId) {
        updateObjects[matchedWithId] = WidgetUpdateObject(
          newWidget,
          matchedWithId,
        );
      } else {
        var newKey = services.keyGen.generateRandomKey();

        updateObjects[newKey] = WidgetUpdateObject(newWidget, null);
      }
    }

    return updateObjects;
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

    // if widget itself has to be preserved

    if (flagPreserveTarget) {
      return;
    }

    // nothing to dispose if its a body tag

    if (widgetObject.element == document.body) {
      return;
    }

    // nothing to dispose if its not a widget

    if (null == widgetObject.element.dataset[Constants.attrWidgetType]) {
      return;
    }

    widgetObject.unMount();

    services.walker.unRegisterWidgetObject(widgetObject);

    if (services.debug.widgetLogs) {
      print("Dispose: ${widgetObject.context}");
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
          widgetObject: task.widgetObject,
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

      var widgetObject = WidgetObject(widget: widget, context: context);

      services.walker.registerWidgetObject(widgetObject);

      widgetObject.mount(mountAtIndex);

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
    var widgetObject = services.walker.getWidgetObject(parentContext.key.value);

    if (null == widgetObject) {
      return [];
    }

    var widgetActionObjects = <WidgetActionObject>[];

    var children = widgetObject.element.children;

    var iterable = flagIterateInReverseOrder ? children.reversed : children;

    childrenLoop:
    for (final child in iterable) {
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

          widgetObject.update(
            updateType: updateType,
            newConfiguration: widgetObject.configuration,
            oldConfiguration: widgetObject.configuration,
          ); // bit of mess ^ but required

          // call update on child widgets

          updateChildren(
            updateType: updateType,
            parentContext: widgetObject.context,
            widgets: widgetObject.widget.widgetChildren,
          );

          break;
      }
    }
  }

  /// Clean widget context.
  ///
  void _cleanContext(BuildContext context) {
    var isRoot = Constants.contextTypeBigBang == context.widgetType;

    if (isRoot) {
      _cleanElement(context.key.value);

      return;
    }

    disposeWidget(
      flagPreserveTarget: true,
      widgetObject: services.walker.getWidgetObject(
        context.key.value,
      ),
    );
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
