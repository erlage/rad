// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_article_test() {
  group('Widget specific tests for Article widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Article widget - widgetType override test', () {
      expect(Article().widgetType, equals('$Article'));
    });
  });
}
