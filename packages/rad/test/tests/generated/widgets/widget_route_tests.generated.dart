// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_route_test() {
  group('Widget specific tests for Route widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Route widget - widgetType override test', () {
      var widget = Route(
        name: '',
        page: Text('hw'),
      );

      expect(widget.widgetType, equals('$Route'));
    });

    test('Route widget - description test', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          Route(
            key: GlobalKey('widget'),
            name: 'some-name',
            page: Text('hw'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });
  });
}
