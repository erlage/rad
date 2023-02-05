// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_change_test() {
  group('Event onChange (native: change) tests:', () {
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
            onChange: (_) => pap.stack.push('change-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('change'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('change-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onChangeCapture: (_) => pap.stack.push('change-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('change'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('change-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onChange: (_) => pap.stack.push('change-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onChange: (_) => pap.stack.push('change-parent'),
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

      gParent.dispatchEvent(Event('change')); // first
      parent.dispatchEvent(Event('change')); // second
      child.dispatchEvent(Event('change')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('change-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('change-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('change-parent'));

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
              onChange: (_) => pap.stack.push('change-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onChange: (event) {
                    pap.stack.push('change-parent');

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

        child.dispatchEvent(Event('change')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('change-parent'));
        expect(pap.stack.popFromStart(), equals('change-g-parent'));

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
              onChange: (_) => pap.stack.push('change-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onChange: (event) {
                    pap.stack.push('change-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onChange: (event) {
                        pap.stack.push('change-child');

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

        child.dispatchEvent(Event('change'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('change-child'));
        expect(pap.stack.popFromStart(), equals('change-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'change' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for change events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onChange: (event) {
              pap.stack.push('change-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onChangeCapture: (event) {
                  pap.stack.push('change-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onChange: (event) {
                      pap.stack.push('change-child');

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

      gParent.dispatchEvent(Event('change')); // first
      parent.dispatchEvent(Event('change')); // second
      child.dispatchEvent(Event('change')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('change-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('change-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('change-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onChangeCapture: (event) {
              pap.stack.push('change-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onChangeCapture: (event) {
                  pap.stack.push('change-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onChange: (event) {
                      pap.stack.push('change-child');

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

      gParent.dispatchEvent(Event('change')); // first
      parent.dispatchEvent(Event('change')); // second
      child.dispatchEvent(Event('change')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('change-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('change-g-parent'));
      expect(pap.stack.popFromStart(), equals('change-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('change-g-parent'));
      expect(pap.stack.popFromStart(), equals('change-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
