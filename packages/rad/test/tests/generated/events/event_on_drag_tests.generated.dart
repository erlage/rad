// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drag_test() {
  group('Event onDrag (native: drag) tests:', () {
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
            onDrag: (_) => pap.stack.push('drag-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('drag'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('drag-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onDragCapture: (_) => pap.stack.push('drag-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('drag'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('drag-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDrag: (_) => pap.stack.push('drag-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDrag: (_) => pap.stack.push('drag-parent'),
                children: [
                  RT_EventfulWidget(key: Key('el-child')),
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

      gparent.dispatchEvent(Event('drag')); // first
      parent.dispatchEvent(Event('drag')); // second
      child.dispatchEvent(Event('drag')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('drag-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('drag-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('drag-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: Key('el-g-parent'),
              onDrag: (_) => pap.stack.push('drag-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDrag: (event) {
                    pap.stack.push('drag-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: Key('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var child = pap.domNodeByKeyValue('el-child');

        child.dispatchEvent(Event('drag')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('drag-parent'));
        expect(pap.stack.popFromStart(), equals('drag-g-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

    test(
      'should stop propagation if stopped after restartPropagationIfStopped',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: Key('el-g-parent'),
              onDrag: (_) => pap.stack.push('drag-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDrag: (event) {
                    pap.stack.push('drag-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDrag: (event) {
                        pap.stack.push('drag-child');

                        event.restartPropagationIfStopped();
                      },
                      key: Key('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var child = pap.domNodeByKeyValue('el-child');

        child.dispatchEvent(Event('drag'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('drag-child'));
        expect(pap.stack.popFromStart(), equals('drag-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'drag' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for drag events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDrag: (event) {
              pap.stack.push('drag-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragCapture: (event) {
                  pap.stack.push('drag-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDrag: (event) {
                      pap.stack.push('drag-child');

                      event.restartPropagationIfStopped();
                    },
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

      gparent.dispatchEvent(Event('drag')); // first
      parent.dispatchEvent(Event('drag')); // second
      child.dispatchEvent(Event('drag')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('drag-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('drag-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('drag-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDragCapture: (event) {
              pap.stack.push('drag-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragCapture: (event) {
                  pap.stack.push('drag-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDrag: (event) {
                      pap.stack.push('drag-child');

                      event.restartPropagationIfStopped();
                    },
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

      gparent.dispatchEvent(Event('drag')); // first
      parent.dispatchEvent(Event('drag')); // second
      child.dispatchEvent(Event('drag')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('drag-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('drag-g-parent'));
      expect(pap.stack.popFromStart(), equals('drag-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('drag-g-parent'));
      expect(pap.stack.popFromStart(), equals('drag-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
