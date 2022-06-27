// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_key_up_test() {
  group('Event onKeyUp (native: keyup) tests:', () {
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
            onKeyUp: (_) => pap.stack.push('keyup-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('keyup'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('keyup-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('domNode'),
            onKeyUpCapture: (_) => pap.stack.push('keyup-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('keyup'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('keyup-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyUp: (_) => pap.stack.push('keyup-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyUp: (_) => pap.stack.push('keyup-parent'),
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

      gparent.dispatchEvent(Event('keyup')); // first
      parent.dispatchEvent(Event('keyup')); // second
      child.dispatchEvent(Event('keyup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keyup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keyup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keyup-parent'));

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
              onKeyUp: (_) => pap.stack.push('keyup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyUp: (event) {
                    pap.stack.push('keyup-parent');

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

        child.dispatchEvent(Event('keyup')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('keyup-parent'));
        expect(pap.stack.popFromStart(), equals('keyup-g-parent'));

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
              onKeyUp: (_) => pap.stack.push('keyup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyUp: (event) {
                    pap.stack.push('keyup-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onKeyUp: (event) {
                        pap.stack.push('keyup-child');

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

        child.dispatchEvent(Event('keyup'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('keyup-child'));
        expect(pap.stack.popFromStart(), equals('keyup-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'keyup' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for keyup events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyUp: (event) {
              pap.stack.push('keyup-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyUpCapture: (event) {
                  pap.stack.push('keyup-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onKeyUp: (event) {
                      pap.stack.push('keyup-child');

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

      gparent.dispatchEvent(Event('keyup')); // first
      parent.dispatchEvent(Event('keyup')); // second
      child.dispatchEvent(Event('keyup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keyup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keyup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keyup-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyUpCapture: (event) {
              pap.stack.push('keyup-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyUpCapture: (event) {
                  pap.stack.push('keyup-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onKeyUp: (event) {
                      pap.stack.push('keyup-child');

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

      gparent.dispatchEvent(Event('keyup')); // first
      parent.dispatchEvent(Event('keyup')); // second
      child.dispatchEvent(Event('keyup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keyup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keyup-g-parent'));
      expect(pap.stack.popFromStart(), equals('keyup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keyup-g-parent'));
      expect(pap.stack.popFromStart(), equals('keyup-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
