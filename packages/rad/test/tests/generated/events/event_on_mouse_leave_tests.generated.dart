// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_mouse_leave_test() {
  group('Event onMouseLeave (native: mouseleave) tests:', () {
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
            key: GlobalKey('domNode'),
            onMouseLeave: (_) => pap.stack.push('mouseleave-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('mouseleave'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseleave-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('domNode'),
            onMouseLeaveCapture: (_) => pap.stack.push('mouseleave-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('mouseleave'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseleave-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseLeave: (_) => pap.stack.push('mouseleave-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseLeave: (_) => pap.stack.push('mouseleave-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var gparent = pap.domNodeByGlobalKey('el-g-parent');
      var parent = pap.domNodeByGlobalKey('el-parent');
      var child = pap.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('mouseleave')); // first
      parent.dispatchEvent(Event('mouseleave')); // second
      child.dispatchEvent(Event('mouseleave')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test(
      'should restart propagation if called restartPropagationIfStopped',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_EventfulWidget(
              key: GlobalKey('el-g-parent'),
              onMouseLeave: (_) => pap.stack.push('mouseleave-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onMouseLeave: (event) {
                    pap.stack.push('mouseleave-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var child = pap.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('mouseleave')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseleave-parent'));
        expect(pap.stack.popFromStart(), equals('mouseleave-g-parent'));

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
              key: GlobalKey('el-g-parent'),
              onMouseLeave: (_) => pap.stack.push('mouseleave-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onMouseLeave: (event) {
                    pap.stack.push('mouseleave-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onMouseLeave: (event) {
                        pap.stack.push('mouseleave-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var child = pap.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('mouseleave'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseleave-child'));
        expect(pap.stack.popFromStart(), equals('mouseleave-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'mouseleave' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for mouseleave events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseLeave: (event) {
              pap.stack.push('mouseleave-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseLeaveCapture: (event) {
                  pap.stack.push('mouseleave-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onMouseLeave: (event) {
                      pap.stack.push('mouseleave-child');

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

      var gparent = pap.domNodeByGlobalKey('el-g-parent');
      var parent = pap.domNodeByGlobalKey('el-parent');
      var child = pap.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('mouseleave')); // first
      parent.dispatchEvent(Event('mouseleave')); // second
      child.dispatchEvent(Event('mouseleave')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseLeaveCapture: (event) {
              pap.stack.push('mouseleave-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseLeaveCapture: (event) {
                  pap.stack.push('mouseleave-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onMouseLeave: (event) {
                      pap.stack.push('mouseleave-child');

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

      var gparent = pap.domNodeByGlobalKey('el-g-parent');
      var parent = pap.domNodeByGlobalKey('el-parent');
      var child = pap.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('mouseleave')); // first
      parent.dispatchEvent(Event('mouseleave')); // second
      child.dispatchEvent(Event('mouseleave')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseleave-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseleave-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseleave-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
