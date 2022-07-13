// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('$RawEventDetector widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should allow child to get rendered', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: Text('some text'),
          )
        ],
        parentRenderElement: pap.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('some text'));
    });

    test('should allow child to get updated', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: Text('some text'),
          )
        ],
        parentRenderElement: pap.appRenderElement,
      );

      await pap.updateChildren(
        widgets: [
          RawEventDetector(
            child: Text('updated text'),
          )
        ],
        updateType: UpdateType.setState,
        parentRenderElement: pap.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('updated text'));
    });
  });

  group('$RawEventDetector widget tests in bubble phase:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should add event listeners', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: Text(
              'some text',
              key: Key('el'),
            ),
            events: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('el');
      domNode.dispatchEvent(Event('click'));
      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('click'));
      expect(pap.stack.popFromStart(), equals('dblclick'));
      expect(pap.stack.canPop(), equals(false));
    });

    test('should update event listeners', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: Text(
              'some text',
              key: Key('el'),
            ),
            events: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      await pap.updateChildren(
        widgets: [
          RawEventDetector(
            child: Text(
              'some text',
              key: Key('el'),
            ),
            events: {
              'click': (_) => pap.stack.push('updated-click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('el');
      domNode.dispatchEvent(Event('click'));
      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('updated-click'));
      expect(pap.stack.popFromStart(), equals('dblclick'));
      expect(pap.stack.canPop(), equals(false));
    });

    test('should remove event listeners', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: Text(
              'some text',
              key: Key('el'),
            ),
            events: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      await pap.updateChildren(
        widgets: [
          RawEventDetector(
            child: Text(
              'some text',
              key: Key('el'),
            ),
            events: {
              'click': (_) => pap.stack.push('click'),
            },
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('el');
      domNode.dispatchEvent(Event('click'));
      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('click'));
      expect(pap.stack.canPop(), equals(false));
    });

    test(
      'should adjust event listeners if immediate childs has changed',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RawEventDetector(
              child: Text(
                'some text',
                key: Key('el'),
              ),
              events: {
                'click': (_) => pap.stack.push('click'),
                'dblclick': (_) => pap.stack.push('dblclick'),
              },
            ),
          ],
          parentRenderElement: pap.appRenderElement,
        );

        await pap.updateChildren(
          widgets: [
            RawEventDetector(
              child: Division(
                children: [
                  Text(
                    'some text',
                    key: Key('el'),
                  ),
                ],
              ),
              events: {
                'click': (_) => pap.stack.push('click'),
                'dblclick': (_) => pap.stack.push('dblclick'),
              },
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: pap.appRenderElement,
        );

        var domNode = pap.domNodeByKeyValue('el');
        domNode.dispatchEvent(Event('click'));
        domNode.dispatchEvent(Event('dblclick'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('click'));
        expect(pap.stack.popFromStart(), equals('dblclick'));
        expect(pap.stack.canPop(), equals(false));
      },
    );

    test('should adjust event listeners if deep childs has changed', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: Division(
              children: [
                Division(
                  children: [
                    Text(
                      'some text',
                      key: Key('el'),
                    ),
                  ],
                ),
              ],
            ),
            events: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      await pap.updateChildren(
        widgets: [
          RawEventDetector(
            child: Division(
              children: [
                Text(
                  'some text',
                  key: Key('el'),
                ),
              ],
            ),
            events: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('el');
      domNode.dispatchEvent(Event('click'));
      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('click'));
      expect(pap.stack.popFromStart(), equals('dblclick'));
      expect(pap.stack.canPop(), equals(false));
    });
  });

  group('$RawEventDetector widget tests in capture phase:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should add event listeners', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: RawEventDetector(
              child: Text(
                'some text',
                key: Key('el'),
              ),
              events: {
                'click': (_) => pap.stack.push('click-bubble'),
                'dblclick': (_) => pap.stack.push('dblclick-bubble'),
              },
            ),
            eventsCapture: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('el');
      domNode.dispatchEvent(Event('click'));
      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('click'));
      expect(pap.stack.popFromStart(), equals('click-bubble'));

      expect(pap.stack.popFromStart(), equals('dblclick'));
      expect(pap.stack.popFromStart(), equals('dblclick-bubble'));
      expect(pap.stack.canPop(), equals(false));
    });

    test('should update event listeners', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: RawEventDetector(
              child: Text(
                'some text',
                key: Key('el'),
              ),
              events: {
                'click': (_) => pap.stack.push('click-bubble'),
                'dblclick': (_) => pap.stack.push('dblclick-bubble'),
              },
            ),
            eventsCapture: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      await pap.updateChildren(
        widgets: [
          RawEventDetector(
            child: RawEventDetector(
              child: Text(
                'some text',
                key: Key('el'),
              ),
              events: {
                'click': (_) => pap.stack.push('updated-click-bubble'),
                'dblclick': (_) => pap.stack.push('dblclick-bubble'),
              },
            ),
            eventsCapture: {
              'click': (_) => pap.stack.push('updated-click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('el');
      domNode.dispatchEvent(Event('click'));
      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('updated-click'));
      expect(pap.stack.popFromStart(), equals('updated-click-bubble'));
      expect(pap.stack.popFromStart(), equals('dblclick'));
      expect(pap.stack.popFromStart(), equals('dblclick-bubble'));
      expect(pap.stack.canPop(), equals(false));
    });

    test('should remove event listeners', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RawEventDetector(
            child: RawEventDetector(
              child: Text(
                'some text',
                key: Key('el'),
              ),
              events: {
                'click': (_) => pap.stack.push('click-bubble'),
                'dblclick': (_) => pap.stack.push('dblclick-bubble'),
              },
            ),
            eventsCapture: {
              'click': (_) => pap.stack.push('click'),
              'dblclick': (_) => pap.stack.push('dblclick'),
            },
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      await pap.updateChildren(
        widgets: [
          RawEventDetector(
            child: RawEventDetector(
              child: Text(
                'some text',
                key: Key('el'),
              ),
              events: {
                'click': (_) => pap.stack.push('click-bubble'),
              },
            ),
            eventsCapture: {
              'click': (_) => pap.stack.push('click'),
            },
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('el');
      domNode.dispatchEvent(Event('click'));
      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('click'));
      expect(pap.stack.popFromStart(), equals('click-bubble'));
      expect(pap.stack.canPop(), equals(false));
    });
  });
}
