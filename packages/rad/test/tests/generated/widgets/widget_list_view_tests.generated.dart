// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_list_view_test() {
  group('Widget specific tests for ListView widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('ListView widget - widgetType override test', () {
      var widget = ListView(children: []);

      expect(widget.widgetType, equals('$ListView'));
    });
  });
}
