// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_input_test() {
  group('Event onInput (native: input) tests:', () {
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
            onInput: (_) => pap.stack.push('input-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('input'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('input-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onInputCapture: (_) => pap.stack.push('input-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('input'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('input-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onInput: (_) => pap.stack.push('input-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onInput: (_) => pap.stack.push('input-parent'),
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

      gparent.dispatchEvent(Event('input')); // first
      parent.dispatchEvent(Event('input')); // second
      child.dispatchEvent(Event('input')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('input-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('input-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('input-parent'));

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
              onInput: (_) => pap.stack.push('input-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onInput: (event) {
                    pap.stack.push('input-parent');

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

        child.dispatchEvent(Event('input')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('input-parent'));
        expect(pap.stack.popFromStart(), equals('input-g-parent'));

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
              onInput: (_) => pap.stack.push('input-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onInput: (event) {
                    pap.stack.push('input-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onInput: (event) {
                        pap.stack.push('input-child');

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

        child.dispatchEvent(Event('input'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('input-child'));
        expect(pap.stack.popFromStart(), equals('input-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'input' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for input events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onInput: (event) {
              pap.stack.push('input-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onInputCapture: (event) {
                  pap.stack.push('input-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onInput: (event) {
                      pap.stack.push('input-child');

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

      gparent.dispatchEvent(Event('input')); // first
      parent.dispatchEvent(Event('input')); // second
      child.dispatchEvent(Event('input')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('input-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('input-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('input-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onInputCapture: (event) {
              pap.stack.push('input-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onInputCapture: (event) {
                  pap.stack.push('input-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onInput: (event) {
                      pap.stack.push('input-child');

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

      gparent.dispatchEvent(Event('input')); // first
      parent.dispatchEvent(Event('input')); // second
      child.dispatchEvent(Event('input')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('input-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('input-g-parent'));
      expect(pap.stack.popFromStart(), equals('input-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('input-g-parent'));
      expect(pap.stack.popFromStart(), equals('input-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
