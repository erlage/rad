// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_key_press_test() {
  group('Event onKeyPress (native: keypress) tests:', () {
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
            onKeyPress: (_) => pap.stack.push('keypress-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('keypress'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('keypress-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('domNode'),
            onKeyPressCapture: (_) => pap.stack.push('keypress-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('keypress'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('keypress-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyPress: (_) => pap.stack.push('keypress-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyPress: (_) => pap.stack.push('keypress-parent'),
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

      gparent.dispatchEvent(Event('keypress')); // first
      parent.dispatchEvent(Event('keypress')); // second
      child.dispatchEvent(Event('keypress')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keypress-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-parent'));

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
              onKeyPress: (_) => pap.stack.push('keypress-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyPress: (event) {
                    pap.stack.push('keypress-parent');

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

        child.dispatchEvent(Event('keypress')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('keypress-parent'));
        expect(pap.stack.popFromStart(), equals('keypress-g-parent'));

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
              onKeyPress: (_) => pap.stack.push('keypress-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyPress: (event) {
                    pap.stack.push('keypress-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onKeyPress: (event) {
                        pap.stack.push('keypress-child');

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

        child.dispatchEvent(Event('keypress'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('keypress-child'));
        expect(pap.stack.popFromStart(), equals('keypress-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'keypress' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for keypress events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyPress: (event) {
              pap.stack.push('keypress-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyPressCapture: (event) {
                  pap.stack.push('keypress-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onKeyPress: (event) {
                      pap.stack.push('keypress-child');

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

      gparent.dispatchEvent(Event('keypress')); // first
      parent.dispatchEvent(Event('keypress')); // second
      child.dispatchEvent(Event('keypress')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keypress-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyPressCapture: (event) {
              pap.stack.push('keypress-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyPressCapture: (event) {
                  pap.stack.push('keypress-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onKeyPress: (event) {
                      pap.stack.push('keypress-child');

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

      gparent.dispatchEvent(Event('keypress')); // first
      parent.dispatchEvent(Event('keypress')); // second
      child.dispatchEvent(Event('keypress')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keypress-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-g-parent'));
      expect(pap.stack.popFromStart(), equals('keypress-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-g-parent'));
      expect(pap.stack.popFromStart(), equals('keypress-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
