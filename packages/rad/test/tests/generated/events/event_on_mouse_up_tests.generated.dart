// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_mouse_up_test() {
  group('Event onMouseUp (native: mouseup) tests:', () {
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
            onMouseUp: (_) => pap.stack.push('mouseup-domNode'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('mouseup'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseup-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('domNode'),
            onMouseUpCapture: (_) => pap.stack.push('mouseup-domNode'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('mouseup'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mouseup-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseUp: (_) => pap.stack.push('mouseup-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseUp: (_) => pap.stack.push('mouseup-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: pap.appContext,
      );

      var gparent = pap.domNodeByGlobalKey('el-g-parent');
      var parent = pap.domNodeByGlobalKey('el-parent');
      var child = pap.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('mouseup')); // first
      parent.dispatchEvent(Event('mouseup')); // second
      child.dispatchEvent(Event('mouseup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

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
              onMouseUp: (_) => pap.stack.push('mouseup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onMouseUp: (event) {
                    pap.stack.push('mouseup-parent');

                    event.restartPropagationIfStopped();
                  },
                  children: [
                    RT_EventfulWidget(key: GlobalKey('el-child')),
                  ],
                ),
              ],
            )
          ],
          parentContext: pap.appContext,
        );

        var child = pap.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('mouseup')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseup-parent'));
        expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

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
              onMouseUp: (_) => pap.stack.push('mouseup-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onMouseUp: (event) {
                    pap.stack.push('mouseup-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onMouseUp: (event) {
                        pap.stack.push('mouseup-child');

                        event.restartPropagationIfStopped();
                      },
                      key: GlobalKey('el-child'),
                    ),
                  ],
                ),
              ],
            )
          ],
          parentContext: pap.appContext,
        );

        var child = pap.domNodeByGlobalKey('el-child');

        child.dispatchEvent(Event('mouseup'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mouseup-child'));
        expect(pap.stack.popFromStart(), equals('mouseup-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'mouseup' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for mouseup events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseUp: (event) {
              pap.stack.push('mouseup-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseUpCapture: (event) {
                  pap.stack.push('mouseup-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onMouseUp: (event) {
                      pap.stack.push('mouseup-child');

                      event.restartPropagationIfStopped();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
        parentContext: pap.appContext,
      );

      var gparent = pap.domNodeByGlobalKey('el-g-parent');
      var parent = pap.domNodeByGlobalKey('el-parent');
      var child = pap.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('mouseup')); // first
      parent.dispatchEvent(Event('mouseup')); // second
      child.dispatchEvent(Event('mouseup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseUpCapture: (event) {
              pap.stack.push('mouseup-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseUpCapture: (event) {
                  pap.stack.push('mouseup-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onMouseUp: (event) {
                      pap.stack.push('mouseup-child');

                      event.restartPropagationIfStopped();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
        parentContext: pap.appContext,
      );

      var gparent = pap.domNodeByGlobalKey('el-g-parent');
      var parent = pap.domNodeByGlobalKey('el-parent');
      var child = pap.domNodeByGlobalKey('el-child');

      gparent.dispatchEvent(Event('mouseup')); // first
      parent.dispatchEvent(Event('mouseup')); // second
      child.dispatchEvent(Event('mouseup')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mouseup-g-parent'));
      expect(pap.stack.popFromStart(), equals('mouseup-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
