// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
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
  | update children misc tests
  |--------------------------------------------------------------------------
  */

  group(
    'updateChildren() misc tests:',
    () {
      RT_AppRunner? app;

      setUp(() => app = createTestApp()..start());

      tearDown(() => app!.stop());

      test(
        'should never re create a render object',
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a'),
                roEventUpdate: () => testStack.push('update 1a'),
                roEventAfterUnMount: () => testStack.push('dispose 1a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 1a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 1a',
                ),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2a'),
                roEventUpdate: () => testStack.push('update 2a'),
                roEventAfterUnMount: () => testStack.push('dispose 2a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 2a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 2a',
                ),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 3a'),
                roEventUpdate: () => testStack.push('update 3a'),
                roEventAfterUnMount: () => testStack.push('dispose 3a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 3a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 3a',
                ),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 4a'),
                roEventUpdate: () => testStack.push('update 4a'),
                roEventAfterUnMount: () => testStack.push('dispose 4a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 4a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 4a',
                ),
                wOverrideShouldUpdateWidget: () => false,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('update 1a'));
          expect(testStack.popFromStart(), equals('is changed child 2a'));

          expect(testStack.popFromStart(), equals('is changed 3a'));
          expect(testStack.popFromStart(), equals('update 1a'));
          expect(testStack.popFromStart(), equals('is changed child 3a'));

          expect(testStack.popFromStart(), equals('is changed 4a'));
          expect(testStack.popFromStart(), equals('is changed child 4a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should  rebind a widget instance '
        'if widget configuration has changed',
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a'),
                roEventUpdate: () => testStack.push('update 1a'),
                roEventAfterUnMount: () => testStack.push('dispose 1a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 1a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 1a',
                ),
                roEventAfterWidgetRebind: () => testStack.push(
                  'rebind widget 1a',
                ),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2a'),
                roEventUpdate: () => testStack.push('update 2a'),
                roEventAfterUnMount: () => testStack.push('dispose 2a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 2a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 2a',
                ),
                roEventAfterWidgetRebind: () => testStack.push(
                  'rebind widget 2a',
                ),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('rebind widget 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('update 1a'));
          expect(testStack.popFromStart(), equals('is changed child 2a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should  rebind a widget instance (instance test) '
        'if widget configuration has changed',
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget'),
                customHash: 'original-instance',
                roEventRender: () => testStack.push('render 1a'),
                roEventUpdate: () => testStack.push('update 1a'),
                roEventAfterUnMount: () => testStack.push('dispose 1a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 1a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 1a',
                ),
                roEventAfterWidgetRebind: () {
                  testStack.push(
                    'rebind widget 1a',
                  );

                  var element = app!.renderElementByKeyValue('widget');

                  var hash = (element!.widget as RT_TestWidget).hash;

                  expect(hash, equals('new-instance'));
                },
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          var renderElement = app!.renderElementByKeyValue('widget');

          var hash = (renderElement!.widget as RT_TestWidget).hash;

          expect(hash, equals('original-instance'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget'),
                customHash: 'new-instance',
                roEventRender: () => testStack.push('render 2a'),
                roEventUpdate: () => testStack.push('update 2a'),
                roEventAfterUnMount: () => testStack.push('dispose 2a'),
                wEventShouldUpdateWidget: () => testStack.push(
                  'is changed 2a',
                ),
                wEventShouldUpdateWidgetChildren: () => testStack.push(
                  'is changed child 2a',
                ),
                roEventAfterWidgetRebind: () => testStack.push(
                  'rebind widget 2a',
                ),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('rebind widget 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('update 1a'));
          expect(testStack.popFromStart(), equals('is changed child 2a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test('should check child widgets if parent configuration is changed',
          () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(
              roEventRender: () => testStack.push('render parent'),
              roEventUpdate: () => testStack.push('update parent'),
              wOverrideShouldUpdateWidget: () => true,
              children: [
                RT_TestWidget(
                  roEventRender: () => testStack.push('render child'),
                  roEventUpdate: () => testStack.push('update child'),
                )
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              roEventRender: () => testStack.push('render parent'),
              roEventUpdate: () => testStack.push('update parent'),
              wOverrideShouldUpdateWidget: () => true,
              children: [
                RT_TestWidget(
                  roEventRender: () => testStack.push('render child'),
                  roEventUpdate: () => testStack.push('update child'),
                )
              ],
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        expect(testStack.popFromStart(), equals('render parent'));
        expect(testStack.popFromStart(), equals('render child'));
        expect(testStack.popFromStart(), equals('update parent'));
        expect(testStack.popFromStart(), equals('update child'));

        expect(testStack.canPop(), equals(false));
      });

      test(
        'should check child widgets even if parent configuration is not changed',
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render parent'),
                roEventUpdate: () => testStack.push('update parent'),
                wOverrideShouldUpdateWidget: () => false,
                children: [
                  RT_TestWidget(
                    roEventRender: () => testStack.push('render child'),
                    roEventUpdate: () => testStack.push('update child'),
                  )
                ],
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render parent'),
                roEventUpdate: () => testStack.push('update parent'),
                wOverrideShouldUpdateWidget: () => false,
                children: [
                  RT_TestWidget(
                    roEventRender: () => testStack.push('render child'),
                    roEventUpdate: () => testStack.push('update child'),
                  )
                ],
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect(testStack.popFromStart(), equals('render parent'));
          expect(testStack.popFromStart(), equals('render child'));
          expect(testStack.popFromStart(), equals('update child'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test('should skip child widgets on short-circuit', () async {
        var testStack = RT_TestStack();

        var constantWidget = RT_TestWidget(
          roEventRender: () => testStack.push('render parent'),
          roEventUpdate: () => testStack.push('update parent'),
          wOverrideShouldUpdateWidget: () => false,
          children: [
            RT_TestWidget(
              roEventRender: () => testStack.push('render child'),
              roEventUpdate: () => testStack.push('update child'),
            )
          ],
        );

        await app!.buildChildren(
          widgets: [constantWidget],
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [constantWidget],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        expect(testStack.popFromStart(), equals('render parent'));
        expect(testStack.popFromStart(), equals('render child'));

        expect(testStack.canPop(), equals(false));
      });

      test(
        'should add/dispose child widgets depending on updated children list',
        () async {
          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => false,
                children: [],
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents(''));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => false,
                children: [
                  Text('a'),
                  Text('b'),
                  Text('c'),
                ],
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('a|b|c'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => false,
                children: [],
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents(''));
        },
      );

      test(
        'should rebind widget instance if configuration has changed',
        () async {
          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                customHash: '1a',
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          var renderElement = app!.renderElementByKeyValue('widget');
          expect((renderElement!.widget as RT_TestWidget).hash, equals('1a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '2a',
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect((renderElement.widget as RT_TestWidget).hash, equals('2a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '3a',
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => true,
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect((renderElement.widget as RT_TestWidget).hash, equals('3a'));
        },
      );

      test(
        'should rebind widget instance even if configuration has not changed',
        () async {
          // Rebinding isn't required if both(old and new) instances of widget
          // are same, e.g in const constructors. But in all other cases
          // framework must update widget instance, even if widget's
          // configuration hasn't changed. This is because some properties of
          // widget are not part of widget's configuration such as
          // widgetChildren, widgetEventListeners. instead these properties are
          // checked at framework side. updating instance will ensure that
          // framework is dealing with at-least correct values.

          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                customHash: '1a',
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => false,
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          var renderElement = app!.renderElementByKeyValue('widget');
          expect((renderElement!.widget as RT_TestWidget).hash, equals('1a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '2a',
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => false,
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect((renderElement.widget as RT_TestWidget).hash, equals('2a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '3a',
                key: Key('widget'),
                wOverrideShouldUpdateWidget: () => false,
              ),
            ],
            updateType: UpdateType.setState,
            parentRenderElement: app!.appRenderElement,
          );

          expect((renderElement.widget as RT_TestWidget).hash, equals('3a'));
        },
      );

      // widgets matching tests

      test(
        'should dispose and match immediate if mismatched without keys',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b-1'),
                roEventUpdate: () => testStack.push('update 1b-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2a-2'),
                roEventUpdate: () => testStack.push('update 2a-2'),
                roEventAfterUnMount: () => testStack.push('dispose 2a-2'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2a-3'),
                roEventUpdate: () => testStack.push('update 2a-3'),
                roEventAfterUnMount: () => testStack.push('dispose 2a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('render 1b-1'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));

          expect(testStack.canPop(), equals(false));
        },
        skip: 'Now renderer sync lists from both ends(more effective)',
      );

      test(
        'should dispose correct mismatch in the start',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventDispose: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventDispose: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventDispose: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1b-1'),
                roEventUpdate: () => testStack.push('update 1b-1'),
                roEventDispose: () => testStack.push('dispose 1b-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 2a-2'),
                roEventUpdate: () => testStack.push('update 2a-2'),
                roEventDispose: () => testStack.push('dispose 2a-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 2a-3'),
                roEventUpdate: () => testStack.push('update 2a-3'),
                roEventDispose: () => testStack.push('dispose 2a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose correct mismatch in the middle',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventDispose: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventDispose: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventDispose: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 2a-1'),
                roEventUpdate: () => testStack.push('update 2a-1'),
                roEventDispose: () => testStack.push('dispose 2a-1'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1b-2'),
                roEventUpdate: () => testStack.push('update 1b-2'),
                roEventDispose: () => testStack.push('dispose 1b-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 2a-3'),
                roEventUpdate: () => testStack.push('update 2a-3'),
                roEventDispose: () => testStack.push('dispose 2a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-2'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose correct mismatch in the end',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventDispose: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventDispose: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventDispose: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 2a-1'),
                roEventUpdate: () => testStack.push('update 2a-1'),
                roEventDispose: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 2a-2'),
                roEventUpdate: () => testStack.push('update 2a-2'),
                roEventDispose: () => testStack.push('dispose 2a-2'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1b-3'),
                roEventUpdate: () => testStack.push('update 1b-3'),
                roEventDispose: () => testStack.push('dispose 1b-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose mismatch and append new child widgets in the end',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventDispose: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventDispose: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventDispose: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 2a-1'),
                roEventUpdate: () => testStack.push('update 2a-1'),
                roEventDispose: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 2a-2'),
                roEventUpdate: () => testStack.push('update 2a-2'),
                roEventDispose: () => testStack.push('dispose 2a-2'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1b-3'),
                roEventUpdate: () => testStack.push('update 1b-3'),
                roEventDispose: () => testStack.push('dispose 1b-3'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-4'),
                roEventRender: () => testStack.push('render 1b-4'),
                roEventUpdate: () => testStack.push('update 1b-4'),
                roEventDispose: () => testStack.push('dispose 1b-4'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));
          expect(testStack.popFromStart(), equals('render 1b-4'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should be able to run update on tree containing non-direct child widgets '
        'direct child widgets are the child widgets that widget provides in widget constructor '
        'non-direct child widgets are the child widgets that are rendered by the state of widget it-self',
        () async {
          var pap = app!;

          await pap.updateChildren(
            widgets: [
              Navigator(
                routes: [
                  Route(
                    key: Key('route'),
                    name: 'some-name',
                    page: Text(''),
                  ),
                ],
              ),
            ],
            parentRenderElement: pap.appRenderElement,
            updateType: UpdateType.setState,
          );

          await pap.updateChildren(
            widgets: [
              Navigator(
                routes: [
                  Route(
                    key: Key('route'),
                    name: 'some-name',
                    page: Text(''),
                  ),
                ],
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.setState,
          );

          var route = pap.widgetByKey('route');

          expect((route as Route).name, equals('some-name'));
        },
      );

      test(
        'should be able to run update on tree containing non-direct child widgets '
        'stateful widget test',
        () async {
          var pap = app!;

          await pap.updateChildren(
            widgets: [
              RT_SingleChildStateful(
                child: Text('some text'),
              ),
            ],
            parentRenderElement: pap.appRenderElement,
            updateType: UpdateType.setState,
          );

          await pap.updateChildren(
            widgets: [
              RT_SingleChildStateful(
                child: Text('ignore text'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.setState,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('some text'));
        },
      );

      test(
        'should be able to run update on tree containing non-direct child widgets '
        'stateless widget test',
        () async {
          var pap = app!;

          await pap.updateChildren(
            widgets: [
              RT_StatelessWidget(
                children: [
                  Text('some text'),
                ],
              ),
            ],
            parentRenderElement: pap.appRenderElement,
            updateType: UpdateType.setState,
          );

          await pap.updateChildren(
            widgets: [
              RT_StatelessWidget(
                children: [
                  Text('updated text'),
                ],
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.setState,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('updated text'));
        },
      );

      test(
        'should be able to run update on tree containing direct child widgets '
        'inherited widget test',
        () async {
          var pap = app!;

          await pap.updateChildren(
            widgets: [
              RT_InheritedWidget(
                child: Text('some text'),
              ),
            ],
            parentRenderElement: pap.appRenderElement,
            updateType: UpdateType.setState,
          );

          await pap.updateChildren(
            widgets: [
              RT_InheritedWidget(
                child: Text('updated text'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.setState,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('updated text'));
        },
      );

      test(
        'should be able to run update on tree containing non-direct child widgets '
        'event detector widget test',
        () async {
          var pap = app!;

          await pap.updateChildren(
            widgets: [
              EventDetector(
                child: Text('some text'),
              ),
            ],
            parentRenderElement: pap.appRenderElement,
            updateType: UpdateType.setState,
          );

          await pap.updateChildren(
            widgets: [
              EventDetector(
                child: Text('updated text'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.setState,
          );

          expect(RT_TestBed.rootDomNode, RT_hasContents('updated text'));
        },
      );

      test(
        'should call shouldUpdateWidgetChild with previous result of shouldUpdate',
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                wOverrideShouldUpdateWidget: () => true,
                wHookShouldUpdateWidgetChildren: (
                  widget,
                  results,
                ) =>
                    testStack.push(results ? 'y' : 'n'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                wOverrideShouldUpdateWidget: () => true,
                wHookShouldUpdateWidgetChildren: (
                  widget,
                  results,
                ) =>
                    testStack.push(results ? 'y' : 'n'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                wOverrideShouldUpdateWidget: () => false,
                wHookShouldUpdateWidgetChildren: (
                  widget,
                  results,
                ) =>
                    testStack.push(results ? 'y' : 'n'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('y'));
          expect(testStack.popFromStart(), equals('n'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should skip mismatch and reuse existing widget(prevent loosing state '
        'when child widgets are added optionally)',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 2a-1'),
                roEventUpdate: () => testStack.push('update 2a-1'),
                roEventAfterUnMount: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 2a-2'),
                roEventUpdate: () => testStack.push('update 2a-2'),
                roEventAfterUnMount: () => testStack.push('dispose 2a-2'),
              ),
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b-3'),
                roEventUpdate: () => testStack.push('update 1b-3'),
                roEventAfterUnMount: () => testStack.push('dispose 1b-3'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 2a-4'),
                roEventUpdate: () => testStack.push('update 2a-4'),
                roEventAfterUnMount: () => testStack.push('dispose 2a-4'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );
          // render 1a-1, render 1a-2, render 1a-3,

          // dispose 1a-3,

          // update 1a-1, update 1a-2, render 1b-3, render 2a-3

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));
          expect(testStack.popFromStart(), equals('update 1a-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose correct mis matches, mixed hardcoded version',
        () async {
          var testStack = RT_TestStack();

          // render child widgets
          // ----------------expected
          // render 1a-1, render 1a-2, render 1a-3, render 1a-4

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventDispose: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventDispose: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventDispose: () => testStack.push('dispose 1a-3'),
              ),
              RT_TestWidget(
                key: Key('widget-4'),
                roEventRender: () => testStack.push('render 1a-4'),
                roEventUpdate: () => testStack.push('update 1a-4'),
                roEventDispose: () => testStack.push('dispose 1a-4'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          // change 2nd child
          // ----------------expected
          // dispose 1a-2
          // update 1a-1, render 1b-2, update 1a-3, update 1a-4
          //

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 2a-1'),
                roEventUpdate: () => testStack.push('update 2a-1'),
                roEventDispose: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 1b-2'),
                roEventUpdate: () => testStack.push('update 1b-2'),
                roEventDispose: () => testStack.push('dispose 1b-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 2a-3'),
                roEventUpdate: () => testStack.push('update 2a-3'),
                roEventDispose: () => testStack.push('dispose 2a-3'),
              ),
              RT_TestWidget(
                key: Key('widget-4'),
                roEventRender: () => testStack.push('render 2a-4'),
                roEventUpdate: () => testStack.push('update 2a-4'),
                roEventDispose: () => testStack.push('dispose 2a-4'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          // change 1st child
          // ----------------expected
          // dispose 1a-1
          // render 1b-1, update 1b-2, update 1a-3, update 1a-4
          //

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 1b-1'),
                roEventUpdate: () => testStack.push('update 1b-1'),
                roEventDispose: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 2b-2'),
                roEventUpdate: () => testStack.push('update 2b-2'),
                roEventDispose: () => testStack.push('dispose 2b-2'),
              ),
              RT_TestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 3a-3'),
                roEventUpdate: () => testStack.push('update 3a-3'),
                roEventDispose: () => testStack.push('dispose 3a-3'),
              ),
              RT_TestWidget(
                key: Key('widget-4'),
                roEventRender: () => testStack.push('render 3a-4'),
                roEventUpdate: () => testStack.push('update 3a-4'),
                roEventDispose: () => testStack.push('dispose 3a-4'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          // change last two child widgets
          // ----------------expected
          // dispose 1a-3, dispose 1a-4
          // update 1b-1, update 1b-2, render 1b-3, render 1b-4

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('widget-1'),
                roEventRender: () => testStack.push('render 2b-1'),
                roEventUpdate: () => testStack.push('update 2b-1'),
                roEventDispose: () => testStack.push('dispose 2b-1'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-2'),
                roEventRender: () => testStack.push('render 2b-2'),
                roEventUpdate: () => testStack.push('update 2b-2'),
                roEventDispose: () => testStack.push('dispose 2b-2'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-3'),
                roEventRender: () => testStack.push('render 1b-3'),
                roEventUpdate: () => testStack.push('update 1b-3'),
                roEventDispose: () => testStack.push('dispose 1b-3'),
              ),
              RT_AnotherTestWidget(
                key: Key('widget-4'),
                roEventRender: () => testStack.push('render 1b-4'),
                roEventUpdate: () => testStack.push('update 1b-4'),
                roEventDispose: () => testStack.push('dispose 1b-4'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));
          expect(testStack.popFromStart(), equals('render 1a-4'));

          expect(testStack.popFromStart(), equals('dispose 1a-2'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-4'));

          expect(testStack.popFromStart(), equals('dispose 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-1'));
          expect(testStack.popFromStart(), equals('update 1b-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-4'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('dispose 1a-4'));
          expect(testStack.popFromStart(), equals('update 1b-1'));
          expect(testStack.popFromStart(), equals('update 1b-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));
          expect(testStack.popFromStart(), equals('render 1b-4'));

          expect(testStack.canPop(), equals(false));
        },
      );

      //
    },
  );
}
