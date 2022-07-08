// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | dispose widgets tests
  |--------------------------------------------------------------------------
  */

  group('disposeWidget() tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() {
      app!.stop();
    });

    test('should dispose widget', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(key: Key('el-1'), children: [Text('widget-1')]),
          RT_TestWidget(key: Key('el-2'), children: [Text('widget-2')]),
          RT_TestWidget(key: Key('el-3'), children: [Text('widget-3')]),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('el-2'),
        flagPreserveTarget: false,
      );

      expect(
        RT_TestBed.rootDomNode,
        RT_hasContents('widget-1|widget-3'),
      );
    });

    test('should dispose widgets if updated children list is empty', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('el-1'),
            children: [],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
      expect(RT_TestBed.rootDomNode, RT_hasContents(''));

      await app!.updateChildren(
        widgets: [
          RT_TestWidget(
            key: Key('el-1'),
            children: [
              RT_TestWidget(key: Key('child-1'), children: [Text('1')]),
              RT_TestWidget(key: Key('child-2'), children: [Text('2')]),
              RT_TestWidget(key: Key('child-3'), children: [Text('3')]),
            ],
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3'));

      await app!.updateChildren(
        widgets: [
          RT_TestWidget(key: Key('el-1')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents(''));
    });

    test('should dispose single widget', () async {
      // build a test app widget with few child widgets to test

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget'),
            children: [
              RT_TestWidget(
                key: Key('child-0'),
                children: [
                  Text('0'),
                  RT_TestWidget(
                    key: Key('child-0-0'),
                    children: [Text('0-0')],
                  ),
                  RT_TestWidget(
                    key: Key('child-0-1'),
                    children: [Text('0-1')],
                  ),
                ],
              ),
              RT_TestWidget(key: Key('child-1'), children: [Text('1')]),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('child-0-0'),
        flagPreserveTarget: false,
      );

      expect(
        null == app!.renderElementByKeyValue('child-0-0'),
        equals(true),
      );

      expect(
        RT_TestBed.rootDomNode,
        RT_hasContents('0|0-1|1'),
      );
    });

    test('should dispose multiple widgets', () async {
      // build a test app widget with few child widgets to test

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget'),
            children: [
              RT_TestWidget(
                key: Key('child-0'),
                children: [
                  Text('0'),
                  RT_TestWidget(
                    key: Key('child-0-0'),
                    children: [Text('0-0')],
                  ),
                  RT_TestWidget(
                    key: Key('child-0-1'),
                    children: [Text('0-1')],
                  ),
                ],
              ),
              RT_TestWidget(key: Key('child-1'), children: [Text('1')]),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('child-0-0'),
        flagPreserveTarget: false,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('child-0-1'),
        flagPreserveTarget: false,
      );

      expect(
        null == app!.renderElementByKeyValue('child-0-0'),
        equals(true),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0-1'),
        equals(true),
      );

      expect(
        RT_TestBed.rootDomNode,
        RT_hasContents('0|1'),
      );
    });

    test('should dispose widgets recursively', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget'),
            children: [
              RT_TestWidget(
                key: Key('child-0'),
                children: [
                  Text('0'),
                  RT_TestWidget(
                    key: Key('child-0-0'),
                    children: [Text('0-0')],
                  ),
                  RT_TestWidget(
                    key: Key('child-0-1'),
                    children: [Text('0-1')],
                  ),
                ],
              ),
              RT_TestWidget(key: Key('child-1'), children: [Text('1')]),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('child-0'),
        flagPreserveTarget: false,
      );

      expect(
        null == app!.renderElementByKeyValue('child-0-0'),
        equals(true),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0-1'),
        equals(true),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0'),
        equals(true),
      );

      expect(
        RT_TestBed.rootDomNode,
        RT_hasContents('1'),
      );
    });

    test('method call should be idempotent', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(key: Key('widget')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      // widget should be ready for dispose by now

      expect(
        null == app!.renderElementByKeyValue('widget'),
        equals(false),
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('widget'),
        flagPreserveTarget: false,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('widget'),
        flagPreserveTarget: false,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('widget'),
        flagPreserveTarget: false,
      );

      expect(
        null == app!.renderElementByKeyValue('widget'),
        equals(true),
      );
    });

    test('should preserve target(parent) when asked to', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget'),
            children: [
              RT_TestWidget(
                key: Key('child-0'),
                children: [
                  Text('0'),
                  RT_TestWidget(
                    key: Key('child-0-0'),
                    children: [Text('0-0')],
                  ),
                  RT_TestWidget(
                    key: Key('child-0-1'),
                    children: [Text('0-1')],
                  ),
                ],
              ),
              RT_TestWidget(key: Key('child-1'), children: [Text('1')]),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('child-0'),
        flagPreserveTarget: true,
      );

      expect(
        null == app!.renderElementByKeyValue('child-0-0'),
        equals(true),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0-1'),
        equals(true),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0'),
        equals(false),
      );

      expect(
        RT_TestBed.rootDomNode,
        RT_hasContents('|1'),
      );
    });

    test('should dispose existing widgets, in order, starting from bottom',
        () async {
      var testStack = RT_TestStack();

      // create app widget containing some child widgets to test

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('widget'),
            roEventAfterUnMount: () {
              testStack.push('this should not get unmount');
            },
            children: [
              RT_TestWidget(
                key: Key('app-child-0'),
                roEventAfterUnMount: () {
                  testStack.push('dispose-0');
                },
                children: [
                  RT_TestWidget(
                    key: Key('app-child-0-0'),
                    roEventAfterUnMount: () {
                      testStack.push('dispose-0-0');
                    },
                  ),
                  RT_TestWidget(
                    key: Key('app-child-0-1'),
                    roEventAfterUnMount: () {
                      testStack.push('dispose-0-1');
                    },
                    children: [
                      RT_TestWidget(
                        key: Key('app-child-0-1-0'),
                        roEventAfterUnMount: () {
                          testStack.push('dispose-0-1-0');
                        },
                      ),
                      RT_TestWidget(
                        key: Key('app-child-0-1-1'),
                        roEventAfterUnMount: () {
                          testStack.push('dispose-0-1-1');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: Key('app-child-1'),
                roEventAfterUnMount: () {
                  testStack.push('dispose-1');
                },
                children: [
                  // nested child widgets
                  RT_TestWidget(
                    key: Key('app-child-1-0'),
                    roEventAfterUnMount: () {
                      testStack.push('dispose-1-0');
                    },
                  ),
                  RT_TestWidget(
                    key: Key('app-child-1-1'),
                    roEventAfterUnMount: () {
                      testStack.push('dispose-1-1');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
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

      await app!.disposeWidget(
        renderElement: app!.renderElementByKeyValue('widget'),
        flagPreserveTarget: true,
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
