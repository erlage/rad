import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/debug_options.dart';
import 'package:rad/src/core/objects/widget_action_object.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/objects/widget_update_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

class _AppFrameworkWidget extends InheritedWidget {
  final Framework framework;

  const _AppFrameworkWidget({
    required Widget child,
    required this.framework,
  }) : super(child: child);

  @override
  updateShouldNotify(covariant _AppFrameworkWidget oldWidget) {
    return false;
  }
}

void startApp({
  required Widget app,
  required String targetSelector,
  DebugOptions debugOptions = DebugOptions.defaultMode,
  VoidCallback? beforeMount,
}) {
  var framework = Framework();

  var appFrameworkWidget = _AppFrameworkWidget(
    child: app,
    framework: framework,
  );

  framework.init(routingPath: '/', debugOptions: debugOptions);

  var targetElement = document.getElementById(targetSelector) as HtmlElement?;

  if (null == targetElement) {
    Debug.exception(
      "Unable to locate target element in HTML document",
    );

    return;
  }

  beforeMount?.call();

  CommonProps.applyDataAttributes(targetElement, {
    System.attrConcreteType: "Target",
    System.attrRuntimeType: System.contextTypeBigBang,
  });

  framework.buildChildren(
    widgets: [appFrameworkWidget],
    parentContext: BuildContext.bigBang(targetSelector, framework),
  );
}

class Framework {
  var _isInit = false;

  final _registeredWidgetObjects = <String, WidgetObject>{};

  /// Initialize framework.
  ///
  /// It's AppWidget job to call this method as first task. Initialization
  /// process will initialize other important components such as Router.
  ///
  void init({
    required String routingPath,
    DebugOptions? debugOptions,
  }) {
    if (_isInit) {
      return Debug.exception("Framework aleady initialized.");
    }

    debugOptions ??= DebugOptions.defaultMode;

    Debug.update(debugOptions);

    _isInit = true;
  }

  /// Tear down framework state.
  ///
  /// Since methods in this class are static, we need a way to initialize
  /// and destroy framework state.
  ///
  void tearDown() {
    if (!_isInit) {
      return Debug.exception("Framework is not initialized.");
    }

    clearWidgetObjects();

    _isInit = false;
  }

  T? findAncestorWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${System.attrRuntimeType}='$T']";

    var widgetObject = findAncestorWidgetObjectFromSelector(selector, context);

    if (null != widgetObject) {
      return widgetObject.widget as T;
    }

    return null;
  }

  T? findAncestorStateOfType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${System.attrStateType}='$T']";

    var widgetObject = findAncestorWidgetObjectFromSelector(selector, context);

    if (null != widgetObject) {
      var renderObject =
          widgetObject.renderObject as StatefulWidgetRenderObject;

      return (renderObject).state as T;
    }

    return null;
  }

  WidgetObject? findAncestorWidgetObjectOfType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${System.attrRuntimeType}='$T']";

    return findAncestorWidgetObjectFromSelector(selector, context);
  }

  WidgetObject? findAncestorWidgetObjectOfClass<T>(
    BuildContext context,
  ) {
    var selector = "[data-${System.attrConcreteType}='$T']";

    return findAncestorWidgetObjectFromSelector(selector, context);
  }

  T? dependOnInheritedWidgetOfExactType<T>(
    BuildContext context,
  ) {
    var selector = "[data-${System.attrRuntimeType}='$T']"
        "[data-${System.attrConcreteType}='$InheritedWidget']";

    var widgetObject = findAncestorWidgetObjectFromSelector(selector, context);

    if (null != widgetObject) {
      var inheritedRenderObject = widgetObject.renderObject;

      inheritedRenderObject as InheritedWidgetRenderObject;

      inheritedRenderObject.addDependent(context);

      return widgetObject.widget as T;
    }

    return null;
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
    if (!_isInit) {
      return Debug.exception(
        "Framework not initialized. If you're building your own AppWidget "
        "implementation, make sure to call init()",
      );
    }

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
          widgetObject: getWidgetObject(parentContext.key),
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

      var buildContext = BuildContext(
        key: widgetKey,
        widget: widget,
        parent: parentContext,
        widgetConcreteType: widget.concreteType,
        widgetCorrespondingTag: widget.correspondingTag,
        widgetRuntimeType: "${widget.runtimeType}",
        framework: this,
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

      registerWidgetObject(widgetObject);

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
              widgetObject: getWidgetObject(childElement.id),
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
        var widgetObject = getWidgetObject(elementId);

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
    var widgetObject = getWidgetObject(parentContext.key);

    if (null == widgetObject) return;

    var widgetActionObjects = <WidgetActionObject>[];

    childrenLoop:
    for (final child in flagIterateInReverseOrder
        ? widgetObject.element.children.reversed
        : widgetObject.element.children) {
      var childWidgetObject = getWidgetObject(child.id);

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
  bool updateDependentContext(BuildContext context) {
    var widgetObject = getWidgetObject(context.key);

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

      return true;
    }

    return false;
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
        disposeWidget(widgetObject: getWidgetObject(childElement.id));
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

    unRegisterWidgetObject(widgetObject);

    widgetObject.element.remove();

    if (Debug.widgetLogs) {
      print("Dispose: ${widgetObject.context}");
    }
  }

  WidgetObject? findAncestorWidgetObjectFromSelector(
    String selector,
    BuildContext context,
  ) {
    // ensure context is ready for processing.
    // this happens when user .of(context) is called inside a constructor.

    if (System.contextKeyNotSet == context.key) {
      Debug.exception(
        "Part of build context is not ready. This means that context is under construction.",
      );

      return null;
    }

    var domNode =
        document.getElementById(context.key)?.parent?.closest(selector);

    if (null == domNode) {
      return null;
    }

    // found. return corresponding widget's object.

    return getWidgetObject(domNode.id);
  }

  void _hideElement(Element element) {
    element.classes.add('rad-hidden');
  }

  void _showElement(Element element) {
    element.classes.remove('rad-hidden');
  }

  WidgetObject? getWidgetObject(String widgetId) {
    return _registeredWidgetObjects[widgetId];
  }

  void registerWidgetObject(WidgetObject widgetObject) {
    var widgetKey = widgetObject.renderObject.context.key;

    if (Debug.developmentMode) {
      if (_registeredWidgetObjects.containsKey(widgetKey)) {
        return Debug.exception(
          "Key $widgetKey already exists."
          "\n\nThis usually happens in two scenarios,"
          "\n\n1. When you have duplicate keys in your code."
          "\n\nor\n\n2. When you've two adjacent widgets of same type and one of them is optional."
          "\n\nCorrect way to fix (2): Use explicit keys on one of the widgets that are of same type.",
        );
      }
    }

    _registeredWidgetObjects[widgetKey] = widgetObject;
  }

  void unRegisterWidgetObject(WidgetObject widgetObject) {
    var widgetKey = widgetObject.renderObject.context.key;

    _registeredWidgetObjects.remove(widgetKey);
  }

  void clearWidgetObjects() {
    var widgetKeys = _registeredWidgetObjects.keys.toList();

    for (var widgetKey in widgetKeys) {
      disposeWidget(widgetObject: getWidgetObject(widgetKey));
    }
  }
}
