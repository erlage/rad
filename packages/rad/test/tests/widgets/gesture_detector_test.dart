// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: prefer_function_declarations_over_variables

import '../../test_imports.dart';

void main() {
  // experimental widget

  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  /*
  |--------------------------------------------------------------------------
  | Gesture Detector onTap tests
  |--------------------------------------------------------------------------
  */

  group('GestureDetector onTap tests:', () {
    test('should call onTap on tap', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTap: () => testStack.push('clicked'),
            child: Text('some', key: Key('text')),
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should propagate when hit test is translucent', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTap: () => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onTap: () => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore child when parent hit test is opaque', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTap: () => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.opaque,
            child: GestureDetector(
              onTap: () => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore parent when parent hit test is deferToChild', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTap: () => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.deferToChild,
            child: GestureDetector(
              onTap: () => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.canPop(), equals(false));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Gesture Detector onDoubleTap tests
  |--------------------------------------------------------------------------
  */

  group('GestureDetector onDoubleTap tests:', () {
    test('should call onDoubleTap on tap', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTap: () => testStack.push('clicked'),
            child: Text('some', key: Key('text')),
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should propagate when hit test is translucent', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTap: () => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onDoubleTap: () => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore child when parent hit test is opaque', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTap: () => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.opaque,
            child: GestureDetector(
              onDoubleTap: () => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore parent when parent hit test is deferToChild', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTap: () => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.deferToChild,
            child: GestureDetector(
              onDoubleTap: () => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.canPop(), equals(false));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Gesture Detector onTapEvent tests
  |--------------------------------------------------------------------------
  */

  group('GestureDetector onTapEvent tests:', () {
    test('should call onTap on tap', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTapEvent: (e) => testStack.push('clicked'),
            child: Text('some', key: Key('text')),
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should propagate when hit test is translucent', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTapEvent: (e) => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onTapEvent: (e) => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore child when parent hit test is opaque', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTapEvent: (e) => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.opaque,
            child: GestureDetector(
              onTapEvent: (e) => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore parent when parent hit test is deferToChild', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTapEvent: (e) => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.deferToChild,
            child: GestureDetector(
              onTapEvent: (e) => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should stop propagation after stopPropagation() is called', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTapEvent: (e) => testStack.push('g-parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onTapEvent: (event) {
                testStack.push('parent-clicked');
                event.stopPropagation();
              },
              child: GestureDetector(
                behaviour: HitTestBehavior.translucent,
                onTapEvent: (event) => testStack.push('child-clicked'),
                child: Text('some', key: Key('text')),
              ),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('shsould stop after stopImmediatePropagation() is called', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTap: () => testStack.push('g-parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onTapEvent: (event) {
                testStack.push('parent-clicked');
                event.stopImmediatePropagation();
              },
              child: GestureDetector(
                behaviour: HitTestBehavior.translucent,
                onTapEvent: (event) {
                  testStack.push('child-clicked');
                },
                child: Text('some', key: Key('text')),
              ),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Gesture Detector onDoubleTapEvent tests
  |--------------------------------------------------------------------------
  */

  group('GestureDetector onDoubleTapEvent tests:', () {
    test('should call onDoubleTapEvent on tap', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTapEvent: (e) => testStack.push('clicked'),
            child: Text('some', key: Key('text')),
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should propagate when hit test is translucent', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTapEvent: (e) => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onDoubleTapEvent: (e) => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore child when parent hit test is opaque', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTapEvent: (e) => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.opaque,
            child: GestureDetector(
              onDoubleTapEvent: (e) => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should ignore parent when parent hit test is deferToChild', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTapEvent: (e) => testStack.push('parent-clicked'),
            behaviour: HitTestBehavior.deferToChild,
            child: GestureDetector(
              onDoubleTapEvent: (e) => testStack.push('child-clicked'),
              child: Text('some', key: Key('text')),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('should stop propagation after stopPropagation() is called', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onDoubleTapEvent: (e) => testStack.push('g-parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onDoubleTapEvent: (event) {
                testStack.push('parent-clicked');
                event.stopPropagation();
              },
              child: GestureDetector(
                behaviour: HitTestBehavior.translucent,
                onDoubleTapEvent: (event) => testStack.push('child-clicked'),
                child: Text('some', key: Key('text')),
              ),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });

    test('shsould stop after stopImmediatePropagation() is called', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          GestureDetector(
            onTap: () => testStack.push('g-parent-clicked'),
            behaviour: HitTestBehavior.translucent,
            child: GestureDetector(
              behaviour: HitTestBehavior.translucent,
              onDoubleTapEvent: (event) {
                testStack.push('parent-clicked');
                event.stopImmediatePropagation();
              },
              child: GestureDetector(
                behaviour: HitTestBehavior.translucent,
                onDoubleTapEvent: (event) {
                  testStack.push('child-clicked');
                },
                child: Text('some', key: Key('text')),
              ),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      app!.domNodeByKeyValue('text').dispatchEvent(Event('dblclick'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Gesture Detector onMouseEnter/onMouseLeave setters
  |--------------------------------------------------------------------------
  */
  group('GestureDetector onTap tests:', () {
    test('should set mouse enter/leave', () {
      var eventListenerForMouseEnter = (event) {};
      var eventListenerForMouseLeave = (event) {};

      var widget = GestureDetector(
        onMouseEnterEvent: eventListenerForMouseEnter,
        onMouseLeaveEvent: eventListenerForMouseLeave,
        child: Text('hello world'),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseEnter],
        equals(eventListenerForMouseEnter),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseLeave],
        equals(eventListenerForMouseLeave),
      );
    });
  });
}
