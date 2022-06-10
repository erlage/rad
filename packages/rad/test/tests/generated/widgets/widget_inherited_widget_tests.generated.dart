// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_inherited_widget_test() {
  group('Widget specific tests for InheritedWidget widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Inherited widget - widgetType override test', () {
      var widget = RT_InheritedWidget(child: Text('hw'));

      expect(widget.widgetType, equals('$InheritedWidget'));
    });

    test('should return false from shouldWidgetChildrenUpdate', () {
      var shouldWidgetChildrenUpdate = false;

      var oldWidget = RT_InheritedWidget(child: Text('hw'));
      var newWidget = RT_InheritedWidget(child: Text('hw'));

      shouldWidgetChildrenUpdate = newWidget.shouldWidgetChildrenUpdate(
        oldWidget,
        false,
      );
      expect(shouldWidgetChildrenUpdate, equals(true));

      shouldWidgetChildrenUpdate = newWidget.shouldWidgetChildrenUpdate(
        oldWidget,
        true,
      );
      expect(shouldWidgetChildrenUpdate, equals(true));
    });
  });
}
