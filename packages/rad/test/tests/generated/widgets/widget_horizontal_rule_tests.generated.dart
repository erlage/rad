// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_horizontal_rule_test() {
  group('Widget specific tests for HorizontalRule widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('HorizontalRule widget - widgetType override test', () {
      expect(HorizontalRule().widgetType, equals('$HorizontalRule'));
    });
  });
}
