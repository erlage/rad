import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | widget order during update tests
  |--------------------------------------------------------------------------
  */

  group(
    'updateChildren() misc tests:',
    () {
      RT_AppRunner? app;

      setUp(() => app = createTestApp()..start());

      tearDown(() => app!.stop());

      test('should render widgets in order', () async {
        await app!.updateChildren(
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
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
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

          await app!.updateChildren(
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

          await app!.updateChildren(
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
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
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
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
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
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
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

      test('should respect order in which new keyed widgets are recieved',
          () async {
        await app!.updateChildren(
          widgets: [
            Text('widget 1'),
            Text('widget 2', key: Key('widget 2')),
          ],
          parentContext: app!.appContext,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('widget 2', key: Key('widget 2')),
            Text('widget 1'),
          ],
          parentContext: app!.appContext,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootElement, RT_hasContents('widget 2|widget 1'));
      });

      test(
        'should respect order in which new non-keyed widgets are recieved '
        '(widgets without corresponding dom domNodes)',
        () async {
          await app!.updateChildren(
            widgets: [
              RT_StatefulTestWidget(
                children: [
                  Text('widget 1'),
                  Division(innerText: 'widget 2'),
                ],
              )
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 2'),
          );

          await app!.updateChildren(
            widgets: [
              RT_StatefulTestWidget(
                children: [
                  Division(innerText: 'widget 2'),
                  Text('widget 1'),
                ],
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 2|widget 1'),
          );
        },
      );

      test(
        'should respect order in which new keyed widgets are recieved '
        '(widgets without corresponding dom domNodes)',
        () async {
          await app!.updateChildren(
            widgets: [
              RT_StatefulTestWidget(
                children: [
                  Text('widget 1', key: GlobalKey('widget')),
                  Division(innerText: 'widget 2'),
                ],
              )
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 2'),
          );

          await app!.updateChildren(
            widgets: [
              RT_StatefulTestWidget(
                children: [
                  Division(innerText: 'widget 2'),
                  Text('widget 1', key: GlobalKey('widget')),
                ],
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 2|widget 1'),
          );
        },
      );

      test(
        'should respect order in which new non-keyed widgets are recieved '
        '(mixed widgets, re-order mixed widget)',
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
              RT_StatefulTestWidget(
                children: [
                  Text('widget 3'),
                ],
              )
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 2|widget 3'),
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              RT_StatefulTestWidget(
                children: [
                  Text('widget 3'),
                ],
              ),
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
        'should respect order in which new keyed widgets are recieved '
        '(mixed widgets, re-order mixed widget)',
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2', key: GlobalKey('widget 2')),
              RT_StatefulTestWidget(
                children: [
                  Text('widget 3'),
                ],
              )
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 2|widget 3'),
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              RT_StatefulTestWidget(
                children: [
                  Text('widget 3'),
                ],
              ),
              Text('widget 2', key: GlobalKey('widget 2')),
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
        'should respect order in which new keyed widgets are recieved '
        '(mixed widgets, order change at multiple levels)',
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2', key: Key('widget 2')),
              RT_StatefulTestWidget(
                children: [
                  Text('widget 3'),
                  Division(innerText: 'widget 4'),
                ],
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 1|widget 2|widget 3|widget 4'),
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 2', key: Key('widget 2')),
              RT_StatefulTestWidget(
                children: [
                  Division(innerText: 'widget 4'),
                  Text('widget 3'),
                ],
              ),
              Text('widget 1'),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootElement,
            RT_hasContents('widget 2|widget 4|widget 3|widget 1'),
          );
        },
      );

      //
    },
  );
}