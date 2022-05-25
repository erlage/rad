// ignore_for_file: camel_case_types

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';
import 'package:rad/src/core/interface/window/window.dart';

import '../test_imports.dart';

RT_AppRunner createTestApp({
  DebugOptions? debugOptions,
}) {
  return RT_AppRunner(
    app: const Text('hello world'),
    targetId: 'root-div',
    debugOptions: debugOptions,
  );
}

/// Test App Runner.
///
class RT_AppRunner {
  final Widget app;
  final String targetId;

  final Callback? beforeMount;
  final DebugOptions? _debugOptions;
  final RouterOptions? _routerOptions;

  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  AppOptions? _appOptions;
  AppOptions get appOptions => _appOptions!;

  Services? _services;
  Services get services => _services!;

  Framework? _framework;
  Framework get framework => _framework!;

  BuildContext get appContext => services.walker
      .getWidgetObjectUsingKey(
        'app-widget',
      )!
      .context;

  RT_AppRunner({
    required this.app,
    required this.targetId,
    this.beforeMount,
    RouterOptions? routerOptions,
    DebugOptions? debugOptions,
  })  : _routerOptions = routerOptions,
        _debugOptions = debugOptions;

  void start() {
    this
      .._clearPossibleState()
      .._createRootContext()
      .._prepareOptions()
      .._setupDelegates()
      .._startServices()
      .._createFrameworkInstance()
      .._buildAppWidget();
  }

  /// Stop app and services associated.
  ///
  void stop() {
    this
      .._disposeFrameworkInstance()
      .._stopServices();
  }

  void _clearPossibleState() {
    // clear location

    window.history.pushState('', '/', '/');
  }

  void _createRootContext() {
    var globalKey = GlobalKey(targetId);

    _rootContext = BuildContext.bigBang(globalKey);
  }

  void _prepareOptions() {
    _appOptions = AppOptions(
      rootContext: rootContext,
      routerOptions: _routerOptions ?? RouterOptions.defaultMode,
      debugOptions: _debugOptions ?? DebugOptions.defaultMode,
    );
  }

  void _setupDelegates() {
    Window.instance.bindDelegate(BrowserWindow());
  }

  void _startServices() {
    ServicesRegistry.instance.unRegisterServices(rootContext);

    _services = Services(appOptions)..startServices();
  }

  void _stopServices() {
    services.stopServices();
  }

  void _createFrameworkInstance() {
    _framework = Framework(rootContext)..initState();
  }

  void _disposeFrameworkInstance() {
    _framework!.dispose();
  }

  void _buildAppWidget() {
    framework.buildChildren(
      widgets: [RT_TestWidget(key: GlobalKey('app-widget'))],
      parentContext: RT_TestBed.rootContext,
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
          .element;

  /// Get element by local key under app context.
  ///
  Element elementByLocalKey(String key) => services.walker
      .getWidgetObjectUsingKey(
        services.keyGen
            .getGlobalKeyUsingKey(LocalKey(key), RT_TestBed.rootContext)
            .value,
      )!
      .element;

  /// Get element by global key under app context.
  ///
  Element elementByGlobalKey(String key) =>
      widgetObjectByGlobalKey(key).element;

  /// Get app's element.
  ///
  Element get appElement => elementByGlobalKey('app-widget');

  /// Get element by id.
  ///
  Element elementById(String id) => document.getElementById(id)!;

  Future<void> buildChildren({
    required List<Widget> widgets,
    required BuildContext parentContext,
    int? mountAtIndex,
    bool flagCleanParentContents = true,
  }) async {
    framework.buildChildren(
      widgets: widgets,
      parentContext: parentContext,
      mountAtIndex: mountAtIndex,
      flagCleanParentContents: flagCleanParentContents,
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> updateChildren({
    required List<Widget> widgets,
    required BuildContext parentContext,
    required UpdateType updateType,
    bool flagAddIfNotFound = true,
  }) async {
    framework.updateChildren(
      widgets: widgets,
      parentContext: parentContext,
      updateType: updateType,
      flagAddIfNotFound: flagAddIfNotFound,
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> manageChildren({
    required BuildContext parentContext,
    required WidgetActionCallback widgetActionCallback,
    required UpdateType updateType,
    bool flagIterateInReverseOrder = false,
  }) async {
    framework.manageChildren(
      updateType: updateType,
      parentContext: parentContext,
      widgetActionCallback: widgetActionCallback,
      flagIterateInReverseOrder: flagIterateInReverseOrder,
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> disposeWidget({
    required WidgetObject? widgetObject,
    required bool flagPreserveTarget,
  }) async {
    framework.disposeWidget(
      widgetObject: widgetObject,
      flagPreserveTarget: flagPreserveTarget,
    );

    await Future.delayed(Duration.zero);
  }
}
