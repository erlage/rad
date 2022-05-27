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
            child: Text('some', key: GlobalKey('text')),
          )
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
              child: Text('some', key: GlobalKey('text')),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
              child: Text('some', key: GlobalKey('text')),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
              child: Text('some', key: GlobalKey('text')),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
            child: Text('some', key: GlobalKey('text')),
          )
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
              child: Text('some', key: GlobalKey('text')),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
              child: Text('some', key: GlobalKey('text')),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
              child: Text('some', key: GlobalKey('text')),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
                child: Text('some', key: GlobalKey('text')),
              ),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

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
                child: Text('some', key: GlobalKey('text')),
              ),
            ),
          ),
        ],
        parentContext: app!.appContext,
      );

      app!.elementByGlobalKey('text').dispatchEvent(Event('click'));

      expect(testStack.popFromStart(), equals('child-clicked'));
      expect(testStack.popFromStart(), equals('parent-clicked'));
      expect(testStack.canPop(), equals(false));
    });
  });
}
