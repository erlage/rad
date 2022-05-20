import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework.dart
|
| Methods to test in this file: updateChildren()
|
| This file contains widget order tests
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | updateChildren tests
  |--------------------------------------------------------------------------
  */

  group(
    'updateChildren() misc tests:',
    () {
      RT_AppRunner? app;

      setUp(() => app = createTestApp()..start());

      tearDown(() => app!.stop());

      test('should render widgets in order', () {
        app!.framework.updateChildren(
          widgets: [
            Text('widget 1'),
            Text('widget 2'),
          ],
          parentContext: app!.appContext,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootElement, RT_hasContents('widget 1|widget 2'));
      });

      test(
        'should re-render widgets in order',
        () {
          app!.framework.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              Text('widget 1 updated'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1 updated|widget 2'),
          );

          app!.framework.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2 updated'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 2 updated'),
          );

          app!.framework.updateChildren(
            widgets: [
              Text('widget 1 updated'),
              Text('widget 2 updated'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1 updated|widget 2 updated'),
          );
        },
      );

      test(
        'should keep order if a new widget is appended',
        () {
          app!.framework.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
              Division(innerText: 'widget 3'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 2|widget 3'),
          );
        },
      );

      test(
        'should re-order if a new widget is inserted',
        () {
          app!.framework.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              Text('widget 1'),
              Division(innerText: 'widget 3'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 3|widget 2'),
          );
        },
      );

      test(
        'should respect order in which new widgets are recieved',
        () {
          app!.framework.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              Text('widget 2'),
              Text('widget 1'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );
          expect(RT_TestBed.rootElement, RT_hasContents('widget 2|widget 1'));
        },
      );

      test('should respect order in which new keyed widgets are recieved', () {
        app!.framework.updateChildren(
          widgets: [
            Text('widget 1'),
            Text('widget 2', key: Key('widget 2')),
          ],
          parentContext: app!.appContext,
          updateType: UpdateType.undefined,
        );

        app!.framework.updateChildren(
          widgets: [
            Text('widget 2', key: Key('widget 2')),
            Text('widget 1'),
          ],
          parentContext: app!.appContext,
          updateType: UpdateType.undefined,
        );
        expect(RT_TestBed.rootElement, RT_hasContents('widget 2|widget 1'));
      });

      //
    },
  );
}
