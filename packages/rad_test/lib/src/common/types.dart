import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/finders.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:rad_test/src/modules/widget_tester.dart';

/// Signature for callback to [testWidgets].
///
typedef WidgetTesterCallback = Future<void> Function(WidgetTester widgetTester);

/// Signature for [CommonFinders.byWidgetPredicate].
///
typedef WidgetPredicate = bool Function(Widget widget);

/// Signature for [CommonFinders.byWidgetObjectPredicate].
///
typedef WidgetObjectPredicate = bool Function(WidgetObject element);
