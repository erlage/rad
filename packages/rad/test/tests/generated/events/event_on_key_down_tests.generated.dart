// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_key_down_test() {
  group('Event onKeyDown (native: keydown) tests:', () {
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
            onKeyDown: (_) => pap.stack.push('keydown-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('keydown'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('keydown-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('domNode'),
            onKeyDownCapture: (_) => pap.stack.push('keydown-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('keydown'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('keydown-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyDown: (_) => pap.stack.push('keydown-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyDown: (_) => pap.stack.push('keydown-parent'),
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

      gparent.dispatchEvent(Event('keydown')); // first
      parent.dispatchEvent(Event('keydown')); // second
      child.dispatchEvent(Event('keydown')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keydown-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keydown-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keydown-parent'));

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
              onKeyDown: (_) => pap.stack.push('keydown-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyDown: (event) {
                    pap.stack.push('keydown-parent');

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

        child.dispatchEvent(Event('keydown')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('keydown-parent'));
        expect(pap.stack.popFromStart(), equals('keydown-g-parent'));

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
              onKeyDown: (_) => pap.stack.push('keydown-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyDown: (event) {
                    pap.stack.push('keydown-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onKeyDown: (event) {
                        pap.stack.push('keydown-child');

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

        child.dispatchEvent(Event('keydown'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('keydown-child'));
        expect(pap.stack.popFromStart(), equals('keydown-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'keydown' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for keydown events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyDown: (event) {
              pap.stack.push('keydown-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyDownCapture: (event) {
                  pap.stack.push('keydown-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onKeyDown: (event) {
                      pap.stack.push('keydown-child');

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

      gparent.dispatchEvent(Event('keydown')); // first
      parent.dispatchEvent(Event('keydown')); // second
      child.dispatchEvent(Event('keydown')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keydown-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keydown-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keydown-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyDownCapture: (event) {
              pap.stack.push('keydown-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyDownCapture: (event) {
                  pap.stack.push('keydown-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onKeyDown: (event) {
                      pap.stack.push('keydown-child');

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

      gparent.dispatchEvent(Event('keydown')); // first
      parent.dispatchEvent(Event('keydown')); // second
      child.dispatchEvent(Event('keydown')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keydown-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keydown-g-parent'));
      expect(pap.stack.popFromStart(), equals('keydown-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keydown-g-parent'));
      expect(pap.stack.popFromStart(), equals('keydown-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
