// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('widget 1|widget 2'));
      });

      test(
        'should re-render widgets in order',
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 1 updated'),
              Text('widget 2'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 1 updated|widget 2'),
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2 updated'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 1|widget 2 updated'),
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 1 updated'),
              Text('widget 2 updated'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
              Division(innerText: 'widget 3'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Division(innerText: 'widget 3'),
              Text('widget 2'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 1|widget 3|widget 2'),
          );
        },
      );

      test(
        'should respect order in which new widgets are received',
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              Text('widget 2'),
              Text('widget 1'),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('widget 2|widget 1'));
        },
      );

      test('should respect order in which new keyed widgets are received',
          () async {
        await app!.updateChildren(
          widgets: [
            Text('widget 1'),
            Text('widget 2', key: Key('widget 2')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('widget 2', key: Key('widget 2')),
            Text('widget 1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('widget 2|widget 1'));
      });

      test(
        'should respect order in which new non-keyed widgets are received '
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 2|widget 1'),
          );
        },
      );

      test(
        'should respect order in which new keyed widgets are received '
        '(widgets without corresponding dom domNodes)',
        () async {
          await app!.updateChildren(
            widgets: [
              RT_StatefulTestWidget(
                children: [
                  Text('widget 1', key: Key('widget')),
                  Division(innerText: 'widget 2'),
                ],
              )
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 1|widget 2'),
          );

          await app!.updateChildren(
            widgets: [
              RT_StatefulTestWidget(
                children: [
                  Division(innerText: 'widget 2'),
                  Text('widget 1', key: Key('widget')),
                ],
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 2|widget 1'),
          );
        },
      );

      test(
        'should respect order in which new non-keyed widgets are received '
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 1|widget 3|widget 2'),
          );
        },
      );

      test(
        'should respect order in which new keyed widgets are received '
        '(mixed widgets, re-order mixed widget)',
        () async {
          await app!.updateChildren(
            widgets: [
              Text('widget 1'),
              Text('widget 2', key: Key('widget 2')),
              RT_StatefulTestWidget(
                children: [
                  Text('widget 3'),
                ],
              )
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
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
              Text('widget 2', key: Key('widget 2')),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 1|widget 3|widget 2'),
          );
        },
      );

      test(
        'should respect order in which new keyed widgets are received '
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
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
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(
            RT_TestBed.rootDomNode,
            RT_hasContents('widget 2|widget 4|widget 3|widget 1'),
          );
        },
      );

      test('should respect widgets order(simple swap test)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('2')),
            Text('3', key: Key('3')),
            Text('4', key: Key('4')),
            Text('5', key: Key('5')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4|5'));

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('4', key: Key('4')),
            Text('3', key: Key('3')),
            Text('2', key: Key('2')),
            Text('5', key: Key('5')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|4|3|2|5'));
      });

      test('should respect widgets order(swap key + content test)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('2')),
            Text('3', key: Key('3')),
            Text('4', key: Key('4')),
            Text('5', key: Key('5')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4|5'));

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('4')),
            Text('3', key: Key('3')),
            Text('4', key: Key('2')),
            Text('5', key: Key('5')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4|5'));

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('4', key: Key('4')),
            Text('3', key: Key('3')),
            Text('2', key: Key('2')),
            Text('5', key: Key('5')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|4|3|2|5'));
      });

      test('should respect widgets order(swap and delete test)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('2')),
            Text('3', key: Key('3')),
            Text('4', key: Key('4')),
            Text('5', key: Key('5')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('4', key: Key('4')),
            Text('3', key: Key('3')),
            Text('5', key: Key('5'))
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|4|3|5'));
      });

      test('should respect widgets order(non-keyed appends)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('1'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2'));

        await app!.updateChildren(
          widgets: [
            Text('1'),
            Text('2'),
            Text('3'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3'));
      });

      test('should respect widgets order(non-keyed prepends)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('2'),
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('2|1'));

        await app!.updateChildren(
          widgets: [
            Text('3'),
            Text('2'),
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('3|2|1'));
      });

      test('should respect widgets order(non-keyed removals)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1'),
            Text('2'),
            Text('3'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('1'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2'));

        await app!.updateChildren(
          widgets: [
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1'));
      });

      test('should respect widgets order(non-keyed reverse removals)',
          () async {
        await app!.updateChildren(
          widgets: [
            Text('3'),
            Text('2'),
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('2'),
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('2|1'));

        await app!.updateChildren(
          widgets: [
            Text('1'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1'));
      });

      test('should respect widgets order(keyed appends)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('2')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2'));

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('2')),
            Text('3', key: Key('3')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3'));
      });

      test('should respect widgets order(keyed prepends)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('2', key: Key('2')),
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('2|1'));

        await app!.updateChildren(
          widgets: [
            Text('3', key: Key('3')),
            Text('2', key: Key('2')),
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('3|2|1'));
      });

      test('should respect widgets order(keyed removals)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('2')),
            Text('3', key: Key('3')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
            Text('2', key: Key('2')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2'));

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1'));
      });

      test('should respect widgets order(keyed reverse removals)', () async {
        await app!.updateChildren(
          widgets: [
            Text('3', key: Key('3')),
            Text('2', key: Key('2')),
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('2', key: Key('2')),
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('2|1'));

        await app!.updateChildren(
          widgets: [
            Text('1', key: Key('1')),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1'));
      });

      test(
        'should differentiate keyed and non-keyed widgets of same runtime type',
        () async {
          await app!.buildChildren(
            widgets: [
              Text(
                'keyed-1',
                key: Key('0'),
              ),
              Text(
                'non-keyed-1',
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('keyed-1|non-keyed-1'));

          await app!.updateChildren(
            widgets: [
              Text(
                'non-keyed-1',
              ),
              Text(
                'keyed-1',
                key: Key('0'),
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('non-keyed-1|keyed-1'));
        },
      );

      test('should respect order(insertions in the middle)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('1'),
            Division(innerText: 'n1'),
            Division(innerText: 'n2'),
            Division(innerText: 'n3'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|n1|n2|n3|2'));
      });

      test('should respect order(disposals from the middle)', () async {
        await app!.updateChildren(
          widgets: [
            Text('1'),
            Division(innerText: 'n1'),
            Division(innerText: 'n2'),
            Division(innerText: 'n2'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Text('1'),
            Division(innerText: 'n1'),
            Division(innerText: 'n2'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|n1|n2|2'));

        await app!.updateChildren(
          widgets: [
            Text('1'),
            Division(innerText: 'n2'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|n2|2'));

        await app!.updateChildren(
          widgets: [
            Text('1'),
            Text('2'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );
        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2'));
      });

      test('should respect order render tree(keyed insertions)', () async {
        await app!.updateChildren(
          widgets: [
            Span(key: Key('0'), innerText: '0'),
            Division(key: Key('3'), innerText: '3'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            Span(key: Key('0'), innerText: '0'),
            Division(key: Key('1'), innerText: '1'),
            Span(key: Key('2'), innerText: '2'),
            Division(key: Key('3'), innerText: '3'),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('0|1|2|3'));

        var childElements = app!.appRenderElement.frameworkChildElements;
        expect(childElements.length, equals(4));

        expect(childElements[0].widget.runtimeType, equals(Span));
        expect((childElements[0].widget as Span).innerText, equals('0'));

        expect(childElements[1].widget.runtimeType, equals(Division));
        expect((childElements[1].widget as Division).innerText, equals('1'));

        expect(childElements[2].widget.runtimeType, equals(Span));
        expect((childElements[2].widget as Span).innerText, equals('2'));

        expect(childElements[3].widget.runtimeType, equals(Division));
        expect((childElements[3].widget as Division).innerText, equals('3'));
      });
      //
    },
  );
}
