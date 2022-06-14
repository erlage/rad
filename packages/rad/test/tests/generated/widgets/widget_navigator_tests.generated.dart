// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_navigator_test() {
  group('Widget specific tests for Navigator widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Navigator widget - widgetType override test', () {
      var widget = Navigator(routes: []);

      // for some reason, '$Navigator' returns Navigator0
      // if we dont add this line xD
      widget.runtimeType;

      expect(widget.widgetType, equals('$Navigator'));
    });

    test('Navigator widget - description test', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('widget'),
            routes: [
              Route(name: 'name', page: Text('hw')),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('should return true from shouldWidgetChildrenUpdate', () {
      var shouldWidgetChildrenUpdate = true;

      var oldWidget = Navigator(routes: []);
      var newWidget = Navigator(routes: []);

      shouldWidgetChildrenUpdate = newWidget.shouldWidgetChildrenUpdate(
        oldWidget,
        false,
      );
      expect(shouldWidgetChildrenUpdate, equals(false));

      shouldWidgetChildrenUpdate = newWidget.shouldWidgetChildrenUpdate(
        oldWidget,
        true,
      );
      expect(shouldWidgetChildrenUpdate, equals(false));
    });
  });
}
