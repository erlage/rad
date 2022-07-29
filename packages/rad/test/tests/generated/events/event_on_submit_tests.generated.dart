// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_submit_test() {
  group('Event onSubmit (native: submit) tests:', () {
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
            onSubmit: (_) => pap.stack.push('submit-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('submit'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('submit-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('domNode'),
            onSubmitCapture: (_) => pap.stack.push('submit-domNode'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('domNode');

      domNode.dispatchEvent(Event('submit'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('submit-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onSubmit: (_) => pap.stack.push('submit-g-parent'),
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onSubmit: (_) => pap.stack.push('submit-parent'),
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

      gparent.dispatchEvent(Event('submit')); // first
      parent.dispatchEvent(Event('submit')); // second
      child.dispatchEvent(Event('submit')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('submit-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('submit-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('submit-parent'));

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
              onSubmit: (_) => pap.stack.push('submit-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onSubmit: (event) {
                    pap.stack.push('submit-parent');

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

        child.dispatchEvent(Event('submit')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('submit-parent'));
        expect(pap.stack.popFromStart(), equals('submit-g-parent'));

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
              onSubmit: (_) => pap.stack.push('submit-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: Key('el-parent'),
                  onSubmit: (event) {
                    pap.stack.push('submit-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onSubmit: (event) {
                        pap.stack.push('submit-child');

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

        child.dispatchEvent(Event('submit'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('submit-child'));
        expect(pap.stack.popFromStart(), equals('submit-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'submit' events
// when they reaches a matching target(that is listening for those type of
// events). to test capturing for submit events, we artificially
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onSubmit: (event) {
              pap.stack.push('submit-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onSubmitCapture: (event) {
                  pap.stack.push('submit-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onSubmit: (event) {
                      pap.stack.push('submit-child');

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

      gparent.dispatchEvent(Event('submit')); // first
      parent.dispatchEvent(Event('submit')); // second
      child.dispatchEvent(Event('submit')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('submit-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('submit-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('submit-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: Key('el-g-parent'),
            onSubmitCapture: (event) {
              pap.stack.push('submit-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: Key('el-parent'),
                onSubmitCapture: (event) {
                  pap.stack.push('submit-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: Key('el-child'),
                    onSubmit: (event) {
                      pap.stack.push('submit-child');

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

      gparent.dispatchEvent(Event('submit')); // first
      parent.dispatchEvent(Event('submit')); // second
      child.dispatchEvent(Event('submit')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('submit-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('submit-g-parent'));
      expect(pap.stack.popFromStart(), equals('submit-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('submit-g-parent'));
      expect(pap.stack.popFromStart(), equals('submit-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
