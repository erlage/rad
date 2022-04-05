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
| Component test for core/classes/router.dart
|
| buildChildren() tests
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | dev mode tests
  |--------------------------------------------------------------------------
  */

  group('dev mode tests', () {
    setUp(() {
      Framework.init(routingPath: '', debugOptions: DebugOptions.defaultMode);
    });

    tearDown(Framework.tearDown);

    test('dev mode: should throw if a key contains reserved prefix _gen_', () {
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

  group('prod mode tests', () {
    setUp(() {
      Framework.init(routingPath: '', debugOptions: DebugOptions.production);
    });

    tearDown(Framework.tearDown);

    test('prod mode: should not throw if a key contains reserved prefix', () {
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

  group('common tests', () {
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

    test('should not build/clean when provided no widgets', () {
      // Why not?
      //
      // 1. buildChildren is meant for the initial render, and it should contains
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

      Framework.buildChildren(
        widgets: [],
        parentContext: RT_TestBed.rootContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('this should presist'));
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
  });
}
