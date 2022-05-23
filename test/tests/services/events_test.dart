import '../../test_imports.dart';

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  /*
  |--------------------------------------------------------------------------
  | Events service | 'click' event tests
  |--------------------------------------------------------------------------
  */

  group('click event tests:', () {
    test('should propagate event', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onClick: (_) => testStack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onClick: (_) => testStack.push('click-parent'),
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onClick: (_) => testStack.push('click-child'),
                  ),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('click-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('click-parent'));
        expect(testStack.popFromStart(), equals('click-g-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('click-child'));
        expect(testStack.popFromStart(), equals('click-parent'));
        expect(testStack.popFromStart(), equals('click-g-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });

    test('should stop propagation after stopPropagation() is called', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onClick: (_) => testStack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onClick: (event) {
                  event.stopPropagation();

                  testStack.push('click-parent');
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onClick: (_) => testStack.push('click-child'),
                  ),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('click-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('click-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('click-child'));
        expect(testStack.popFromStart(), equals('click-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });

    test(
      'should stop propagation after stopImmediatePropagation() is called',
      () async {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onClick: (_) => testStack.push('click-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onClick: (event) {
                    event.stopImmediatePropagation();

                    testStack.push('click-parent');
                  },
                  children: [
                    RT_EventfulWidget(
                      key: GlobalKey('el-child'),
                      onClick: (_) => testStack.push('click-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentContext: app!.appContext,
        );

        var gparent = app!.element('el-g-parent');
        var parent = app!.element('el-parent');
        var child = app!.element('el-child');

        gparent.dispatchEvent(Event('click')); // first
        parent.dispatchEvent(Event('click')); // second
        child.dispatchEvent(Event('click')); // third

        await Future.delayed(Duration.zero, () {
          // after 1st dispatch

          expect(testStack.popFromStart(), equals('click-g-parent'));

          // after 2nd dispatch

          expect(testStack.popFromStart(), equals('click-parent'));

          // after 3rd dispatch

          expect(testStack.popFromStart(), equals('click-child'));
          expect(testStack.popFromStart(), equals('click-parent'));

          expect(testStack.canPop(), equals(false));
        });
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'input' event tests
  |--------------------------------------------------------------------------
  */

  group('input event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onInput: (_) => testStack.push('input-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onInput: (_) => testStack.push('input-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('input')); // first
      parent.dispatchEvent(Event('input')); // second
      child.dispatchEvent(Event('input')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('input-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('input-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('input-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'change' event tests
  |--------------------------------------------------------------------------
  */

  group('change event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onChange: (_) => testStack.push('change-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onChange: (_) => testStack.push('change-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('change')); // first
      parent.dispatchEvent(Event('change')); // second
      child.dispatchEvent(Event('change')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('change-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('change-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('change-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'submit' event tests
  |--------------------------------------------------------------------------
  */

  group('submit event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onSubmit: (_) => testStack.push('submit-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onSubmit: (_) => testStack.push('submit-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('submit')); // first
      parent.dispatchEvent(Event('submit')); // second
      child.dispatchEvent(Event('submit')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('submit-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('submit-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('submit-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'keyUp' event tests
  |--------------------------------------------------------------------------
  */

  group('keyup event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyUp: (_) => testStack.push('keyup-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyUp: (_) => testStack.push('keyup-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('keyup')); // first
      parent.dispatchEvent(Event('keyup')); // second
      child.dispatchEvent(Event('keyup')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('keyup-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('keyup-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('keyup-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'keyDown' event tests
  |--------------------------------------------------------------------------
  */

  group('keydown event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyDown: (_) => testStack.push('keydown-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyDown: (_) => testStack.push('keydown-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('keydown')); // first
      parent.dispatchEvent(Event('keydown')); // second
      child.dispatchEvent(Event('keydown')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('keydown-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('keydown-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('keydown-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'keyPress' event tests
  |--------------------------------------------------------------------------
  */

  group('keypress event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyPress: (_) => testStack.push('keypress-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyPress: (_) => testStack.push('keypress-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var gparent = app!.element('el-g-parent');
      var parent = app!.element('el-parent');
      var child = app!.element('el-child');

      gparent.dispatchEvent(Event('keypress')); // first
      parent.dispatchEvent(Event('keypress')); // second
      child.dispatchEvent(Event('keypress')); // third

      await Future.delayed(Duration.zero, () {
        // after 1st dispatch

        expect(testStack.popFromStart(), equals('keypress-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('keypress-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('keypress-parent'));

        expect(testStack.canPop(), equals(false));
      });
    });
  });
}
