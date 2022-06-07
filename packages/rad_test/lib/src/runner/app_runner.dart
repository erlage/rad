// ignore_for_file: camel_case_types

import 'package:rad/rad.dart' as rad;

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/utilities/test_window.dart';

/// Test app root widget.
///
class TestAppRootWidget extends Division {
  const TestAppRootWidget({super.key, super.children});
}

/// Test app runner.
///
class AppRunner extends rad.AppRunner {
  /// Current app id.
  ///
  /// App ids are generated when framework spins a test environment. This id
  /// is generated unique which allows running multiple test apps and multiple
  /// test environments on the same page.
  ///
  final String appId;

  /// Target element's id.
  ///
  final String appTargetId;

  /// Whether to mock browser's window object.
  ///
  final bool useWindowMock;

  /// Window mock object(if [useWindowMock] is true)
  WindowDelegate? window;

  /// Create test app runner instance.
  ///
  AppRunner({
    required this.appId,
    required this.appTargetId,
    required this.useWindowMock,
    rad.DebugOptions? debugOptions,
    rad.RouterOptions? routerOptions,
  }) : super.inTestMode(
          app: const Text(''),
          targetId: appTargetId,
          debugOptions: debugOptions,
          routerOptions: routerOptions,
        );

  /// App widget(root widget)'s build context.
  ///
  BuildContext get appContext {
    var appWidget = services.walker.getWidgetObjectUsingKey(appId);

    if (null == appWidget) {
      throw Exception('App widget (#$appId) not found');
    }

    return appWidget.context;
  }

  @override
  void start() {
    this
      ..prepareTargetDomNode()
      ..setupRootContext()
      .._clearState()
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
      .._clearState();
  }

  @override
  void setupDelegates() {
    if (useWindowMock) {
      window = TestWindow(rootContext);

      Window.instance.bindDelegate(window!);
    } else {
      super.setupDelegates();
    }
  }

  /// Clear app runner state.
  ///
  void _clearState() {
    ServicesRegistry.instance.unRegisterServices(rootContext);
  }

  /// Build app wiget(in sync)
  ///
  void _buildAppWidget() {
    framework.renderer.render(
      widgets: [
        TestAppRootWidget(key: GlobalKey(appId)),
      ],
      mountAtIndex: null,
      parentContext: rootContext,
      flagCleanParentContents: false,
    );
  }
}
