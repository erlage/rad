import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'package:rad_test/src/common/functions.dart';
import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/finders.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:rad_test/src/runner/app_runner.dart';
import 'package:rad_test/src/runner/test_runner.dart';
import 'package:rad_test/src/utilities/test_stack.dart';
import 'package:rad_test/src/utilities/test_window.dart';

/// Class that programmatically interacts with widgets and the test environment.
///
class WidgetTester {
  /// App runner instance.
  ///
  final AppRunner app;

  /// Parent test runner under which this widget tester is running.
  ///
  final TestRunner testRunner;

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
    this.app,
    this.testRunner, {
    required this.stack,
    this.window,
    required this.exceptionsContainer,
  }) : find = CommonFinders(app);

  /// Pump event queue.
  ///
  Future<void> pump({
    Duration? duration,
  }) async {
    await pumpEventQueue();

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
  Future<void> pumpWidget(
    Widget widget, {
    Duration? duration,
  }) async {
    await _buildChildren(
      widgets: [widget],
      parentContext: app.appContext,
    );

    await Future<void>.delayed(duration ?? const Duration(milliseconds: 100));
  }

  /// Re-Renders the UI from the given [widget].
  ///
  /// Subsequent calls to this is different from [pumpWidget] in that
  /// [pumpWidget] forces a full rebuild of the tree, even if [widget] is the
  /// same as the previous call. While [rePumpWidget] will only rebuild the
  /// widgets that have changed.
  ///
  Future<void> rePumpWidget(
    Widget widget, {
    Duration? duration,
    UpdateType? updateType,
  }) async {
    await _updateChildren(
      widgets: [widget],
      parentContext: app.appContext,
      updateType: updateType ?? UpdateType.setState,
    );

    await Future<void>.delayed(duration ?? const Duration(milliseconds: 100));
  }

  /// Renders the UI from the given [widgets].
  ///
  /// This is different from [pumpWidget] in that it allows you to pump
  /// multiple widgets at root level.
  ///
  /// See also:
  ///
  ///   * [pumpWidget], for pumping a widget
  ///
  Future<void> pumpMultipleWidgets(
    List<Widget> widgets, {
    Duration? duration,
  }) async {
    await _buildChildren(
      widgets: widgets,
      parentContext: app.appContext,
    );

    await Future<void>.delayed(duration ?? const Duration(milliseconds: 100));
  }

  /// Re-Renders the UI from the given [widgets].
  ///
  /// This is different from [rePumpWidget] in that it allows you to re-pump
  /// multiple widgets at root level.
  ///
  /// See also:
  ///
  ///   * [rePumpWidget], for re-pumping a widget
  ///
  Future<void> rePumpMultipleWidgets(
    List<Widget> widgets, {
    Duration? duration,
    UpdateType? updateType,
  }) async {
    await _updateChildren(
      widgets: widgets,
      parentContext: app.appContext,
      updateType: updateType ?? UpdateType.setState,
    );

    await Future<void>.delayed(duration ?? const Duration(milliseconds: 100));
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
    var widgetObjects = finder.evaluate();

    if (widgetObjects.isEmpty) {
      app.services.debug.exception(
        'Unable find any matching widgets with the finder: "$finder".',
      );

      return;
    }

    if (!dispatchToMultipleNodes && widgetObjects.length > 1) {
      app.services.debug.exception(
        'Found multiple matching widgets with the finder: "$finder". '
        'Consider enabling dispatchToMultipleNodes if you want to dispatch '
        'event to multiple dom nodes',
      );

      return;
    }

    for (final widgetObject in widgetObjects) {
      var element = widgetObject.context.findDomNode();

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
    var widgetObjects = finder.evaluate();

    if (widgetObjects.isEmpty) {
      app.services.debug.exception(
        'Unable find any matching widgets with the finder: "$finder".',
      );

      return;
    }

    var targetWidgetObject = widgetObjects.first;
    var widget = targetWidgetObject.widget;

    if (!fnIsWidgetTextEditable(widget)) {
      app.services.debug.exception(
        'Matched widget is of type "${widget.runtimeType}" which is not a '
        'text editable widget.',
      );

      return;
    }

    fnEnterTextOnWidgetObject(
      textToEnter: text,
      widgetObject: targetWidgetObject,
    );
  }

  /// Give the text input widget specified by [finder] the focus, as if the
  /// onscreen keyboard had appeared.
  ///
  Future<void> focus(Finder finder) async {
    var widgetObjects = finder.evaluate();

    if (widgetObjects.isEmpty) {
      app.services.debug.exception(
        'Unable find any matching widgets with the finder: "$finder".',
      );

      return;
    }

    var targetWidgetObject = widgetObjects.first;
    var widget = targetWidgetObject.widget;

    if (!fnIsWidgetTextEditable(widget)) {
      app.services.debug.exception(
        'Matched widget is of type "${widget.runtimeType}" which is not a '
        'text editable widget.',
      );

      return;
    }

    var domNode = targetWidgetObject.domNode;

    if (null == domNode) return;

    domNode.focus();
  }

  /// Find app's dom node.
  ///
  Element? get getAppDomNode => getDomNodeByGlobalKey(app.appContext.key);

  /// Find dom node by id.
  ///
  Element? getDomNodeById(String id) => document.getElementById(id);

  /// Find widget by key provided parent context.
  ///
  Widget? getWidgetByKey(Key key, BuildContext parentContext) {
    return getWidgetObjectByKey(key, parentContext)?.widget;
  }

  /// Find widget by local key under app context.
  ///
  Widget? getWidgetByLocalKey(LocalKey key) =>
      getWidgetObjectByLocalKey(key)?.widget;

  /// Find widget by global key under app context.
  ///
  Widget? getWidgetByGlobalKey(GlobalKey key) => getWidgetObjectByGlobalKey(
        key,
      )?.widget;

  /// Find widget object by key under app context.
  ///
  WidgetObject? getWidgetObjectByKey(Key key, BuildContext parentContext) {
    return app.services.walker.getWidgetObjectUsingKey(
      app.services.keyGen.getGlobalKeyUsingKey(key, parentContext).value,
    );
  }

  /// Find widget object by local key under app context.
  ///
  WidgetObject? getWidgetObjectByLocalKey(LocalKey key) {
    return app.services.walker.getWidgetObjectUsingKey(
      app.services.keyGen.getGlobalKeyUsingKey(key, app.appContext).value,
    );
  }

  /// Find widget object by global key under app context.
  ///
  WidgetObject? getWidgetObjectByGlobalKey(GlobalKey key) {
    return app.services.walker.getWidgetObjectUsingKey(
      app.services.keyGen.getGlobalKeyUsingKey(key, app.appContext).value,
    );
  }

  /// Find dom node by key under app context.
  ///
  Element? getDomNodeByKey(Key key, BuildContext parentContext) =>
      app.services.walker
          .getWidgetObjectUsingKey(
            app.services.keyGen.getGlobalKeyUsingKey(key, parentContext).value,
          )
          ?.domNode;

  /// Find dom node by local key under app context.
  ///
  Element? getDomNodeByLocalKey(LocalKey key) => app.services.walker
      .getWidgetObjectUsingKey(
        app.services.keyGen.getGlobalKeyUsingKey(key, app.rootContext).value,
      )
      ?.domNode;

  /// Find dom node by global key under app context.
  ///
  Element? getDomNodeByGlobalKey(GlobalKey key) {
    return getWidgetObjectByGlobalKey(key)?.domNode;
  }

  /// Update a dependent build context.
  ///
  Future<void> updateContextAsIfDependant(
    BuildContext widgetContext,
  ) async {
    app.services.scheduler.addTask(
      WidgetsUpdateDependentTask(
        widgetContext: widgetContext,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }

  /// Manage(visit) widgets under a build context.
  ///
  Future<void> visitChildren({
    required BuildContext parentContext,
    required WidgetActionsBuilder widgetActionCallback,
    required UpdateType updateType,
    bool flagIterateInReverseOrder = false,
  }) async {
    app.services.scheduler.addTask(
      WidgetsManageTask(
        updateType: updateType,
        parentContext: parentContext,
        widgetActionCallback: widgetActionCallback,
        flagIterateInReverseOrder: flagIterateInReverseOrder,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }

  /// Dispose a widget object.
  ///
  Future<void> disposeWidget({
    required WidgetObject? widgetObject,
    required bool flagPreserveTarget,
  }) async {
    if (null != widgetObject) {
      app.services.scheduler.addTask(
        WidgetsDisposeTask(
          widgetObject: widgetObject,
          flagPreserveTarget: flagPreserveTarget,
        ),
      );
    }

    await Future<void>.delayed(Duration.zero);
  }

  /// Set window path(is using window mock)
  ///
  Future<void> setPath(String toSet) async {
    if (app.services.router.options.enableHashBasedRouting) {
      window?.setHash(toSet);
    } else {
      window?.setPath(toSet);
    }

    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  /// Assert current path(if using window mock)
  ///
  void assertMatchPath(String toMatch, {bool addHashIfMising = true}) {
    if (app.services.router.options.enableHashBasedRouting) {
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

    if (app.services.router.options.enableHashBasedRouting) {
      stack.addAll(window?.hashStack.reversed ?? []);
    } else {
      stack.addAll(window?.pathStack.reversed ?? []);
    }

    for (final entry in toMatch) {
      if (app.services.router.options.enableHashBasedRouting) {
        expect(stack.removeLast(), '#$entry');
      } else {
        expect(stack.removeLast(), entry);
      }
    }

    expect(stack.isEmpty, equals(true));
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

  // private

  /// Build child widgets under a build context.
  ///
  Future<void> _buildChildren({
    required List<Widget> widgets,
    required BuildContext parentContext,
    int? mountAtIndex,
    bool flagCleanParentContents = true,
  }) async {
    app.services.scheduler.addTask(
      WidgetsBuildTask(
        widgets: widgets,
        parentContext: parentContext,
        mountAtIndex: mountAtIndex,
        flagCleanParentContents: flagCleanParentContents,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }

  /// Update child widgets under a build context.
  ///
  Future<void> _updateChildren({
    required List<Widget> widgets,
    required BuildContext parentContext,
    required UpdateType updateType,
    bool flagAddIfNotFound = true,
  }) async {
    app.services.scheduler.addTask(
      WidgetsUpdateTask(
        widgets: widgets,
        parentContext: parentContext,
        updateType: updateType,
        flagAddIfNotFound: flagAddIfNotFound,
      ),
    );

    await Future<void>.delayed(Duration.zero);
  }
}
