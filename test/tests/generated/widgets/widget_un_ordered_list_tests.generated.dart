// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_un_ordered_list_test() {
  group('Widget specific tests for UnOrderedList widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('UnOrderedList widget - widgetType override test', () {
      expect(UnOrderedList().widgetType, equals('$UnOrderedList'));
    });
  });
}
