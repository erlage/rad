// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_text_area_test() {
  group('Widget specific tests for TextArea widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('TextArea widget - widgetType override test', () {
      expect(TextArea().widgetType, equals('$TextArea'));
    });
  });
}
