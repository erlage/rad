// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_event_detector_test() {
  group('Widget specific tests for EventDetector widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('EventDetector widget - widgetType override test', () {
      var widget = EventDetector(child: Text('hw'));
      expect(widget.widgetType, '$EventDetector');
    });
  });
}
