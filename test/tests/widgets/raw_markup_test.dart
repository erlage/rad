// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('RawMarkUp widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render raw markup', () {
      app!.framework.buildChildren(
        widgets: [
          RawMarkUp(
            '<div id="raw">s</div>',
            //
            // so we can get element associated with raw markup
            //
            key: GlobalKey('widget'),
          ),
        ],
        parentContext: app!.appContext,
      );

      var rawElement = app!.element('widget');

      expect(rawElement.innerHtml, equals('<div id="raw">s</div>'));
    });

    test('should allow scripts', () {
      app!.framework.buildChildren(
        widgets: [
          RawMarkUp(
            '''
            <div id="raw"></div>

            <script>
              document.getElementById('raw').innerText = 'hw';
            </script>
            ''',
          ),
        ],
        parentContext: app!.appContext,
      );

      expect(app!.elementById('raw').innerHtml, equals('hw'));
    });

    test('should update raw markup', () {
      app!.framework.buildChildren(
        widgets: [
          RawMarkUp('<div id="raw">nuffin</div>'),
        ],
        parentContext: app!.appContext,
      );

      expect(app!.elementById('raw').innerHtml, equals('nuffin'));

      app!.framework.updateChildren(
        widgets: [
          RawMarkUp('<div id="raw">updated</div>'),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      expect(app!.elementById('raw').innerHtml, equals('updated'));
    });
  });
}
