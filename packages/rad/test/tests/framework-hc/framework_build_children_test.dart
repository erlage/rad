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
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('hello world'));
    });

    test('should build multiple child widgets', () async {
      await app!.buildChildren(
        widgets: [
          Text('child1'),
          Text('child2'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('child1|child2'));
    });

    test('should build nested child widgets', () async {
      await app!.buildChildren(
        widgets: [
          Division(
            children: [
              Text('child1'),
              Text('child2'),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('child1|child2'));
    });

    test('should build mixed and nested child widgets', () async {
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
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('c1|c2|c3|c4|c5|c6'));
    });

    test('should register render element', () async {
      await app!.buildChildren(
        widgets: [
          Text('some text', key: Key('widget-key')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(
        app!.renderElementByKeyValue('widget-key')!.key?.frameworkValue,
        equals('widget-key'),
      );
    });

    test('should mount', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(key: Key('find-using-me-1')),
          RT_TestWidget(key: Key('find-using-me-2')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var e1 = app!.renderElementByKeyValue('find-using-me-1')!;
      var e2 = app!.renderElementByKeyValue('find-using-me-2')!;

      expect(
        (e1 as WatchfulRenderElement).isMounted,
        equals(true),
      );

      expect(
        (e2 as WatchfulRenderElement).isMounted,
        equals(true),
      );
    });

    test('should call afterMount hook after mount', () async {
      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('test-widget'),
            roEventAfterMount: () {
              var e1 = app!.renderElementByKeyValue('test-widget')!;

              expect(
                (e1 as WatchfulRenderElement).isMounted,
                equals(true),
              );
            },
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );
    });

    test('should call render before mount', () async {
      RenderElement? renderElement;

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('test-widget'),
            wHookCreateRenderElement: (element) => renderElement = element,
            roEventRender: () {
              var e1 = renderElement!;

              expect(
                (e1 as WatchfulRenderElement).isMounted,
                equals(false),
              );
            },
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );
    });

    test(
      'should build widgets in order. mixed widgets test: '
      'widgets that has no corresponding dom tags but has direct child widgets',
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
          parentRenderElement: app!.appRenderElement,
        );

        expect(
          RT_TestBed.rootDomNode,
          RT_hasContents('widget 1|widget 2|widget 3|widget 4'),
        );
      },
    );

    test(
      'should build widgets in order. mixed widgets test: '
      'widgets that has no corresponding dom tags but has non-direct child widgets',
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
          parentRenderElement: app!.appRenderElement,
        );

        expect(
          RT_TestBed.rootDomNode,
          RT_hasContents('widget 1|widget 2|widget 3|widget 4'),
        );
      },
    );

    test('should build widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(roEventRender: () => testStack.push('build-1a')),
          RT_TestWidget(roEventRender: () => testStack.push('build-1b')),
          RT_TestWidget(roEventRender: () => testStack.push('build-1c')),
        ],
        parentRenderElement: app!.appRenderElement,
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
            key: Key('test-widget'),

            // render object hooks

            // should call this
            roEventAfterMount: () => testStack.push('afterMount'),
            // should call this
            roEventRender: () => testStack.push('render'),

            // should not call this
            wEventShouldUpdateWidget: () => testStack.push(
              'shouldUpdateWidget',
            ),

            // should not call this
            wEventShouldUpdateWidgetChildren: () => testStack.push(
              'shouldUpdateWidgetChildren',
            ),

            // should call this
            wEventCreateRenderObject: () => testStack.push(
              'createRenderObject',
            ),
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

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
            key: Key('widget'),
            roEventRender: () {
              testStack.push('render-app-widget');
            },
            children: [
              RT_TestWidget(
                key: Key('app-child-0'),
                roEventRender: () {
                  testStack.push('render-0');
                },
                children: [
                  RT_TestWidget(
                    key: Key('app-child-0-0'),
                    roEventRender: () {
                      testStack.push('render-0-0');
                    },
                  ),
                  RT_TestWidget(
                    key: Key('app-child-0-1'),
                    roEventRender: () {
                      testStack.push('render-0-1');
                    },
                    children: [
                      RT_TestWidget(
                        key: Key('app-child-0-1-0'),
                        roEventRender: () {
                          testStack.push('render-0-1-0');
                        },
                      ),
                      RT_TestWidget(
                        key: Key('app-child-0-1-1'),
                        roEventRender: () {
                          testStack.push('render-0-1-1');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: Key('app-child-1'),
                roEventRender: () {
                  testStack.push('render-1');
                },
                children: [
                  // nested child widgets
                  RT_TestWidget(
                    key: Key('app-child-1-0'),
                    roEventRender: () {
                      testStack.push('render-1-0');
                    },
                  ),
                  RT_TestWidget(
                    key: Key('app-child-1-1'),
                    roEventRender: () {
                      testStack.push('render-1-1');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
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
          Text('this should persist'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      // try building, and provide no widgets to build

      await app!.buildChildren(
        widgets: [],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('this should persist'));
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
          // we always assume that there are no existing widgets in document while building
          // a app widget and therefore user can have only one root widget in entire app.
          //
          RT_TestWidget(
            key: Key('widget'),
            children: [
              //
              // these are child widgets and we expect all widgets below this point in tree
              // to get disposed off correctly by the framework when a app widget's immediate
              // child widgets are changed.
              //
              RT_TestWidget(
                key: Key('child-0'),
                children: [
                  RT_TestWidget(key: Key('child-0-0')),
                  RT_TestWidget(
                    key: Key('child-0-1'),
                    children: [
                      RT_TestWidget(key: Key('child-0-1-0')),
                      RT_TestWidget(key: Key('child-0-1-1')),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                key: Key('child-1'),
                children: [
                  // nested child widgets
                  RT_TestWidget(key: Key('child-1-0')),
                  RT_TestWidget(key: Key('child-1-1')),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      // ensure all are built

      expect(
        null == app!.renderElementByKeyValue('widget'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0-0'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0-1'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0-1-0'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-0-1-1'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-1'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-1-0'),
        equals(false),
      );
      expect(
        null == app!.renderElementByKeyValue('child-1-1'),
        equals(false),
      );

      // build new child widgets under app widget. we expect this operation to
      // dispose off existing child widgets of app widget.

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: Key('new-child'),
            roEventRender: () {
              // existing widgets should already got disposed by this point

              expect(
                null == app!.renderElementByKeyValue('child-0'),
                equals(true),
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
                null == app!.renderElementByKeyValue('child-0-1-0'),
                equals(true),
              );
              expect(
                null == app!.renderElementByKeyValue('child-0-1-1'),
                equals(true),
              );
              expect(
                null == app!.renderElementByKeyValue('child-1'),
                equals(true),
              );
              expect(
                null == app!.renderElementByKeyValue('child-1-0'),
                equals(true),
              );
              expect(
                null == app!.renderElementByKeyValue('child-1-1'),
                equals(true),
              );
            },
          ),
        ],
        parentRenderElement: app!.renderElementByKeyValue('widget')!,
      );

      // app widget should not have any impact

      expect(
        null == app!.renderElementByKeyValue('widget'),
        equals(false),
      );

      // newer child should be built

      expect(
        null == app!.renderElementByKeyValue('new-child'),
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
        parentRenderElement: app!.appRenderElement,
      );

      await app!.buildChildren(
        widgets: [Text('4')],
        parentRenderElement: app!.appRenderElement,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4'));
    });

    test('should continue to append new widgets when clean flag is off',
        () async {
      await app!.buildChildren(
        widgets: [Text('1')],
        parentRenderElement: app!.appRenderElement,
        flagCleanParentContents: true,
      );

      await app!.buildChildren(
        widgets: [
          Text('2'),
          Text('3'),
        ],
        parentRenderElement: app!.appRenderElement,
        flagCleanParentContents: false,
      );

      await app!.buildChildren(
        widgets: [Text('4')],
        parentRenderElement: app!.appRenderElement,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4'));
    });

    test('should mount at given index when clean flag is off', () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4'));
    });

    test('should mount at start', () async {
      await app!.buildChildren(
        widgets: [
          Text('0'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.buildChildren(
        widgets: [Text('insert at start')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 0,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('insert at start|0'));
    });

    test('should mount at end', () async {
      await app!.buildChildren(
        widgets: [
          Text('0'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.buildChildren(
        widgets: [Text('insert at end')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('0|insert at end'));
    });

    test('should mount at start if there are no existing widgets', () async {
      await app!.buildChildren(
        widgets: [],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents(''));

      await app!.buildChildren(
        widgets: [Text('insert at start')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 0,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('insert at start'));
    });

    test('should mount at start if no existing widgets and index is OOBs',
        () async {
      await app!.buildChildren(
        widgets: [],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents(''));

      await app!.buildChildren(
        widgets: [Text('insert at start')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 10,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('insert at start'));
    });

    test('should append if mount index is out of bounds', () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 5,
        flagCleanParentContents: false,
      );

      await app!.buildChildren(
        widgets: [Text('-1')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: -5,
        flagCleanParentContents: false,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('1|3|4|2|-1'));
    });

    test('should append if mount index is provided and clean flag is not set',
        () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 5,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('2'));
    });

    test('should clean & build if mount index is provided but clean flag is on',
        () async {
      await app!.buildChildren(
        widgets: [
          Text('1'),
          Text('3'),
          Text('4'),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.buildChildren(
        widgets: [Text('2')],
        parentRenderElement: app!.appRenderElement,
        mountAtIndex: 5,
        flagCleanParentContents: true,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('2'));
    });
  });
}
