// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_mouse_up_test() {
  group('Event onMouseUp (native: mouseup) tests:', () {
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
            onMouseUp: (_) => pap.stack.push('mouseup-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mouseup'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseup-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onMouseUpCapture: (_) => pap.stack.push('mouseup-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mouseup'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseup-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseUp: (_) => pap.stack.push('mouseup-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseUp: (_) => pap.stack.push('mouseup-parent'),
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

      gParent.dispatchEvent(Event('mouseup')); // first
      parent.dispatchEvent(Event('mouseup')); // second
      child.dispatchEvent(Event('mouseup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

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
              onMouseUp: (_) => pap.stack.push('mouseup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseUp: (event) {
                    pap.stack.push('mouseup-parent');

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

        child.dispatchEvent(Event('mouseup')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseup-parent'));
        expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

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
              onMouseUp: (_) => pap.stack.push('mouseup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseUp: (event) {
                    pap.stack.push('mouseup-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onMouseUp: (event) {
                        pap.stack.push('mouseup-child');

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

        child.dispatchEvent(Event('mouseup'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseup-child'));
        expect(pap.stack.popFromStart(), equals('mouseup-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'mouseup' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for mouseup events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseUp: (event) {
              pap.stack.push('mouseup-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseUpCapture: (event) {
                  pap.stack.push('mouseup-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseUp: (event) {
                      pap.stack.push('mouseup-child');

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

      gParent.dispatchEvent(Event('mouseup')); // first
      parent.dispatchEvent(Event('mouseup')); // second
      child.dispatchEvent(Event('mouseup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseUpCapture: (event) {
              pap.stack.push('mouseup-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseUpCapture: (event) {
                  pap.stack.push('mouseup-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseUp: (event) {
                      pap.stack.push('mouseup-child');

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

      gParent.dispatchEvent(Event('mouseup')); // first
      parent.dispatchEvent(Event('mouseup')); // second
      child.dispatchEvent(Event('mouseup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
