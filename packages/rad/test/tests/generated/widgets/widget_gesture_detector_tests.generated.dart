// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_gesture_detector_test() {
  group('Widget specific tests for GestureDetector widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('GestureDetector widget - widgetType override test', () {
      var widget = GestureDetector(child: Text('hw'));

      expect(widget.widgetType, equals('$GestureDetector'));
    });

    test('GestureDetector widget - description test', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          GestureDetector(key: GlobalKey('widget'), child: Text('hw')),
        ],
        parentContext: pap.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });
  });
}
