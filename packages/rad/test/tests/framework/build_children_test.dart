import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | build children common tests | should pass irrespective of dev/prod mode
  |--------------------------------------------------------------------------
  */

  group('common tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() {
      app!.stop();
    });

    test('should build a single child', () async {
      await app!.buildChildren(
        widgets: [
          Text('hello world'),
        ],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('hello world'));
    });

    test('should build multiple childs', () async {
      await app!.buildChildren(
        widgets: [
          Text('child1'),
          Text('child2'),
        ],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('child1|child2'));
    });

    test('should build nested childs', () async {
      await app!.buildChildren(
        widgets: [
          Division(
            children: [
              Text('child1'),
              Text('child2'),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('child1|child2'));
    });

    test('should build mixed and nested childs', () async {
      await app!.buildChildren(
        widgets: [
          Division(
            children: [
              Division(innerText: 'c1'),
              Text('c2'),
              Span(innerText: 'c3'),
              Division(
                children: [
                  Text('c4'),
                  Text('c5'),
                ],
              ),
              Text('c6'),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('c1|c2|c3|c4|c5|c6'));
    });

    test('should register widget object', () async {
      await app!.buildChildren(
        widgets: [
          Text('some text', key: GlobalKey('widget-key')),
        ],
        parentContext: app!.appContext,
      );

      expect(
        app!.services.walker
            .getWidgetObjectUsingKey('widget-key')!
            .context
            .key
            .value,
        equals('widget-key'),
      );
    });

    test('should mount', () async {
      await app!.buildChildren(
        widgets: [
          Text('some text 1', key: GlobalKey('find-using-me-1')),
          Text('some text 2', key: GlobalKey('find-using-me-2')),
        ],
        parentContext: app!.appContext,
      );

      expect(
        app!.services.walker
            .getWidgetObjectUsingKey('find-using-me-1')!
            .isMounted,
        equals(true),
      );

      expect(
        app!.services.walker
            .getWidgetObjectUsingKey('find-using-me-2')!
            .isMounted,
        equals(true),
      );
    });

    test('should trigger RO.afterMount hook after mount', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),
            roEventHookAfterMount: () {
              expect(
                app!.services.walker
                    .getWidgetObjectUsingKey('test-widget')!
                    .isMounted,
                equals(true),
              );
            },
          )
        ],
        parentContext: app!.appContext,
      );
    });

    test('should call render before mount', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),
            roEventHookRender: () {
              expect(
                app!.services.walker
                    .getWidgetObjectUsingKey('test-widget')!
                    .isMounted,
                equals(false),
              );
            },
          )
        ],
        parentContext: app!.appContext,
      );
    });

    test('should call afterMount after mount', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),
            roEventHookAfterMount: () {
              expect(
                app!.services.walker
                    .getWidgetObjectUsingKey('test-widget')!
                    .isMounted,
                equals(true),
              );
            },
          )
        ],
        parentContext: app!.appContext,
      );
    });

    test(
      'should build widgets in order. mixed widgets test: '
      'widgets that has no corresponding dom tags but has direct childs',
      () async {
        await app!.buildChildren(
          widgets: [
            Text('widget 1'),
            RT_InheritedWidget(
              child: Division(
                children: [
                  Text('widget 2'),
                  Division(innerText: 'widget 3'),
                ],
              ),
            ),
            Text('widget 4'),
          ],
          parentContext: app!.appContext,
        );

        expect(
          RT_TestBed.rootElement,
          RT_hasContents('widget 1|widget 2|widget 3|widget 4'),
        );
      },
    );

    test(
      'should build widgets in order. mixed widgets test: '
      'widgets that has no corresponding dom tags but has non-direct childs',
      () async {
        await app!.buildChildren(
          widgets: [
            Text('widget 1'),
            RT_StatefulTestWidget(
              children: [
                Text('widget 2'),
                Division(innerText: 'widget 3'),
              ],
            ),
            Text('widget 4'),
          ],
          parentContext: app!.appContext,
        );

        expect(
          RT_TestBed.rootElement,
          RT_hasContents('widget 1|widget 2|widget 3|widget 4'),
        );
      },
    );

    test('should build widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(roEventHookRender: () => testStack.push('build-1a')),
          RT_TestWidget(roEventHookRender: () => testStack.push('build-1b')),
          RT_TestWidget(roEventHookRender: () => testStack.push('build-1c')),
        ],
        parentContext: app!.appContext,
      );

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('build-1a'));
        expect(testStack.popFromStart(), equals('build-1b'));
        expect(testStack.popFromStart(), equals('build-1c'));

        expect(testStack.canPop(), equals(false));
      });
    });

    test('should trigger hooks in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),

            // render object hooks

            roEventHookAfterMount: () => testStack.push('afterMount'),
            roEventHookRender: () => testStack.push('render'),

            // widget hooks

            wEventHookCreateWidgetConfiguration: () => testStack.push(
              'createWidgetConfiguration',
            ),
            wEventHookCreateRenderObject: () => testStack.push(
              'createRenderObject',
            ),
          )
        ],
        parentContext: app!.appContext,
      );

      expect(testStack.popFromStart(), equals('createWidgetConfiguration'));
      expect(testStack.popFromStart(), equals('createRenderObject'));

      expect(testStack.popFromStart(), equals('render'));
      expect(testStack.popFromStart(), equals('afterMount'));

      // confirm there are no duplicate calls.
      expect(testStack.canPop(), equals(false));
    });

    test('should build widgets, in order, starting from top', () async {
      var testStack = RT_TestStack();

      // create a test app widget.
      // containing some child widgets to test.

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('widget'),
            roEventHookRender: () {
              testStack.push('render-app-widget');
            },
            children: [
              RT_TestWidget(
                key: GlobalKey('app-child-0'),
                roEventHookRender: () {
                  testStack.push('render-0');
                },
                children: [
                  RT_TestWidget(
                    key: GlobalKey('app-child-0-0'),
                    roEventHookRender: () {
                      testStack.push('render-0-0');
                    },
                  ),
                  RT_TestWidget(
                    key: GlobalKey('app-child-0-1'),
                    roEventHookRender: () {
                      testStack.push('render-0-1');
                    },
                    children: [
                      RT_TestWidget(
                        key: GlobalKey('app-child-0-1-0'),
                        roEventHookRender: () {
                          testStack.push('render-0-1-0');
                        },
                      ),
                      RT_TestWidget(
                        key: GlobalKey('app-child-0-1-1'),
                        roEventHookRender: () {
                          testStack.push('render-0-1-1');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: GlobalKey('app-child-1'),
                roEventHookRender: () {
                  testStack.push('render-1');
                },
                children: [
                  // nested child widgets
                  RT_TestWidget(
                    key: GlobalKey('app-child-1-0'),
                    roEventHookRender: () {
                      testStack.push('render-1-0');
                    },
                  ),
                  RT_TestWidget(
                    key: GlobalKey('app-child-1-1'),
                    roEventHookRender: () {
                      testStack.push('render-1-1');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      expect(testStack.popFromStart(), equals('render-app-widget'));
      expect(testStack.popFromStart(), equals('render-0'));
      expect(testStack.popFromStart(), equals('render-0-0'));
      expect(testStack.popFromStart(), equals('render-0-1'));
      expect(testStack.popFromStart(), equals('render-0-1-0'));
      expect(testStack.popFromStart(), equals('render-0-1-1'));
      expect(testStack.popFromStart(), equals('render-1'));
      expect(testStack.popFromStart(), equals('render-1-0'));
      expect(testStack.popFromStart(), equals('render-1-1'));

      expect(testStack.canPop(), equals(false));
    });

    test('should not dispose existing widgets when provided empty widget list',
        () async {
      await app!.buildChildren(
        widgets: [
          Text('this should presist'),
        ],
        parentContext: app!.appContext,
      );

      // try building, and provide no widgets to build

      await app!.buildChildren(
        widgets: [],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('this should presist'));
    });

    test('should dispose existing widgets when provided non-empty widgets list',
        () async {
      // create a test app widget.
      // containing some child widgets to test.

      await app!.buildChildren(
        widgets: [
          //
          // this is test app widget. we don't expect it to be disposed.
          //
          // we always assume that there are no exisiting widgets in document while building
          // a app widget and therefore user can have only one root widget in entire app.
          //
          RT_TestWidget(
            key: GlobalKey('widget'),
            children: [
              //
              // these are child widgets and we expect all widgets below this point in tree
              // to get disposed off correctly by the framework when a app widget's immediate
              // child widgets are changed.
              //
              RT_TestWidget(
                key: GlobalKey('child-0'),
                children: [
                  RT_TestWidget(key: GlobalKey('child-0-0')),
                  RT_TestWidget(
                    key: GlobalKey('child-0-1'),
                    children: [
                      RT_TestWidget(key: GlobalKey('child-0-1-0')),
                      RT_TestWidget(key: GlobalKey('child-0-1-1')),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: GlobalKey('child-1'),
                children: [
                  // nested child widgets
                  RT_TestWidget(key: GlobalKey('child-1-0')),
                  RT_TestWidget(key: GlobalKey('child-1-1')),
                ],
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      // ensure all are built

      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('widget'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-0'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-0-0'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-0-1'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-0-1-0'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-0-1-1'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-1'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-1-0'),
        equals(false),
      );
      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('child-1-1'),
        equals(false),
      );

      // build new child widgets under app widget. we expect this operation to
      // dispose off exisiting child widgets of app widget.

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('new-child'),
            roEventHookRender: () {
              // existing widgets should already got disposed by this point

              expect(
                null == app!.services.walker.getWidgetObjectUsingKey('child-0'),
                equals(true),
              );
              expect(
                null ==
                    app!.services.walker.getWidgetObjectUsingKey('child-0-0'),
                equals(true),
              );
              expect(
                null ==
                    app!.services.walker.getWidgetObjectUsingKey('child-0-1'),
                equals(true),
              );
              expect(
                null ==
                    app!.services.walker.getWidgetObjectUsingKey('child-0-1-0'),
                equals(true),
              );
              expect(
                null ==
                    app!.services.walker.getWidgetObjectUsingKey('child-0-1-1'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObjectUsingKey('child-1'),
                equals(true),
              );
              expect(
                null ==
                    app!.services.walker.getWidgetObjectUsingKey('child-1-0'),
                equals(true),
              );
              expect(
                null ==
                    app!.services.walker.getWidgetObjectUsingKey('child-1-1'),
                equals(true),
              );
            },
          ),
        ],
        parentContext:
            app!.services.walker.getWidgetObjectUsingKey('widget')!.context,
      );

      // app widget should not have any impact

      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('widget'),
        equals(false),
      );

      // newer child should be built

      expect(
        null == app!.services.walker.getWidgetObjectUsingKey('new-child'),
        equals(false),
      );
    });

    test('should not dispose widgets when flagCleanParentContents is off',
        () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('2'),
          Text('3'),
        ],
        parentContext: app!.appContext,
      );

      await app!.buildChildren(
        widgets: [Text('4')],
        parentContext: app!.appContext,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should continue to append new widgets when clean flag is off',
        () async {
      await app!.buildChildren(
        widgets: [Text('1')],
        parentContext: app!.appContext,
        flagCleanParentContents: true,
      );

      await app!.buildChildren(
        widgets: [
          Text('2'),
          Text('3'),
        ],
        parentContext: app!.appContext,
        flagCleanParentContents: false,
      );

      await app!.buildChildren(
        widgets: [Text('4')],
        parentContext: app!.appContext,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should mount at given index when clean flag is off', () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: app!.appContext,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentContext: app!.appContext,
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should mount at start', () async {
      await app!.buildChildren(
        widgets: [
          Text('0'),
        ],
        parentContext: app!.appContext,
      );

      await app!.buildChildren(
        widgets: [Text('insert at start')],
        parentContext: app!.appContext,
        mountAtIndex: 0,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('insert at start|0'));
    });

    test('should mount at end', () async {
      await app!.buildChildren(
        widgets: [
          Text('0'),
        ],
        parentContext: app!.appContext,
      );

      await app!.buildChildren(
        widgets: [Text('insert at end')],
        parentContext: app!.appContext,
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('0|insert at end'));
    });

    test('should mount at start if there are no exisiting widgets', () async {
      await app!.buildChildren(
        widgets: [],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents(''));

      await app!.buildChildren(
        widgets: [Text('insert at start')],
        parentContext: app!.appContext,
        mountAtIndex: 0,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('insert at start'));
    });

    test('should mount at start if no exisiting widgets and index is OOBs',
        () async {
      await app!.buildChildren(
        widgets: [],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents(''));

      await app!.buildChildren(
        widgets: [Text('insert at start')],
        parentContext: app!.appContext,
        mountAtIndex: 10,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('insert at start'));
    });

    test('should append if mount index is out of bounds', () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: app!.appContext,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentContext: app!.appContext,
        mountAtIndex: 5,
        flagCleanParentContents: false,
      );

      await app!.buildChildren(
        widgets: [Text('-1')],
        parentContext: app!.appContext,
        mountAtIndex: -5,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|3|4|2|-1'));
    });

    test('should append if mount index is provided and clean flag is not set',
        () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: app!.appContext,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentContext: app!.appContext,
        mountAtIndex: 5,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('2'));
    });

    test('should clean & build if mount index is provided but clean flag is on',
        () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: app!.appContext,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentContext: app!.appContext,
        mountAtIndex: 5,
        flagCleanParentContents: true,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('2'));
    });
  });
}