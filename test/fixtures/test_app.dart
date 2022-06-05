// ignore_for_file: camel_case_types

import '../test_imports.dart';

RT_AppRunner createTestApp({
  DebugOptions? debugOptions,
}) {
  return RT_AppRunner(debugOptions: debugOptions);
}

/// Test app runner.
///
class RT_AppRunner extends AppRunner {
  final stack = RT_TestStack();
  final window = RT_TestWindow();

  var _isDebugInformationEnabled = false;

  BuildContext get appContext => services.walker
      .getWidgetObjectUsingKey(
        'app-widget',
      )!
      .context;

  RT_AppRunner({
    required DebugOptions? debugOptions,
  }) : super.inTestMode(
          app: Text('dont build this one'),
          targetId: RT_TestBed.rootContext.key.value,
          debugOptions: debugOptions,
        );

  @override
  void start() {
    this
      .._clearState()
      ..prepareTargetElement()
      ..setupRootContext()
      ..setupOptions()
      ..setupDelegates()
      ..startServices()
      ..setupFrameworkInstance()
      ..runPreMountTasks()
      .._buildAppWidget();
  }

  @override
  void stop() {
    this
      ..disposeFrameworkInstance()
      ..stopServices()
      .._printDebugInformation()
      .._clearState();
  }

  void _clearState() {
    disableDebugInformation();

    stack.clearState();
    window.clearState();

    ServicesRegistry.instance.unRegisterServices(RT_TestBed.rootContext);
  }

  @override
  void setupDelegates() {
    Window.instance.bindDelegate(window);
  }

  void _buildAppWidget() {
    buildChildrenSync(
      widgets: [RT_TestWidget(key: GlobalKey('app-widget'))],
      parentContext: RT_TestBed.rootContext,
      mountAtIndex: null,
      flagCleanParentContents: false,
    );
  }

  /// Get widget object by key under app context.
  ///
  WidgetObject widgetObjectByKey(String key, BuildContext parentContext) {
    return services.walker.getWidgetObjectUsingKey(
      services.keyGen.getGlobalKeyUsingKey(Key(key), parentContext).value,
    )!;
  }

  /// Get widget object by local key under app context.
  ///
  WidgetObject widgetObjectByLocalKey(String key) {
    return services.walker.getWidgetObjectUsingKey(
      services.keyGen.getGlobalKeyUsingKey(LocalKey(key), appContext).value,
    )!;
  }

  /// Get widget object by global key under app context.
  ///
  WidgetObject widgetObjectByGlobalKey(String key) {
    return services.walker.getWidgetObjectUsingKey(
      services.keyGen.getGlobalKeyUsingKey(GlobalKey(key), appContext).value,
    )!;
  }

  /// Get widget by global key under app context.
  ///
  Widget widget(String key) => widgetObjectByGlobalKey(key).widget;

  /// Get element by key under app context.
  ///
  Element elementByKey(String key, BuildContext parentContext) =>
      services.walker
          .getWidgetObjectUsingKey(
            services.keyGen.getGlobalKeyUsingKey(Key(key), parentContext).value,
          )!
          .element!;

  /// Get element by local key under app context.
  ///
  Element elementByLocalKey(String key) => services.walker
      .getWidgetObjectUsingKey(
        services.keyGen
            .getGlobalKeyUsingKey(LocalKey(key), RT_TestBed.rootContext)
            .value,
      )!
      .element!;

  /// Get element by global key under app context.
  ///
  Element elementByGlobalKey(String key) =>
      widgetObjectByGlobalKey(key).element!;

  /// Get app's element.
  ///
  Element get appElement => elementByGlobalKey('app-widget');

  /// Get element by id.
  ///
  Element elementById(String id) => document.getElementById(id)!;

  /// Get state of navigator with global key.
  ///
  NavigatorState navigatorState(String key) {
    var wo = widgetObjectByGlobalKey(key);

    return (wo.renderObject as NavigatorRenderObject).state;
  }

  Future<void> buildChildren({
    required List<Widget> widgets,
    required BuildContext parentContext,
    int? mountAtIndex,
    bool flagCleanParentContents = true,
  }) async {
    services.scheduler.addTask(
      WidgetsBuildTask(
        widgets: widgets,
        parentContext: parentContext,
        mountAtIndex: mountAtIndex,
        flagCleanParentContents: flagCleanParentContents,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  void buildChildrenSync({
    required List<Widget> widgets,
    required BuildContext parentContext,
    int? mountAtIndex,
    bool flagCleanParentContents = true,
  }) {
    framework.renderer.render(
      widgets: widgets,
      parentContext: parentContext,
      mountAtIndex: mountAtIndex,
      flagCleanParentContents: flagCleanParentContents,
    );
  }

  Future<void> updateChildren({
    required List<Widget> widgets,
    required BuildContext parentContext,
    required UpdateType updateType,
    bool flagAddIfNotFound = true,
  }) async {
    services.scheduler.addTask(
      WidgetsUpdateTask(
        widgets: widgets,
        parentContext: parentContext,
        updateType: updateType,
        flagAddIfNotFound: flagAddIfNotFound,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> manageChildren({
    required BuildContext parentContext,
    required WidgetActionCallback widgetActionCallback,
    required UpdateType updateType,
    bool flagIterateInReverseOrder = false,
  }) async {
    services.scheduler.addTask(
      WidgetsManageTask(
        updateType: updateType,
        parentContext: parentContext,
        widgetActionCallback: widgetActionCallback,
        flagIterateInReverseOrder: flagIterateInReverseOrder,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> disposeWidget({
    required WidgetObject? widgetObject,
    required bool flagPreserveTarget,
  }) async {
    if (null != widgetObject) {
      services.scheduler.addTask(
        WidgetsDisposeTask(
          widgetObject: widgetObject,
          flagPreserveTarget: flagPreserveTarget,
        ),
      );
    }

    await Future.delayed(Duration.zero);
  }

  Future<void> setPath(String toSet) async {
    if (services.router.options.enableHashBasedRouting) {
      window.setHash(toSet);
    } else {
      window.setPath(toSet);
    }

    await Future.delayed(Duration(milliseconds: 100));
  }

  void assertMatchPath(String toMatch) {
    if (services.router.options.enableHashBasedRouting) {
      expect(window.locationHash, '#$toMatch');
    } else {
      expect(window.locationPathName, toMatch);
    }
  }

  void assertMatchPathStack(List<String> toMatch) {
    var stack = <String>[];

    if (services.router.options.enableHashBasedRouting) {
      stack.addAll(window.hashStack.reversed);
    } else {
      stack.addAll(window.pathStack.reversed);
    }

    for (final entry in toMatch) {
      if (services.router.options.enableHashBasedRouting) {
        expect(stack.removeLast(), '#$entry');
      } else {
        expect(stack.removeLast(), entry);
      }
    }

    expect(stack.isEmpty, equals(true));
  }

  void enableDebugInformation() {
    _isDebugInformationEnabled = true;
  }

  void disableDebugInformation() {
    _isDebugInformationEnabled = false;
  }

  void _printDebugInformation() {
    if (_isDebugInformationEnabled) {
      for (final entry in window.logs) {
        print('Window: $entry');
      }

      for (final entry in stack.entries) {
        print('Stack: $entry');
      }
    }
  }
}
