// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_paragraph_test() {
  group('Widget specific tests for Paragraph widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Paragraph widget - widgetType override test', () {
      expect(Paragraph().widgetType, equals('$Paragraph'));
    });
  });
}
