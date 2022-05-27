// ignore_for_file: camel_case_types

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/framework.dart';
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

  final stack = RT_TestStack();
  final window = RT_TestWindow();

  var _isDebugInformationEnabled = false;

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
      .._clearState()
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
      .._printDebugInformation()
      .._disposeFrameworkInstance()
      .._stopServices();
  }

  void _clearState() {
    disableDebugInformation();

    stack.clearState();
    window.clearState();

    if (null != _rootContext) {
      ServicesRegistry.instance.unRegisterServices(_rootContext!);
    }

    ServicesRegistry.instance.unRegisterServices(RT_TestBed.rootContext);

    this
      .._disposeFrameworkInstance()
      .._stopServices();
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
    Window.instance.bindDelegate(window);
  }

  void _startServices() {
    _services = Services(appOptions)..startServices();
  }

  void _stopServices() {
    _services?.stopServices();
  }

  void _createFrameworkInstance() {
    _framework = Framework(rootContext)..initState();
  }

  void _disposeFrameworkInstance() {
    _framework?.dispose();
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
