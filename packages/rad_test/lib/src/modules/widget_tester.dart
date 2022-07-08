// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: invalid_use_of_internal_member

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'package:rad_test/src/common/functions.dart';
import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/all_elements.dart';
import 'package:rad_test/src/modules/finders.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:rad_test/src/runner/app_runner.dart';
import 'package:rad_test/src/utilities/test_stack.dart';
import 'package:rad_test/src/utilities/test_window.dart';

/// Class that programmatically interacts with widgets and the test environment.
///
class WidgetTester {
  /// App runner instance.
  ///
  final AppRunner app;

  /// A simple stack utility.
  ///
  final TestStack stack;

  /// Window delegate if tests are using window mock.
  ///
  final TestWindow? window;

  /// Some frequently used widget [Finder]s.
  ///
  final CommonFinders find;

  /// Exceptions container.
  ///
  final List<Object> exceptionsContainer;

  /// Whether debugging information has been disable.
  ///
  var _isDebugInformationDisabled = true;

  WidgetTester(
    this.app, {
    required this.stack,
    this.window,
    required this.exceptionsContainer,
  }) : find = CommonFinders(app);

  /// Pump event queue.
  ///
  Future<void> pump({
    Duration? duration,
  }) async {
    await pumpEventQueue(times: 1);

    if (null != duration) {
      await Future<void>.delayed(duration);
    }
  }

  /// Pump event queue two times.
  ///
  Future<void> pumpAndSettle({
    Duration? duration,
  }) async {
    await pumpEventQueue(times: 2);

    if (null != duration) {
      await Future<void>.delayed(duration);
    }
  }

  /// Renders the UI from the given [widget].
  ///
  /// Subsequent calls to this is different from [pump] in that it forces a full
  /// rebuild of the tree, even if [widget] is the same as the previous call.
  /// [pump] will only rebuild the widgets that have changed.
  ///
  ///
  /// This method exposes system controls which can be used to control the
  /// behavior of framework's internal renderer.
  ///
  /// Available system controls:
  ///
  /// - [mountAtIndex]
  /// - [flagCleanParentContents]
  ///
  Future<void> pumpWidget(
    Widget widget, {
    Duration? duration,
    int? mountAtIndex,
    bool? flagCleanParentContents,
  }) async {
    await _buildChildren(
      widgets: [widget],
      parentRenderElement: app.appRenderElement,
      mountAtIndex: mountAtIndex,
      flagCleanParentContents: flagCleanParentContents,
    );

    await pump(duration: duration);
  }

