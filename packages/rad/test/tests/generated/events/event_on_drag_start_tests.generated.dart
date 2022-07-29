// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drag_start_test() {
  group('Event onDragStart (native: dragstart) tests:', () {
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
            onDragStart: (_) => pap.stack.push('dragstart-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('dragstart'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragstart-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onDragStartCapture: (_) => pap.stack.push('dragstart-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('dragstart'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragstart-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDragStart: (_) => pap.stack.push('dragstart-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragStart: (_) => pap.stack.push('dragstart-parent'),
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

      gparent.dispatchEvent(Event('dragstart')); // first
      parent.dispatchEvent(Event('dragstart')); // second
      child.dispatchEvent(Event('dragstart')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

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
              onDragStart: (_) => pap.stack.push('dragstart-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDragStart: (event) {
                    pap.stack.push('dragstart-parent');

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

        child.dispatchEvent(Event('dragstart')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragstart-parent'));
        expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

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
              onDragStart: (_) => pap.stack.push('dragstart-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDragStart: (event) {
                    pap.stack.push('dragstart-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDragStart: (event) {
                        pap.stack.push('dragstart-child');

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

        child.dispatchEvent(Event('dragstart'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragstart-child'));
        expect(pap.stack.popFromStart(), equals('dragstart-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'dragstart' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for dragstart events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDragStart: (event) {
              pap.stack.push('dragstart-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragStartCapture: (event) {
                  pap.stack.push('dragstart-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDragStart: (event) {
                      pap.stack.push('dragstart-child');

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

      gparent.dispatchEvent(Event('dragstart')); // first
      parent.dispatchEvent(Event('dragstart')); // second
      child.dispatchEvent(Event('dragstart')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDragStartCapture: (event) {
              pap.stack.push('dragstart-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDragStartCapture: (event) {
                  pap.stack.push('dragstart-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDragStart: (event) {
                      pap.stack.push('dragstart-child');

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

      gparent.dispatchEvent(Event('dragstart')); // first
      parent.dispatchEvent(Event('dragstart')); // second
      child.dispatchEvent(Event('dragstart')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
