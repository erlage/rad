// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_block_quote_test() {
  group('Widget specific tests for BlockQuote widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('BlockQuote widget - widgetType override test', () {
      expect(BlockQuote().widgetType, equals('$BlockQuote'));
    });
  });
}