// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drag_end_test() {
  group('Event onDragEnd (native: dragend) tests:', () {
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
            onDragEnd: (_) => pap.stack.push('dragend-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('dragend'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragend-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onDragEndCapture: (_) => pap.stack.push('dragend-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('dragend'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragend-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDragEnd: (_) => pap.stack.push('dragend-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragEnd: (_) => pap.stack.push('dragend-parent'),
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

      gParent.dispatchEvent(Event('dragend')); // first
      parent.dispatchEvent(Event('dragend')); // second
      child.dispatchEvent(Event('dragend')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

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
              onDragEnd: (_) => pap.stack.push('dragend-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDragEnd: (event) {
                    pap.stack.push('dragend-parent');

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

        child.dispatchEvent(Event('dragend')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragend-parent'));
        expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

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
              onDragEnd: (_) => pap.stack.push('dragend-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDragEnd: (event) {
                    pap.stack.push('dragend-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDragEnd: (event) {
                        pap.stack.push('dragend-child');

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

        child.dispatchEvent(Event('dragend'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragend-child'));
        expect(pap.stack.popFromStart(), equals('dragend-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'dragend' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for dragend events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDragEnd: (event) {
              pap.stack.push('dragend-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragEndCapture: (event) {
                  pap.stack.push('dragend-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDragEnd: (event) {
                      pap.stack.push('dragend-child');

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

      gParent.dispatchEvent(Event('dragend')); // first
      parent.dispatchEvent(Event('dragend')); // second
      child.dispatchEvent(Event('dragend')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDragEndCapture: (event) {
              pap.stack.push('dragend-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragEndCapture: (event) {
                  pap.stack.push('dragend-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDragEnd: (event) {
                      pap.stack.push('dragend-child');

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

      gParent.dispatchEvent(Event('dragend')); // first
      parent.dispatchEvent(Event('dragend')); // second
      child.dispatchEvent(Event('dragend')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
