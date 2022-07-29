// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_mouse_over_test() {
  group('Event onMouseOver (native: mouseover) tests:', () {
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
            onMouseOver: (_) => pap.stack.push('mouseover-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mouseover'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseover-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onMouseOverCapture: (_) => pap.stack.push('mouseover-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('mouseover'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseover-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseOver: (_) => pap.stack.push('mouseover-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseOver: (_) => pap.stack.push('mouseover-parent'),
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

      gparent.dispatchEvent(Event('mouseover')); // first
      parent.dispatchEvent(Event('mouseover')); // second
      child.dispatchEvent(Event('mouseover')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-parent'));

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
              onMouseOver: (_) => pap.stack.push('mouseover-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseOver: (event) {
                    pap.stack.push('mouseover-parent');

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

        child.dispatchEvent(Event('mouseover')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseover-parent'));
        expect(pap.stack.popFromStart(), equals('mouseover-g-parent'));

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
              onMouseOver: (_) => pap.stack.push('mouseover-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onMouseOver: (event) {
                    pap.stack.push('mouseover-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onMouseOver: (event) {
                        pap.stack.push('mouseover-child');

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

        child.dispatchEvent(Event('mouseover'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseover-child'));
        expect(pap.stack.popFromStart(), equals('mouseover-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'mouseover' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for mouseover events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseOver: (event) {
              pap.stack.push('mouseover-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseOverCapture: (event) {
                  pap.stack.push('mouseover-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseOver: (event) {
                      pap.stack.push('mouseover-child');

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

      gparent.dispatchEvent(Event('mouseover')); // first
      parent.dispatchEvent(Event('mouseover')); // second
      child.dispatchEvent(Event('mouseover')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onMouseOverCapture: (event) {
              pap.stack.push('mouseover-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onMouseOverCapture: (event) {
                  pap.stack.push('mouseover-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onMouseOver: (event) {
                      pap.stack.push('mouseover-child');

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

      gparent.dispatchEvent(Event('mouseover')); // first
      parent.dispatchEvent(Event('mouseover')); // second
      child.dispatchEvent(Event('mouseover')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseover-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseover-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseover-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
