// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_mouse_enter_test() {
  group('Event onMouseEnter (native: mouseenter) tests:', () {
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
            onMouseEnter: (_) => pap.stack.push('mouseenter-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mouseenter'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseenter-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onMouseEnterCapture: (_) => pap.stack.push('mouseenter-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mouseenter'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseenter-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseEnter: (_) => pap.stack.push('mouseenter-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseEnter: (_) => pap.stack.push('mouseenter-parent'),
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

      gParent.dispatchEvent(Event('mouseenter')); // first
      parent.dispatchEvent(Event('mouseenter')); // second
      child.dispatchEvent(Event('mouseenter')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-parent'));

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
              onMouseEnter: (_) => pap.stack.push('mouseenter-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseEnter: (event) {
                    pap.stack.push('mouseenter-parent');

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

        child.dispatchEvent(Event('mouseenter')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseenter-parent'));
        expect(pap.stack.popFromStart(), equals('mouseenter-g-parent'));

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
              onMouseEnter: (_) => pap.stack.push('mouseenter-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseEnter: (event) {
                    pap.stack.push('mouseenter-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onMouseEnter: (event) {
                        pap.stack.push('mouseenter-child');

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

        child.dispatchEvent(Event('mouseenter'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseenter-child'));
        expect(pap.stack.popFromStart(), equals('mouseenter-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'mouseenter' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for mouseenter events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseEnter: (event) {
              pap.stack.push('mouseenter-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseEnterCapture: (event) {
                  pap.stack.push('mouseenter-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseEnter: (event) {
                      pap.stack.push('mouseenter-child');

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

      gParent.dispatchEvent(Event('mouseenter')); // first
      parent.dispatchEvent(Event('mouseenter')); // second
      child.dispatchEvent(Event('mouseenter')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseEnterCapture: (event) {
              pap.stack.push('mouseenter-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseEnterCapture: (event) {
                  pap.stack.push('mouseenter-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseEnter: (event) {
                      pap.stack.push('mouseenter-child');

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

      gParent.dispatchEvent(Event('mouseenter')); // first
      parent.dispatchEvent(Event('mouseenter')); // second
      child.dispatchEvent(Event('mouseenter')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseenter-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseenter-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseenter-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
