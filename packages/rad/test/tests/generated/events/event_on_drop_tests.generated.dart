// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drop_test() {
  group('Event onDrop (native: drop) tests:', () {
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
            onDrop: (_) => pap.stack.push('drop-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('drop'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('drop-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onDropCapture: (_) => pap.stack.push('drop-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('drop'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('drop-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDrop: (_) => pap.stack.push('drop-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDrop: (_) => pap.stack.push('drop-parent'),
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

      gparent.dispatchEvent(Event('drop')); // first
      parent.dispatchEvent(Event('drop')); // second
      child.dispatchEvent(Event('drop')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('drop-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('drop-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('drop-parent'));

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
              onDrop: (_) => pap.stack.push('drop-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDrop: (event) {
                    pap.stack.push('drop-parent');

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

        child.dispatchEvent(Event('drop')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('drop-parent'));
        expect(pap.stack.popFromStart(), equals('drop-g-parent'));

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
              onDrop: (_) => pap.stack.push('drop-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onDrop: (event) {
                    pap.stack.push('drop-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDrop: (event) {
                        pap.stack.push('drop-child');

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

        child.dispatchEvent(Event('drop'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('drop-child'));
        expect(pap.stack.popFromStart(), equals('drop-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'drop' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for drop events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDrop: (event) {
              pap.stack.push('drop-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDropCapture: (event) {
                  pap.stack.push('drop-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDrop: (event) {
                      pap.stack.push('drop-child');

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

      gparent.dispatchEvent(Event('drop')); // first
      parent.dispatchEvent(Event('drop')); // second
      child.dispatchEvent(Event('drop')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('drop-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('drop-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('drop-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onDropCapture: (event) {
              pap.stack.push('drop-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onDropCapture: (event) {
                  pap.stack.push('drop-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onDrop: (event) {
                      pap.stack.push('drop-child');

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

      gparent.dispatchEvent(Event('drop')); // first
      parent.dispatchEvent(Event('drop')); // second
      child.dispatchEvent(Event('drop')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('drop-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('drop-g-parent'));
      expect(pap.stack.popFromStart(), equals('drop-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('drop-g-parent'));
      expect(pap.stack.popFromStart(), equals('drop-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
