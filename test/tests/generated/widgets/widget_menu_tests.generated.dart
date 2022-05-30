// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_menu_test() {
  group('Widget specific tests for Menu widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Menu widget - widgetType override test', () {
      expect(Menu().widgetType, equals('$Menu'));
    });
  });
}
