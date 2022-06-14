// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_stateless_widget_test() {
  group('Widget specific tests for StatelessWidget widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Stateless widget - widgetType override test', () {
      var widget = RT_StatelessWidget();

      expect(widget.widgetType, equals('$StatelessWidget'));
    });

    test('should return false from shouldWidgetChildrenUpdate', () {
      var shouldWidgetChildrenUpdate = true;

      var oldWidget = RT_StatelessWidget();
      var newWidget = RT_StatelessWidget();

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
