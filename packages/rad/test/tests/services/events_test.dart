import '../../test_imports.dart';

// we are using a generator script to generate tests for the event service
// tests below are old and waiting to be removed

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

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third

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

    test('should stop propagation after stopPropagation() is called', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third

      // after 1st dispatch

      expect(testStack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(testStack.popFromStart(), equals('click-parent'));

      // after 3rd dispatch

      expect(testStack.popFromStart(), equals('click-child'));
      expect(testStack.popFromStart(), equals('click-parent'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should stop propagation after stopImmediatePropagation() is called',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
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
          parentRenderElement: app!.appRenderElement,
        );

        var gparent = app!.domNodeByGlobalKey('el-g-parent');
        var parent = app!.domNodeByGlobalKey('el-parent');
        var child = app!.domNodeByGlobalKey('el-child');

        gparent.dispatchEvent(Event('click')); // first
        parent.dispatchEvent(Event('click')); // second
        child.dispatchEvent(Event('click')); // third

        // after 1st dispatch

        expect(testStack.popFromStart(), equals('click-g-parent'));

        // after 2nd dispatch

        expect(testStack.popFromStart(), equals('click-parent'));

        // after 3rd dispatch

        expect(testStack.popFromStart(), equals('click-child'));
        expect(testStack.popFromStart(), equals('click-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onClick: (_) => testStack.push('click-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onClick: (event) {
                    testStack.push('click-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('click')); // third

        expect(testStack.popFromStart(), equals('click-parent'));
        expect(testStack.popFromStart(), equals('click-g-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onClick: (_) => testStack.push('click-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onClick: (event) {
                    testStack.push('click-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onClick: (event) {
                        testStack.push('click-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('click')); // third

        expect(testStack.popFromStart(), equals('click-child'));
        expect(testStack.popFromStart(), equals('click-parent'));

        expect(testStack.canPop(), equals(false));
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

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('input')); // first
      parent.dispatchEvent(Event('input')); // second
      child.dispatchEvent(Event('input')); // third

      // after 1st dispatch

      expect(testStack.popFromStart(), equals('input-g-parent'));

      // after 2nd dispatch

      expect(testStack.popFromStart(), equals('input-parent'));

      // after 3rd dispatch

      expect(testStack.popFromStart(), equals('input-parent'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onInput: (_) => testStack.push('input-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onInput: (event) {
                    testStack.push('input-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('input')); // third

        expect(testStack.popFromStart(), equals('input-parent'));
        expect(testStack.popFromStart(), equals('input-g-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onInput: (_) => testStack.push('input-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onInput: (event) {
                    testStack.push('input-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onInput: (event) {
                        testStack.push('input-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('input')); // third

        expect(testStack.popFromStart(), equals('input-child'));
        expect(testStack.popFromStart(), equals('input-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'change' event tests
  |--------------------------------------------------------------------------
  */

  group('change event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('change')); // first
      parent.dispatchEvent(Event('change')); // second
      child.dispatchEvent(Event('change')); // third

      // after 1st dispatch

      expect(testStack.popFromStart(), equals('change-g-parent'));

      // after 2nd dispatch

      expect(testStack.popFromStart(), equals('change-parent'));

      // after 3rd dispatch

      expect(testStack.popFromStart(), equals('change-parent'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onChange: (_) => testStack.push('change-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onChange: (event) {
                    testStack.push('change-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('change')); // third

        expect(testStack.popFromStart(), equals('change-parent'));
        expect(testStack.popFromStart(), equals('change-g-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onChange: (_) => testStack.push('change-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onChange: (event) {
                    testStack.push('change-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onChange: (event) {
                        testStack.push('change-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('change')); // third

        expect(testStack.popFromStart(), equals('change-child'));
        expect(testStack.popFromStart(), equals('change-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'submit' event tests
  |--------------------------------------------------------------------------
  */

  group('submit event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('submit')); // first
      parent.dispatchEvent(Event('submit')); // second
      child.dispatchEvent(Event('submit')); // third

      // after 1st dispatch

      expect(testStack.popFromStart(), equals('submit-g-parent'));

      // after 2nd dispatch

      expect(testStack.popFromStart(), equals('submit-parent'));

      // after 3rd dispatch

      expect(testStack.popFromStart(), equals('submit-parent'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onSubmit: (_) => testStack.push('submit-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onSubmit: (event) {
                    testStack.push('submit-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('submit')); // third

        expect(testStack.popFromStart(), equals('submit-parent'));
        expect(testStack.popFromStart(), equals('submit-g-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onSubmit: (_) => testStack.push('submit-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onSubmit: (event) {
                    testStack.push('submit-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onSubmit: (event) {
                        testStack.push('submit-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('submit')); // third

        expect(testStack.popFromStart(), equals('submit-child'));
        expect(testStack.popFromStart(), equals('submit-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'keyUp' event tests
  |--------------------------------------------------------------------------
  */

  group('keyup event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('keyup')); // first
      parent.dispatchEvent(Event('keyup')); // second
      child.dispatchEvent(Event('keyup')); // third

      // after 1st dispatch

      expect(testStack.popFromStart(), equals('keyup-g-parent'));

      // after 2nd dispatch

      expect(testStack.popFromStart(), equals('keyup-parent'));

      // after 3rd dispatch

      expect(testStack.popFromStart(), equals('keyup-parent'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onKeyUp: (_) => testStack.push('keyup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyUp: (event) {
                    testStack.push('keyup-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('keyup')); // third

        expect(testStack.popFromStart(), equals('keyup-parent'));
        expect(testStack.popFromStart(), equals('keyup-g-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onKeyUp: (_) => testStack.push('keyup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyUp: (event) {
                    testStack.push('keyup-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onKeyUp: (event) {
                        testStack.push('keyup-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('keyup')); // third

        expect(testStack.popFromStart(), equals('keyup-child'));
        expect(testStack.popFromStart(), equals('keyup-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'keyDown' event tests
  |--------------------------------------------------------------------------
  */

  group('keydown event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('keydown')); // first
      parent.dispatchEvent(Event('keydown')); // second
      child.dispatchEvent(Event('keydown')); // third

      // after 1st dispatch

      expect(testStack.popFromStart(), equals('keydown-g-parent'));

      // after 2nd dispatch

      expect(testStack.popFromStart(), equals('keydown-parent'));

      // after 3rd dispatch

      expect(testStack.popFromStart(), equals('keydown-parent'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onKeyDown: (_) => testStack.push('keydown-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyDown: (event) {
                    testStack.push('keydown-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('keydown')); // third

        expect(testStack.popFromStart(), equals('keydown-parent'));
        expect(testStack.popFromStart(), equals('keydown-g-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onKeyDown: (_) => testStack.push('keydown-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyDown: (event) {
                    testStack.push('keydown-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onKeyDown: (event) {
                        testStack.push('keydown-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('keydown')); // third

        expect(testStack.popFromStart(), equals('keydown-child'));
        expect(testStack.popFromStart(), equals('keydown-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Events service | 'keyPress' event tests
  |--------------------------------------------------------------------------
  */

  group('keypress event tests:', () {
    test('should propagate event upto matching target', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
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
        parentRenderElement: app!.appRenderElement,
      );

      var gparent = app!.domNodeByGlobalKey('el-g-parent');
      var parent = app!.domNodeByGlobalKey('el-parent');
      var child = app!.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('keypress')); // first
      parent.dispatchEvent(Event('keypress')); // second
      child.dispatchEvent(Event('keypress')); // third

      // after 1st dispatch

      expect(testStack.popFromStart(), equals('keypress-g-parent'));

      // after 2nd dispatch

      expect(testStack.popFromStart(), equals('keypress-parent'));

      // after 3rd dispatch

      expect(testStack.popFromStart(), equals('keypress-parent'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onKeyPress: (_) => testStack.push('keypress-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyPress: (event) {
                    testStack.push('keypress-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('keypress')); // third

        expect(testStack.popFromStart(), equals('keypress-parent'));
        expect(testStack.popFromStart(), equals('keypress-g-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onKeyPress: (_) => testStack.push('keypress-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyPress: (event) {
                    testStack.push('keypress-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onKeyPress: (event) {
                        testStack.push('keypress-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('keypress')); // third

        expect(testStack.popFromStart(), equals('keypress-child'));
        expect(testStack.popFromStart(), equals('keypress-parent'));

        expect(testStack.canPop(), equals(false));
      },
    );
  });
}
