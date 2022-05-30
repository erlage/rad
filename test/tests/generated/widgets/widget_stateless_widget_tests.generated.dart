// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_stateless_widget_test() {
  group('Widget specific tests for StatelessWidget widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Stateless widget - widgetType override test', () {
      var widget = RT_StatelessWidget();

      expect(widget.widgetType, '$StatelessWidget');
    });

    test('Stateless widget - description test', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_StatelessWidget(
            key: GlobalKey('widget'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('widget');

      expect(
        element.dataset[Constants.attrWidgetType],
        equals('$StatelessWidget'),
      );
    });
  });
}
