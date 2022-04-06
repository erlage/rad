import 'package:rad/rad.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'package:rad/src/core/classes/framework.dart';

import '../../../fixers/test_bed.dart';
import '../../../fixers/test_stack.dart';
import '../../../fixers/test_widget.dart';
import '../../../matchers/has_contents.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/classes/framework.dart
|
| Methods to test in this file: dispose()
|--------------------------------------------------------------------------
*/

void main() {
  group('disposeWidget() tests:', () {
    setUp(() {
      Framework.init(routingPath: '');
    });

    tearDown(Framework.tearDown);

    test('should dispose single widget', () {
      // build a test app widget with few child widgets to test

      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'app-widget',
            children: [
              RT_TestWidget(
                key: 'child-0',
                children: [
                  Text('0'),
                  RT_TestWidget(key: 'child-0-0', children: [Text('0-0')]),
                  RT_TestWidget(key: 'child-0-1', children: [Text('0-1')]),
                ],
              ),
              RT_TestWidget(key: 'child-1', children: [Text('1')]),
            ],
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('child-0-0'),
        preserveTarget: false,
      );

      expect(null == Framework.getWidgetObject('child-0-0'), equals(true));

      expect(
        RT_TestBed.rootElement,
        RT_hasContents('0|0-1|1'),
      );
    });

    test('should dispose multiple widgets', () {
      // build a test app widget with few child widgets to test

      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'app-widget',
            children: [
              RT_TestWidget(
                key: 'child-0',
                children: [
                  Text('0'),
                  RT_TestWidget(key: 'child-0-0', children: [Text('0-0')]),
                  RT_TestWidget(key: 'child-0-1', children: [Text('0-1')]),
                ],
              ),
              RT_TestWidget(key: 'child-1', children: [Text('1')]),
            ],
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('child-0-0'),
        preserveTarget: false,
      );

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('child-0-1'),
        preserveTarget: false,
      );

      expect(null == Framework.getWidgetObject('child-0-0'), equals(true));
      expect(null == Framework.getWidgetObject('child-0-1'), equals(true));

      expect(
        RT_TestBed.rootElement,
        RT_hasContents('0|1'),
      );
    });

    test('should dispose widgets recursively', () {
      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'app-widget',
            children: [
              RT_TestWidget(
                key: 'child-0',
                children: [
                  Text('0'),
                  RT_TestWidget(key: 'child-0-0', children: [Text('0-0')]),
                  RT_TestWidget(key: 'child-0-1', children: [Text('0-1')]),
                ],
              ),
              RT_TestWidget(key: 'child-1', children: [Text('1')]),
            ],
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('child-0'),
        preserveTarget: false,
      );

      expect(null == Framework.getWidgetObject('child-0-0'), equals(true));
      expect(null == Framework.getWidgetObject('child-0-1'), equals(true));
      expect(null == Framework.getWidgetObject('child-0'), equals(true));

      expect(
        RT_TestBed.rootElement,
        RT_hasContents('1'),
      );
    });

    test('method call should be idempotent', () {
      Framework.buildChildren(
        widgets: [
          RT_TestWidget(key: 'app-widget'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      // widget should be ready for dispose by now

      expect(null == Framework.getWidgetObject('app-widget'), equals(false));

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('app-widget'),
        preserveTarget: false,
      );

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('app-widget'),
        preserveTarget: false,
      );

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('app-widget'),
        preserveTarget: false,
      );

      expect(null == Framework.getWidgetObject('app-widget'), equals(true));
    });

    test('should preserve target(parent) when asked to', () {
      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'app-widget',
            children: [
              RT_TestWidget(
                key: 'child-0',
                children: [
                  Text('0'),
                  RT_TestWidget(key: 'child-0-0', children: [Text('0-0')]),
                  RT_TestWidget(key: 'child-0-1', children: [Text('0-1')]),
                ],
              ),
              RT_TestWidget(key: 'child-1', children: [Text('1')]),
            ],
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('child-0'),
        preserveTarget: true,
      );

      expect(null == Framework.getWidgetObject('child-0-0'), equals(true));
      expect(null == Framework.getWidgetObject('child-0-1'), equals(true));
      expect(null == Framework.getWidgetObject('child-0'), equals(false));

      expect(
        RT_TestBed.rootElement,
        RT_hasContents('|1'),
      );
    });

    test('should dispose existing widgets, in order, starting from bottom', () {
      var testStack = RT_TestStack();

      // create app widget containing some child widgets to test

      Framework.buildChildren(
        widgets: [
          RT_TestWidget(
            key: 'app-widget',
            roEventHookBeforeUnMount: () {
              testStack.push('this should not get unmount');
            },
            children: [
              RT_TestWidget(
                key: 'app-child-0',
                roEventHookBeforeUnMount: () {
                  testStack.push('dispose-0');
                },
                children: [
                  RT_TestWidget(
                    key: 'app-child-0-0',
                    roEventHookBeforeUnMount: () {
                      testStack.push('dispose-0-0');
                    },
                  ),
                  RT_TestWidget(
                    key: 'app-child-0-1',
                    roEventHookBeforeUnMount: () {
                      testStack.push('dispose-0-1');
                    },
                    children: [
                      RT_TestWidget(
                        key: 'app-child-0-1-0',
                        roEventHookBeforeUnMount: () {
                          testStack.push('dispose-0-1-0');
                        },
                      ),
                      RT_TestWidget(
                        key: 'app-child-0-1-1',
                        roEventHookBeforeUnMount: () {
                          testStack.push('dispose-0-1-1');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: 'app-child-1',
                roEventHookBeforeUnMount: () {
                  testStack.push('dispose-1');
                },
                children: [
                  // nested child widgets
                  RT_TestWidget(
                    key: 'app-child-1-0',
                    roEventHookBeforeUnMount: () {
                      testStack.push('dispose-1-0');
                    },
                  ),
                  RT_TestWidget(
                    key: 'app-child-1-1',
                    roEventHookBeforeUnMount: () {
                      testStack.push('dispose-1-1');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      // expected tree and dispose order:
      //
      // 0             : d(4)
      //    0-0        : d(0) - first dispose
      //    0-1        : d(3)
      //        0-1-0  : d(1) - second dispose
      //        0-1-1  : d(2) - third dispose, and so on
      // 1             : d(7)
      //    1-0        : d(5)
      //    1-1        : d(6)
      //

      Framework.disposeWidget(
        widgetObject: Framework.getWidgetObject('app-widget'),
        preserveTarget: true,
      );

      expect(testStack.popFromStart(), equals('dispose-0-0'));
      expect(testStack.popFromStart(), equals('dispose-0-1-0'));
      expect(testStack.popFromStart(), equals('dispose-0-1-1'));
      expect(testStack.popFromStart(), equals('dispose-0-1'));
      expect(testStack.popFromStart(), equals('dispose-0'));
      expect(testStack.popFromStart(), equals('dispose-1-0'));
      expect(testStack.popFromStart(), equals('dispose-1-1'));
      expect(testStack.popFromStart(), equals('dispose-1'));

      expect(testStack.canPop(), equals(false));
    });
  });
}
