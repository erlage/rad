// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_inherited_widget_test() {
  group('Widget specific tests for InheritedWidget widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Inherited widget - widgetType override test', () {
      var widget = RT_InheritedWidget(child: Text('hw'));

      expect(widget.widgetType, '$InheritedWidget');
    });

    test('Inherited widget - description test', () {
      var set = inheritedWidgetDescription.dataset;

      expect(set[Constants.attrWidgetType], '$InheritedWidget');
    });
  });
}
