@Skip('These tests are not required anymore')

// todo (before publish 0.9.0): delete this file

import '../../test_imports.dart';

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  /*
  |--------------------------------------------------------------------------
  | these tests are to ensure that we're setting display: contents for widgets
  | that must not have any visuals in dom. we're also planning to remove these
  | widgets from dom completely.
  |--------------------------------------------------------------------------
  */

  group('Display contents tests:', () {
    test('Route widget', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          Route(
            key: GlobalKey('widget'),
            name: 'some-route',
            page: Text('hw'),
          )
        ],
        parentContext: app!.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('Navigator widget', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('widget'),
            routes: [Route(name: 'some-name', page: Text(''))],
          )
        ],
        parentContext: app!.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('EventDetector widget', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          EventDetector(
            key: GlobalKey('widget'),
            child: Text('hw'),
          )
        ],
        parentContext: app!.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('InheritedWidget widget', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_InheritedWidget(
            key: GlobalKey('widget'),
            child: Text('hw'),
          )
        ],
        parentContext: app!.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('Stateful widget', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [RT_StatefulTestWidget(key: GlobalKey('widget'))],
        parentContext: app!.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('Stateless widget', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [RT_StatelessWidget(key: GlobalKey('widget'))],
        parentContext: app!.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });
  });
}
