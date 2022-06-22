// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_stateful_widget_test() {
  group('Widget specific tests for StatefulWidget widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Stateful widget - widgetType override test', () {
      var widget = RT_StatefulTestWidget();

      expect(widget.widgetType, equals('$StatefulWidget'));
    });

    test('should return false from shouldUpdateWidgetChildren', () {
      var shouldUpdateWidgetChildren = true;

      var oldWidget = RT_StatefulTestWidget();
      var newWidget = RT_StatefulTestWidget();

      shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(
        oldWidget,
        false,
      );
      expect(shouldUpdateWidgetChildren, equals(false));

      shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(
        oldWidget,
        true,
      );
      expect(shouldUpdateWidgetChildren, equals(false));
    }, skip: 'Core is now responsible for building/updating childs');
  });
}
