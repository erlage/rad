import 'package:rad/rad.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import 'package:rad/src/core/classes/framework.dart';

import '../../../fixers/test_bed.dart';
import '../../../fixers/test_stack.dart';
import '../../../fixers/test_widget.dart';
import '../../../matchers/has_contents.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/classes/framework.dart
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
    setUp(() {
      Framework.init(routingPath: '', debugOptions: DebugOptions.defaultMode);
    });

    tearDown(Framework.tearDown);

    test('should throw if a key contains reserved prefix _gen_', () {
      expect(
        () => Framework.buildChildren(
          widgets: [Text('some text', key: '_gen_is_a_reserved_previx')],
          parentContext: RT_TestBed.rootContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              'Exception: Keys starting with _gen_ are reserved',
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
    setUp(() {
      Framework.init(routingPath: '', debugOptions: DebugOptions.production);
    });

    tearDown(Framework.tearDown);

    test('should not throw if a key contains reserved prefix', () {
      Framework.buildChildren(
        widgets: [Text('some text', key: '_gen_is_a_reserved_previx')],
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
    setUp(() {
      Framework.init(routingPath: '');
    });

    tearDown(Framework.tearDown);

    test('should build a single child', () {
      Framework.buildChildren(
        widgets: [
          Text('hello world'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('hello world'));
    });

    test('should build multiple childs', () {
      Framework.buildChildren(
        widgets: [
          Text('child1'),
          Text('child2'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('child1|child2'));
    });

    test('should build nested childs', () {
      Framework.buildChildren(
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
      Framework.buildChildren(
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
      Framework.buildChildren(
        widgets: [
          Text('some text', key: 'widget-key'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(
        Framework.getWidgetObject('widget-key')!.context.key,
        equals('widget-key'),
      );
    });

    test('should trigger RO.beforeMount hook before mount', () {
      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'test-widget',
            roEventHookBeforeMount: () {
              expect(
                Framework.getWidgetObject('test-widget')!.isMounted,
                equals(false),
              );
            },
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );
    });

    test('should mount', () {
      Framework.buildChildren(
        widgets: [
          Text('some text 1', key: 'find-using-me-1'),
          Text('some text 2', key: 'find-using-me-2'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      expect(
        Framework.getWidgetObject('find-using-me-1')!.isMounted,
        equals(true),
      );

      expect(
        Framework.getWidgetObject('find-using-me-2')!.isMounted,
        equals(true),
      );
    });

    test('should trigger RO.afterMount hook after mount', () {
      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'test-widget',
            roEventHookAfterMount: () {
              expect(
                Framework.getWidgetObject('test-widget')!.isMounted,
                equals(true),
              );
            },
          )
        ],
        parentContext: RT_TestBed.rootContext,
      );
    });

    test('should dispatch render after mount', () {
      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'test-widget',
            roEventHookRender: () {
              expect(
                Framework.getWidgetObject('test-widget')!.isMounted,
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

      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'test-widget',

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

      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'app-widget',
            roEventHookRender: () {
              testStack.push('render-app-widget');
            },
            children: [
              RT_TestWidget(
                key: 'app-child-0',
                roEventHookRender: () {
                  testStack.push('render-0');
                },
                children: [
                  RT_TestWidget(
                    key: 'app-child-0-0',
                    roEventHookRender: () {
                      testStack.push('render-0-0');
                    },
                  ),
                  RT_TestWidget(
                    key: 'app-child-0-1',
                    roEventHookRender: () {
                      testStack.push('render-0-1');
                    },
                    children: [
                      RT_TestWidget(
                        key: 'app-child-0-1-0',
                        roEventHookRender: () {
                          testStack.push('render-0-1-0');
                        },
                      ),
                      RT_TestWidget(
                        key: 'app-child-0-1-1',
                        roEventHookRender: () {
                          testStack.push('render-0-1-1');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: 'app-child-1',
                roEventHookRender: () {
                  testStack.push('render-1');
                },
                children: [
                  // nested child widgets
                  RT_TestWidget(
                    key: 'app-child-1-0',
                    roEventHookRender: () {
                      testStack.push('render-1-0');
                    },
                  ),
                  RT_TestWidget(
                    key: 'app-child-1-1',
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

      Framework.buildChildren(
        widgets: [
          Text('this should presist'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      // try building, and provide no widgets to build

      Framework.buildChildren(
        widgets: [],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('this should presist'));
    });

    test('should dispose existing widgets when provided non-empty widgets list',
        () {
      // create a test app widget.
      // containing some child widgets to test.

      Framework.buildChildren(
        widgets: [
          //
          // this is test app widget. we don't expect it to be disposed.
          //
          // we always assume that there are no exisiting widgets in document while building
          // a app widget and therefore user can have only one root widget in entire app.
          //
          RT_TestWidget(
            key: 'app-widget',
            children: [
              //
              // these are child widgets and we expect all widgets below this point in tree
              // to get disposed off correctly by the framework when a app widget's immediate
              // child widgets are changed.
              //
              RT_TestWidget(
                key: 'child-0',
                children: [
                  RT_TestWidget(key: 'child-0-0'),
                  RT_TestWidget(
                    key: 'child-0-1',
                    children: [
                      RT_TestWidget(key: 'child-0-1-0'),
                      RT_TestWidget(key: 'child-0-1-1'),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: 'child-1',
                children: [
                  // nested child widgets
                  RT_TestWidget(key: 'child-1-0'),
                  RT_TestWidget(key: 'child-1-1'),
                ],
              ),
            ],
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      // ensure all are built

      expect(null == Framework.getWidgetObject('app-widget'), equals(false));
      expect(null == Framework.getWidgetObject('child-0'), equals(false));
      expect(null == Framework.getWidgetObject('child-0-0'), equals(false));
      expect(null == Framework.getWidgetObject('child-0-1'), equals(false));
      expect(null == Framework.getWidgetObject('child-0-1-0'), equals(false));
      expect(null == Framework.getWidgetObject('child-0-1-1'), equals(false));
      expect(null == Framework.getWidgetObject('child-1'), equals(false));
      expect(null == Framework.getWidgetObject('child-1-0'), equals(false));
      expect(null == Framework.getWidgetObject('child-1-1'), equals(false));

      // build new child widgets under app widget. we expect this operation to
      // dispose off exisiting child widgets of app widget.

      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'new-child',
            roEventHookBeforeMount: () {
              // existing widgets should already got disposed by this point

              expect(
                null == Framework.getWidgetObject('child-0'),
                equals(true),
              );
              expect(
                null == Framework.getWidgetObject('child-0-0'),
                equals(true),
              );
              expect(
                null == Framework.getWidgetObject('child-0-1'),
                equals(true),
              );
              expect(
                null == Framework.getWidgetObject('child-0-1-0'),
                equals(true),
              );
              expect(
                null == Framework.getWidgetObject('child-0-1-1'),
                equals(true),
              );
              expect(
                null == Framework.getWidgetObject('child-1'),
                equals(true),
              );
              expect(
                null == Framework.getWidgetObject('child-1-0'),
                equals(true),
              );
              expect(
                null == Framework.getWidgetObject('child-1-1'),
                equals(true),
              );
            },
          ),
        ],
        parentContext: Framework.getWidgetObject('app-widget')!.context,
      );

      // app widget should not have any impact

      expect(null == Framework.getWidgetObject('app-widget'), equals(false));

      // newer child should be built

      expect(null == Framework.getWidgetObject('new-child'), equals(false));
    });

    test('should not dispose widgets when flagCleanParentContents is off', () {
      Framework.buildChildren(
        widgets: [
          Text('1'),
          Text('2'),
          Text('3'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.buildChildren(
        widgets: [Text('4')],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should continue to append new widgets when clean flag is off', () {
      Framework.buildChildren(
        widgets: [Text('1')],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: true,
      );

      Framework.buildChildren(
        widgets: [
          Text('2'),
          Text('3'),
        ],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: false,
      );

      Framework.buildChildren(
        widgets: [Text('4')],
        parentContext: RT_TestBed.rootContext,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should mount at given index when clean flag is off', () {
      Framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|2|3|4'));
    });

    test('should append if mount index is out of bounds', () {
      Framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 5,
        flagCleanParentContents: false,
      );

      Framework.buildChildren(
        widgets: [Text('-1')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: -5,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('1|3|4|2|-1'));
    });

    test('should append if mount index is provided but clean flag is not set',
        () {
      Framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 5,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('2'));
    });

    test('should append if mount index is provided but clean flag is on', () {
      Framework.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.buildChildren(
        widgets: [Text('2')],
        parentContext: RT_TestBed.rootContext,
        mountAtIndex: 5,
        flagCleanParentContents: true,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('2'));
    });
  });
}
