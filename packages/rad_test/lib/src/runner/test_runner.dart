import 'package:rad_test/src/common/types.dart';
import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/widget_tester.dart';
import 'package:rad_test/src/runner/app_runner_registry.dart';
import 'package:rad_test/src/utilities/test_stack.dart';
import 'package:rad_test/src/utilities/test_window.dart';
import 'package:test/scaffolding.dart';

/// Test environment(Test runner).
///
class TestRunner {
  final bool useWindowMock;
  final DebugOptions? debugOptions;
  final RouterOptions? routerOptions;

  TestRunner({
    this.debugOptions,
    this.routerOptions,
    required this.useWindowMock,
  });

  void testWidgets(
    String description,
    WidgetTesterCallback testBody, {
    bool? skip,
  }) {
    test(
      description,
      () async {
        var unCaughtExceptions = <Object>[];

        // 1. Create test app

        var app = AppRunnerRegistry.instance.createAppRunner(
          debugOptions: debugOptions,
          routerOptions: routerOptions,
          useWindowMock: useWindowMock,
        )..start();

        // 2. Setup exception handler

        app.services.debug.setExceptionHandler(unCaughtExceptions.add);

        // 3. Create widget tester

        var widgetTester = WidgetTester(
          app,
          this,
          stack: TestStack(),
          window: useWindowMock && app.window is TestWindow
              ? app.window as TestWindow
              : null,
          exceptionsContainer: unCaughtExceptions,
        );

        // 5. Run test body

        await testBody(widgetTester);

        // 6. Dispose test app

        AppRunnerRegistry.instance.disposeAppRunner(app);
        app.stop();

        // 7. Check results

        if (unCaughtExceptions.isNotEmpty) {
          widgetTester.printDebuggingInformation();

          for (final exception in unCaughtExceptions) {
            // ignore: only_throw_errors
            throw exception;
          }
        }
      },
      skip: skip,
    );
  }
}
