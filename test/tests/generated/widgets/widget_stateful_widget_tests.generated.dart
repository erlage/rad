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

    test(
      'Stateful widget - description test',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_StatefulTestWidget(
              key: GlobalKey('widget'),
            ),
          ],
          parentContext: pap.appContext,
        );

        var domNode = pap.domNodeByGlobalKey('widget');

        expect(
          domNode.dataset[Constants.attrWidgetType],
          equals('$StatefulWidget'),
        );
      },
      skip: 'we dont associate a dom node with StatefulWidget, since rad-0.9',
    );
  });
}
