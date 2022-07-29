// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_click_test() {
  group('Event onClick (native: click) tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should dispatch event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onClick: (_) => pap.stack.push('click-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('click'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('click-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onClickCapture: (_) => pap.stack.push('click-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('click'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('click-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onClick: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onClick: (_) => pap.stack.push('click-parent'),
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gParent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gParent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));
      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-child'));
      expect(pap.stack.popFromStart(), equals('click-parent'));
      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should stop propagation after stopPropagation() is called', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onClick: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onClick: (event) {
                  event.stopPropagation();

                  pap.stack.push('click-parent');
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
                  ),
                ],
              ),
            ],
          )
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gParent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gParent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-child'));
      expect(pap.stack.popFromStart(), equals('click-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should stop after stopImmediatePropagation() is called', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onClick: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onClick: (event) {
                  event.stopImmediatePropagation();

                  pap.stack.push('click-parent');
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
                  ),
                ],
              ),
            ],
          )
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gParent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gParent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-child'));
      expect(pap.stack.popFromStart(), equals('click-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onClick: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onClickCapture: (event) {
                  pap.stack.push('click-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gParent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gParent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onClickCapture: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onClickCapture: (event) {
                  pap.stack.push('click-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gParent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gParent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));
      expect(pap.stack.popFromStart(), equals('click-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));
      expect(pap.stack.popFromStart(), equals('click-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
