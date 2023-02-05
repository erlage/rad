// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_mouse_move_test() {
  group('Event onMouseMove (native: mousemove) tests:', () {
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
            onMouseMove: (_) => pap.stack.push('mousemove-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mousemove'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mousemove-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onMouseMoveCapture: (_) => pap.stack.push('mousemove-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mousemove'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mousemove-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseMove: (_) => pap.stack.push('mousemove-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseMove: (_) => pap.stack.push('mousemove-parent'),
                children: [
                  RT_EventfulWidget(key: Key('el-child')),
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

      gParent.dispatchEvent(Event('mousemove')); // first
      parent.dispatchEvent(Event('mousemove')); // second
      child.dispatchEvent(Event('mousemove')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

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
              onMouseMove: (_) => pap.stack.push('mousemove-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseMove: (event) {
                    pap.stack.push('mousemove-parent');

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

        child.dispatchEvent(Event('mousemove')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mousemove-parent'));
        expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

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
              onMouseMove: (_) => pap.stack.push('mousemove-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseMove: (event) {
                    pap.stack.push('mousemove-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onMouseMove: (event) {
                        pap.stack.push('mousemove-child');

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

        child.dispatchEvent(Event('mousemove'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mousemove-child'));
        expect(pap.stack.popFromStart(), equals('mousemove-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'mousemove' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for mousemove events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseMove: (event) {
              pap.stack.push('mousemove-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseMoveCapture: (event) {
                  pap.stack.push('mousemove-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseMove: (event) {
                      pap.stack.push('mousemove-child');

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

      var gParent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gParent.dispatchEvent(Event('mousemove')); // first
      parent.dispatchEvent(Event('mousemove')); // second
      child.dispatchEvent(Event('mousemove')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseMoveCapture: (event) {
              pap.stack.push('mousemove-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseMoveCapture: (event) {
                  pap.stack.push('mousemove-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseMove: (event) {
                      pap.stack.push('mousemove-child');

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

      var gParent = pap.domNodeByKeyValue('el-g-parent');
      var parent = pap.domNodeByKeyValue('el-parent');
      var child = pap.domNodeByKeyValue('el-child');

      gParent.dispatchEvent(Event('mousemove')); // first
      parent.dispatchEvent(Event('mousemove')); // second
      child.dispatchEvent(Event('mousemove')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));
      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));
      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
