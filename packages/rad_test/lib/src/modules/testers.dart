// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:rad_test/src/common/types.dart';
import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/finders.dart';
import 'package:rad_test/src/modules/widget_tester.dart';
import 'package:rad_test/src/runner/test_runner.dart';

/// Runs the [callback] inside the Rad test environment.
///
/// Use this function for testing custom [StatelessWidget]s and
/// [StatefulWidget]s.
///
/// The callback can be asynchronous (using `async`/`await` or
/// using explicit [Future]s).
///
/// This function uses the test function in the test package to
/// register the given callback as a test. The callback, when run,
/// will be given a new instance of [WidgetTester]. The [WidgetTester.find]
/// object provides convenient widget [Finder]s for use with the
/// [WidgetTester].
///
/// ## Arguments
///
/// - [description] - Test description
/// - [callback] - Test callback(body)
/// - [debugOptions] - Debug options for test app in which test will ran.
/// - [routerOptions] - Router options for test app in which test will ran.
/// - [useWindowMock] - Whether to mock window object. Helpful in testing
/// - [skip] - Skip mode for current test.
/// routing related tasks.
///
/// ## Example
///
/// ```dart
/// testWidgets('MyWidget', (WidgetTester tester) async {
///   await tester.pumpWidget(MyWidget());
///   await tester.tap(find.text('Save'));
///   expect(find.text('Success'), findsOneWidget);
/// });
/// ```
///
@isTest
void testWidgets(
  String description,
  WidgetTesterCallback callback, {
  DebugOptions? debugOptions,
  RouterOptions? routerOptions,
  bool? useWindowMock,
  bool? skip,
}) {
  var testRunner = TestRunner(
    useWindowMock: useWindowMock ?? false,
    debugOptions: debugOptions,
    routerOptions: routerOptions,
  );

  testRunner.testWidgets(
    description,
    callback,
    skip: skip,
  );
}