  /// Re-Renders the UI from the given [widget].
  ///
  /// Subsequent calls to this is different from [pumpWidget] in that
  /// [pumpWidget] forces a full rebuild of the tree, even if [widget] is the
  /// same as the previous call. While [rePumpWidget] will only rebuild the
  /// widgets that have changed.
  ///
  ///
  /// This method exposes system controls which can be used to control the
  /// behavior of framework's internal renderer.
  ///
  /// Available system controls:
  ///
  /// - [flagAddIfNotFound]
  ///
  Future<void> rePumpWidget(
    Widget widget, {
    Duration? duration,
    bool? flagAddIfNotFound,
  }) async {
    await _updateChildren(
      widgets: [widget],
      parentRenderElement: app.appRenderElement,
      updateType: UpdateType.setState,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    await pump(duration: duration);
  }

  /// Renders the UI from the given [widgets].
  ///
  /// This is different from [pumpWidget] in that it allows you to pump
  /// multiple widgets at root level.
  ///
  ///
  /// This method exposes system controls which can be used to control the
  /// behavior of framework's internal renderer.
  ///
  /// Available system controls:
  ///
  /// - [mountAtIndex]
  /// - [flagCleanParentContents]
  ///
  /// See also:
  ///
  ///   * [pumpWidget], for pumping a widget
  ///
  Future<void> pumpMultipleWidgets(
    List<Widget> widgets, {
    Duration? duration,
    int? mountAtIndex,
    bool? flagCleanParentContents,
  }) async {
    await _buildChildren(
      widgets: widgets,
      parentRenderElement: app.appRenderElement,
      mountAtIndex: mountAtIndex,
      flagCleanParentContents: flagCleanParentContents,
    );

    await pump(duration: duration);
  }

  /// Re-Renders the UI from the given [widgets].
  ///
  /// This is different from [rePumpWidget] in that it allows you to re-pump
  /// multiple widgets at root level.
  ///
  ///
  /// This method exposes system flags which can be used to control the behavior
  /// of framework's internal renderer.
  ///
  /// Available system flags:
  ///
  /// - [updateType]
  /// - [flagAddIfNotFound]
  ///
  /// See also:
  ///
  ///   * [rePumpWidget], for re-pumping a widget
  ///
  Future<void> rePumpMultipleWidgets(
    List<Widget> widgets, {
    Duration? duration,
    UpdateType? updateType,
    bool? flagAddIfNotFound,
  }) async {
    await _updateChildren(
      widgets: widgets,
      parentRenderElement: app.appRenderElement,
      updateType: updateType ?? UpdateType.setState,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    await pump(duration: duration);
  }

  /// Returns the exception most recently caught by the Rad framework.
  ///
  /// Call this if you expect an exception during a test. If an exception is
  /// thrown and this is not called, then the exception is rethrown when
  /// the [testWidgets] call completes.
  ///
  /// It's safe to call this when there's no pending exception; it will return
  /// null in that case.
  ///
  dynamic takeException() {
    if (exceptionsContainer.isNotEmpty) {
      return exceptionsContainer.removeLast();
    }
  }

  /// Dispatch a click event to widgets matching the provided finder.
  ///
  Future<void> click(
    Finder finder, {
    bool dispatchToMultipleNodes = false,
  }) async {
    await dispatchEvent(
      event: Event('click'),
      finder: finder,
      dispatchToMultipleNodes: dispatchToMultipleNodes,
    );
  }

  /// Dispatch event to widgets matching the provided finder.
  ///
  Future<void> dispatchEvent({
    required Event event,
    required Finder finder,
    bool dispatchToMultipleNodes = false,
  }) async {
    var renderElements = finder.evaluate();

    if (renderElements.isEmpty) {
      app.frameworkServices.debug.exception(
        'Unable find any matching widgets with the finder: "$finder".',
      );

      return;
    }

    if (!dispatchToMultipleNodes && renderElements.length > 1) {
      app.frameworkServices.debug.exception(
        'Found multiple matching widgets with the finder: "$finder". '
        'Consider enabling dispatchToMultipleNodes if you want to dispatch '
        'event to multiple dom nodes',
      );

      return;
    }

    for (final renderElement in renderElements) {
      var element = renderElement.findClosestDomNode();

      element.dispatchEvent(event);

      await pumpEventQueue();
    }
  }

  /// Give the text input widget specified by [finder] the focus and replace its
  /// content with [text].
  ///
  /// Note that widget must of subtype of [Input] or [TextArea].
  ///
  Future<void> enterText(Finder finder, String text) async {
    var renderElements = finder.evaluate();

    if (renderElements.isEmpty) {
      app.frameworkServices.debug.exception(
        'Unable find any matching widgets with the finder: "$finder".',
      );

      return;
    }

    var targetRenderElement = renderElements.first;
    var widget = targetRenderElement.widget;

    if (!fnIsWidgetTextEditable(widget)) {
      app.frameworkServices.debug.exception(
        'Matched widget is of type "${widget.runtimeType}" which is not a '
        'text editable widget.',
      );

      return;
    }

    fnEnterTextOnWidgetObject(
      textToEnter: text,
      renderElement: targetRenderElement,
    );
  }

  /// Give the text input widget specified by [finder] the focus, as if the
  /// onscreen keyboard had appeared.
  ///
  Future<void> focus(Finder finder) async {
    var renderElements = finder.evaluate();

    if (renderElements.isEmpty) {
      app.frameworkServices.debug.exception(
        'Unable find any matching widgets with the finder: "$finder".',
      );

      return;
    }

    var targetRenderElement = renderElements.first;
    var widget = targetRenderElement.widget;

    if (!fnIsWidgetTextEditable(widget)) {
      app.frameworkServices.debug.exception(
        'Matched widget is of type "${widget.runtimeType}" which is not a '
        'text editable widget.',
      );

      return;
    }

    var domNode = targetRenderElement.domNode;

    if (null == domNode) return;

    domNode.focus();
  }

  /// Find app's dom node.
  ///
  Element? get getAppDomNode => app.appRenderElement.domNode;

  /// Find dom node by id.
  ///
  Element? getDomNodeById(String id) => document.getElementById(id);

  /// Find widget by global key under app context.
  ///
  Widget? getWidgetByKey(Key key) => getrenderElementByKeyValue(
        key,
      )?.widget;

  /// Find render element by global key under app context.
  ///
  RenderElement? getrenderElementByKeyValue(Key key) {
    var elements = collectAllWidgetObjectsFrom(
      app.rootElement,
      skipOffstage: false,
    );

    for (final element in elements) {
      if (element.key == key) {
        return element;
      }
    }

    return null;
  }

  /// Find dom node by global key under app context.
  ///
  Element? getdomNodeByKey(Key key) {
    return getrenderElementByKeyValue(key)?.domNode;
  }

  /// Update a dependent build context.
  ///
  Future<void> updateRenderElementAsIfDependant(
    RenderElement renderElement,
  ) async {
    app.frameworkServices.scheduler.addTask(
      WidgetsUpdateDependentTask(
        dependentRenderElement: renderElement,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }

  /// Manage(visit) widgets under a build context.
  ///
  Future<void> visitChildren({
    required RenderElement parentRenderElement,
    required WidgetActionsBuilder widgetActionCallback,
    required UpdateType updateType,
    bool flagIterateInReverseOrder = false,
  }) async {
    app.frameworkServices.scheduler.addTask(
      WidgetsManageTask(
        updateType: updateType,
        parentRenderElement: parentRenderElement,
        widgetActionCallback: widgetActionCallback,
        flagIterateInReverseOrder: flagIterateInReverseOrder,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }

  /// Dispose a render element.
  ///
  Future<void> disposeWidget({
    required RenderElement? renderElement,
    required bool flagPreserveTarget,
  }) async {
    if (null != renderElement) {
      app.frameworkServices.scheduler.addTask(
        WidgetsDisposeTask(
          renderElement: renderElement,
          flagPreserveTarget: flagPreserveTarget,
        ),
      );
    }

    await Future<void>.delayed(Duration.zero);
  }

  /// Set window path(is using window mock)
  ///
  Future<void> setPath(String toSet) async {
    if (app.frameworkServices.router.options.enableHashBasedRouting) {
      window?.setHash(toSet);
    } else {
      window?.setPath(toSet);
    }

    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  /// Assert current path(if using window mock)
  ///
  void assertMatchPath(String toMatch, {bool addHashIfMising = true}) {
    if (app.frameworkServices.router.options.enableHashBasedRouting) {
      if (addHashIfMising) {
        toMatch = '#$toMatch';
      }

      expect(window?.locationHash, toMatch);
    } else {
      expect(window?.locationPathName, toMatch);
    }
  }

  /// Assert path stack(if using window mock)
  ///
  void assertMatchPathStack(List<String> toMatch) {
    var stack = <String>[];

    if (app.frameworkServices.router.options.enableHashBasedRouting) {
      stack.addAll(window?.hashStack.reversed ?? []);
    } else {
      stack.addAll(window?.pathStack.reversed ?? []);
    }

    for (final entry in toMatch) {
      if (app.frameworkServices.router.options.enableHashBasedRouting) {
        expect(stack.removeLast(), '#$entry');
      } else {
        expect(stack.removeLast(), entry);
      }
    }

    expect(stack.isEmpty, equals(true));
  }

  /// Assert match stack entries
  ///
  void assertMatchStack(List<String> expectedStack, {bool inversed = true}) {
    for (final entry in expectedStack) {
      if (inversed) {
        expect(stack.popFromStart(), entry);
      } else {
        expect(stack.pop(), entry);
      }
    }

    expect(stack.canPop(), equals(false));
  }

  /// Enable debugging logs.
  ///
  void enableDebuggingInformation() => _isDebugInformationDisabled = false;

  /// Disable debugging logs.
  ///
  void disableDebuggingInformation() => _isDebugInformationDisabled = true;

  /// Print debugging information collected by the widgets tester.
  ///
  void printDebuggingInformation() {
    if (!_isDebugInformationDisabled) {
      for (final entry in stack.loggedEntries) {
        print('Test stack entry: $entry');
      }

      if (null != window) {
        for (final entry in window!.logs) {
          print('Window entry: $entry');
        }
      }
    }
  }

  /// Alias to [click],
  ///
  Future<void> tap(
    Finder finder, {
    bool dispatchToMultipleNodes = false,
  }) async {
    return tap(
      finder,
      dispatchToMultipleNodes: dispatchToMultipleNodes,
    );
  }

  /// Alias to [focus].
  ///
  Future<void> showKeyBoard(Finder finder) async {
    return focus(finder);
  }

  /// Alias to [WidgetTester.stack.push]
  ///
  void push(String entry) => stack.push(entry);

  // private

  /// Build child widgets under a build context.
  ///
  Future<void> _buildChildren({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    int? mountAtIndex,
    bool? flagCleanParentContents,
  }) async {
    app.frameworkServices.scheduler.addTask(
      WidgetsBuildTask(
        widgets: widgets,
        parentRenderElement: parentRenderElement,
        mountAtIndex: mountAtIndex,
        flagCleanParentContents: flagCleanParentContents ?? true,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }

  /// Update child widgets under a build context.
  ///
  Future<void> _updateChildren({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required UpdateType updateType,
    bool? flagAddIfNotFound,
  }) async {
    app.frameworkServices.scheduler.addTask(
      WidgetsUpdateTask(
        widgets: widgets,
        parentRenderElement: parentRenderElement,
        updateType: updateType,
        flagAddIfNotFound: flagAddIfNotFound ?? true,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }
}
