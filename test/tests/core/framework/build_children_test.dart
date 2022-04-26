import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';
import 'package:rad/widgets_internals.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import '../../../fixers/test_app.dart';
import '../../../fixers/test_bed.dart';
import '../../../fixers/test_stack.dart';
import '../../../fixers/test_widget.dart';
import '../../../matchers/has_contents.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework.dart
|
| Methods to test in this file: buildChildren()
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | dev mode tests
  |--------------------------------------------------------------------------
  */

  group('dev mode tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions.developmentMode,
      )..start();
    });

    tearDown(() {
      app!.stop();
    });

    test(
        'should throw if a key contains reserved prefix ${Constants.contextGenKeyPrefix}',
        () {
      expect(app!.services.debug.additionalChecks, equals(true));

      expect(
        () => app!.framework.buildChildren(
          widgets: [
            Text(
              'some text',
              key: Key('${Constants.contextGenKeyPrefix}is_a_reserved_previx'),
            )
          ],
          parentContext: RT_TestBed.rootContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              'Exception: Keys starting with ${Constants.contextGenKeyPrefix} are reserved ',
            ),
          ),
        ),
      );
    });
  });

  /*
  |--------------------------------------------------------------------------
  | prod mode tests
  |--------------------------------------------------------------------------
  */

  group('prod mode tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions.productionMode,
      )..start();
    });

    tearDown(() {
      app!.stop();
    });

    test('should not throw if a key contains reserved prefix', () {
      expect(app!.services.debug.additionalChecks, equals(false));

      app!.framework.buildChildren(
        widgets: [
          Text(
            'some text',
            key: Key('${Constants.contextGenKeyPrefix}is_a_reserved_previx'),
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('some text'));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | common tests | should pass irrespective of dev/prod mode
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

    test('should build a single child', () {
      app!.framework.buildChildren(
        widgets: [
          Text('hello world'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('hello world'));
    });

    test('should build multiple childs', () {
      app!.framework.buildChildren(
        widgets: [
          Text('child1'),
          Text('child2'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('child1|child2'));
    });

    test('should build nested childs', () {
      app!.framework.buildChildren(
        widgets: [
          Division(children: [
            Text('child1'),
            Text('child2'),
          ]),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('child1|child2'));
    });

    test('should build mixed and nested childs', () {
      app!.framework.buildChildren(
        widgets: [
          Division(children: [
            Division(innerText: 'c1'),
            Text('c2'),
            Span(innerText: 'c3'),
            Division(children: [
              Text('c4'),
              Text('c5'),
            ]),
            Text('c6'),
          ]),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('c1|c2|c3|c4|c5|c6'));
    });

    test('should register widget object', () {
      app!.framework.buildChildren(
        widgets: [
          Text('some text', key: GlobalKey('widget-key')),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(
        app!.services.walker.getWidgetObject('widget-key')!.context.key.value,
        equals('widget-key'),
      );
    });

    test('should trigger RO.beforeMount hook before mount', () {
      app!.framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),
            roEventHookBeforeMount: () {
              expect(
                app!.services.walker.getWidgetObject('test-widget')!.isMounted,
                equals(false),
              );
            },
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );
    });

    test('should mount', () {
      app!.framework.buildChildren(
        widgets: [
          Text('some text 1', key: GlobalKey('find-using-me-1')),
          Text('some text 2', key: GlobalKey('find-using-me-2')),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(
        app!.services.walker.getWidgetObject('find-using-me-1')!.isMounted,
        equals(true),
      );

      expect(
        app!.services.walker.getWidgetObject('find-using-me-2')!.isMounted,
        equals(true),
      );
    });

    test('should trigger RO.afterMount hook after mount', () {
      app!.framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),
            roEventHookAfterMount: () {
              expect(
                app!.services.walker.getWidgetObject('test-widget')!.isMounted,
                equals(true),
              );
            },
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );
    });

    test('should dispatch render after mount', () {
      app!.framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),
            roEventHookRender: () {
              expect(
                app!.services.walker.getWidgetObject('test-widget')!.isMounted,
                equals(true),
              );
            },
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );
    });

    test('should trigger hooks in order', () {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('test-widget'),

            // render object hooks

            roEventHookBeforeMount: () => testStack.push('beforeMount'),
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
        parentContext: RT_TestBed.rootContext,
      );

      expect(testStack.popFromStart(), equals('createWidgetConfiguration'));
      expect(testStack.popFromStart(), equals('createRenderObject'));

      expect(testStack.popFromStart(), equals('beforeMount'));
      expect(testStack.popFromStart(), equals('afterMount'));
      expect(testStack.popFromStart(), equals('render'));

      // confirm there are no duplicate calls.
      expect(testStack.canPop(), equals(false));
    });

    test('should build widgets, in order, starting from top', () {
      var testStack = RT_TestStack();

      // create a test app widget.
      // containing some child widgets to test.

      app!.framework.buildChildren(
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
        parentContext: RT_TestBed.rootContext,
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
        () {
      // Why not?
      //
      // 1. buildChildren is mostly used for the initial render, and it should contains
      //    as little work as possible.
      //
      // 2. since updateChildren is dealing with the updates and dispatching cleaning
      //    jobs we can skip that in this method.
      //

      app!.framework.buildChildren(
        widgets: [
          Text('this should presist'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      // try building, and provide no widgets to build

      app!.framework.buildChildren(
        widgets: [],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('this should presist'));
    });

    test('should dispose existing widgets when provided non-empty widgets list',
        () {
      // create a test app widget.
      // containing some child widgets to test.

      app!.framework.buildChildren(
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
        parentContext: RT_TestBed.rootContext,
      );

      // ensure all are built

      expect(null == app!.services.walker.getWidgetObject('widget'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-0'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-0-0'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-0-1'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-0-1-0'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-0-1-1'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-1'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-1-0'),
          equals(false));
      expect(null == app!.services.walker.getWidgetObject('child-1-1'),
          equals(false));

      // build new child widgets under app widget. we expect this operation to
      // dispose off exisiting child widgets of app widget.

      app!.framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('new-child'),
            roEventHookBeforeMount: () {
              // existing widgets should already got disposed by this point

              expect(
                null == app!.services.walker.getWidgetObject('child-0'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObject('child-0-0'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObject('child-0-1'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObject('child-0-1-0'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObject('child-0-1-1'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObject('child-1'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObject('child-1-0'),
                equals(true),
              );
              expect(
                null == app!.services.walker.getWidgetObject('child-1-1'),
                equals(true),
              );
            },
          ),
        ],
        parentContext: app!.services.walker.getWidgetObject('widget')!.context,
      );

      // app widget should not have any impact

      expect(null == app!.services.walker.getWidgetObject('widget'),
          equals(false));

      // newer child should be built

      expect(null == app!.services.walker.getWidgetObject('new-child'),
          equals(false));
    });

    test('should not dispose widgets when flagCleanParentContents is off', () {
      app!.framework.buildChildren(
        widgets: [
          Text('1'),
          Text('2'),
          Text('3'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      app!.framework.buildChildren(
        widgets: [Text('4')],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should continue to append new widgets when clean flag is off', () {
      app!.framework.buildChildren(
        widgets: [Text('1')],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: true,
      );

      app!.framework.buildChildren(
        widgets: [
          Text('2'),
          Text('3'),
        ],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: false,
      );

      app!.framework.buildChildren(
        widgets: [Text('4')],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should mount at given index when clean flag is off', () {
      app!.framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      app!.framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should mount at start', () {
      app!.framework.buildChildren(
        widgets: [
          Text('0'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      app!.framework.buildChildren(
        widgets: [Text('insert at start')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 0,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('insert at start|0'));
    });

    test('should mount at end', () {
      app!.framework.buildChildren(
        widgets: [
          Text('0'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      app!.framework.buildChildren(
        widgets: [Text('insert at end')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('0|insert at end'));
    });

    test('should mount at start if there are no exisiting widgets', () {
      app!.framework.buildChildren(
        widgets: [],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents(''));

      app!.framework.buildChildren(
        widgets: [Text('insert at start')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 0,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('insert at start'));
    });

    test('should mount at start if no exisiting widgets and index is OOBs', () {
      app!.framework.buildChildren(
        widgets: [],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents(''));

      app!.framework.buildChildren(
        widgets: [Text('insert at start')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 10,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('insert at start'));
    });

    test('should append if mount index is out of bounds', () {
      app!.framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      app!.framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 5,
        flagCleanParentContents: false,
      );

      app!.framework.buildChildren(
        widgets: [Text('-1')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: -5,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|3|4|2|-1'));
    });

    test('should append if mount index is provided and clean flag is not set',
        () {
      app!.framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      app!.framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 5,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('2'));
    });

    test('should clean & build if mount index is provided but clean flag is on',
        () {
      app!.framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      app!.framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 5,
        flagCleanParentContents: true,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('2'));
    });
  });
}
