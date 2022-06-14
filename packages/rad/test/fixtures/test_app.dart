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

  RenderElement get appRenderElement =>
      services.walker.getRenderElementAssociatedWithGlobalKey(
        GlobalKey('app-widget'),
      )!;

  RT_AppRunner({
    required DebugOptions? debugOptions,
  }) : super.inTestMode(
          app: Text('dont build this one'),
          targetId: RT_TestBed.rootTargetId,
          debugOptions: debugOptions,
        );

  @override
  void start() {
    this
      .._clearState()
      ..prepareTargetDomNode()
      ..setupRootElement()
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

    ServicesRegistry.instance.unRegisterServices(RT_TestBed.rootRenderElement);
  }

  @override
  void setupDelegates() {
    Window.instance.bindDelegate(window);
  }

  void _buildAppWidget() {
    buildChildrenSync(
      widgets: [RT_TestWidget(key: GlobalKey('app-widget'))],
      parentRenderElement: rootElement,
      mountAtIndex: null,
      flagCleanParentContents: false,
    );
  }

  /// Get render element by global key under app context.
  ///
  RenderElement? renderElementByGlobalKey(String key) {
    return services.walker.getRenderElementAssociatedWithGlobalKey(
      GlobalKey(key),
    );
  }

  /// Get widget by global key under app context.
  ///
  Widget widgetByGlobalKey(String key) => renderElementByGlobalKey(key)!.widget;

  /// Get dom node by global key under app context.
  ///
  Element domNodeByGlobalKey(String key) =>
      renderElementByGlobalKey(key)!.domNode!;

  /// Get app's dom node.
  ///
  Element get appDomNode => domNodeByGlobalKey('app-widget');

  /// Get dom node by id.
  ///
  Element domNodeById(String id) => document.getElementById(id)!;

  /// Get state of navigator with global key.
  ///
  NavigatorState navigatorState(String key) {
    var wo = renderElementByGlobalKey(key);

    return (wo as NavigatorRenderElement).state;
  }

  Future<void> buildChildren({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    int? mountAtIndex,
    bool flagCleanParentContents = true,
  }) async {
    services.scheduler.addTask(
      WidgetsBuildTask(
        widgets: widgets,
        parentRenderElement: parentRenderElement,
        mountAtIndex: mountAtIndex,
        flagCleanParentContents: flagCleanParentContents,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  void buildChildrenSync({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    int? mountAtIndex,
    bool flagCleanParentContents = true,
  }) {
    framework.renderer.render(
      widgets: widgets,
      parentRenderElement: parentRenderElement,
      mountAtIndex: mountAtIndex,
      flagCleanParentContents: flagCleanParentContents,
    );
  }

  Future<void> updateChildren({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required UpdateType updateType,
    bool flagAddIfNotFound = true,
  }) async {
    services.scheduler.addTask(
      WidgetsUpdateTask(
        widgets: widgets,
        parentRenderElement: parentRenderElement,
        updateType: updateType,
        flagAddIfNotFound: flagAddIfNotFound,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> updateDependent(
    RenderElement dependentRenderElement,
  ) async {
    services.scheduler.addTask(
      WidgetsUpdateDependentTask(
        dependentRenderElement: dependentRenderElement,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> manageChildren({
    required RenderElement parentRenderElement,
    required WidgetActionsBuilder widgetActionCallback,
    required UpdateType updateType,
    bool flagIterateInReverseOrder = false,
  }) async {
    services.scheduler.addTask(
      WidgetsManageTask(
        updateType: updateType,
        parentRenderElement: parentRenderElement,
        widgetActionCallback: widgetActionCallback,
        flagIterateInReverseOrder: flagIterateInReverseOrder,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> disposeWidget({
    required RenderElement? renderElement,
    required bool flagPreserveTarget,
  }) async {
    if (null != renderElement) {
      services.scheduler.addTask(
        WidgetsDisposeTask(
          renderElement: renderElement,
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
