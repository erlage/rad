// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_double_click_test() {
  group('Event onDoubleClick (native: dblclick) tests:', () {
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
            onDoubleClick: (_) => pap.stack.push('dblclick-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dblclick-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onDoubleClickCapture: (_) => pap.stack.push('dblclick-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('dblclick'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dblclick-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDoubleClick: (_) => pap.stack.push('dblclick-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDoubleClick: (_) => pap.stack.push('dblclick-parent'),
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDoubleClick: (_) => pap.stack.push('dblclick-child'),
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gparent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gparent.dispatchEvent(Event('dblclick')); // first
      parent.dispatchEvent(Event('dblclick')); // second
      child.dispatchEvent(Event('dblclick')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-parent'));
      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-child'));
      expect(pap.stack.popFromStart(), equals('dblclick-parent'));
      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should stop propagation after stopPropagation() is called', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDoubleClick: (_) => pap.stack.push('dblclick-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDoubleClick: (event) {
                  event.stopPropagation();

                  pap.stack.push('dblclick-parent');
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDoubleClick: (_) => pap.stack.push('dblclick-child'),
                  ),
                ],
              ),
            ],
          )
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gparent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gparent.dispatchEvent(Event('dblclick')); // first
      parent.dispatchEvent(Event('dblclick')); // second
      child.dispatchEvent(Event('dblclick')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-child'));
      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should stop after stopImmediatePropagation() is called', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDoubleClick: (_) => pap.stack.push('dblclick-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDoubleClick: (event) {
                  event.stopImmediatePropagation();

                  pap.stack.push('dblclick-parent');
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDoubleClick: (_) => pap.stack.push('dblclick-child'),
                  ),
                ],
              ),
            ],
          )
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gparent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gparent.dispatchEvent(Event('dblclick')); // first
      parent.dispatchEvent(Event('dblclick')); // second
      child.dispatchEvent(Event('dblclick')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-child'));
      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDoubleClick: (_) => pap.stack.push('dblclick-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDoubleClickCapture: (event) {
                  pap.stack.push('dblclick-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDoubleClick: (_) => pap.stack.push('dblclick-child'),
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gparent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gparent.dispatchEvent(Event('dblclick')); // first
      parent.dispatchEvent(Event('dblclick')); // second
      child.dispatchEvent(Event('dblclick')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDoubleClickCapture: (_) => pap.stack.push('dblclick-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDoubleClickCapture: (event) {
                  pap.stack.push('dblclick-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDoubleClick: (_) => pap.stack.push('dblclick-child'),
                  ),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gparent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gparent.dispatchEvent(Event('dblclick')); // first
      parent.dispatchEvent(Event('dblclick')); // second
      child.dispatchEvent(Event('dblclick')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));
      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dblclick-g-parent'));
      expect(pap.stack.popFromStart(), equals('dblclick-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
