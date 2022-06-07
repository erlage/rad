// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_mouse_move_test() {
  group('Event onMouseMove (native: mousemove) tests:', () {
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
            onMouseMove: (_) => pap.stack.push('mousemove-domNode'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('mousemove'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mousemove-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('domNode'),
            onMouseMoveCapture: (_) => pap.stack.push('mousemove-domNode'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('mousemove'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('mousemove-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseMove: (_) => pap.stack.push('mousemove-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseMove: (_) => pap.stack.push('mousemove-parent'),
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

      gparent.dispatchEvent(Event('mousemove')); // first
      parent.dispatchEvent(Event('mousemove')); // second
      child.dispatchEvent(Event('mousemove')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

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
              onMouseMove: (_) => pap.stack.push('mousemove-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onMouseMove: (event) {
                    pap.stack.push('mousemove-parent');

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

        child.dispatchEvent(Event('mousemove')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mousemove-parent'));
        expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

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
              onMouseMove: (_) => pap.stack.push('mousemove-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onMouseMove: (event) {
                    pap.stack.push('mousemove-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onMouseMove: (event) {
                        pap.stack.push('mousemove-child');

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

        child.dispatchEvent(Event('mousemove'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('mousemove-child'));
        expect(pap.stack.popFromStart(), equals('mousemove-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'mousemove' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for mousemove events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseMove: (event) {
              pap.stack.push('mousemove-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseMoveCapture: (event) {
                  pap.stack.push('mousemove-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onMouseMove: (event) {
                      pap.stack.push('mousemove-child');

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

      gparent.dispatchEvent(Event('mousemove')); // first
      parent.dispatchEvent(Event('mousemove')); // second
      child.dispatchEvent(Event('mousemove')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onMouseMoveCapture: (event) {
              pap.stack.push('mousemove-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onMouseMoveCapture: (event) {
                  pap.stack.push('mousemove-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onMouseMove: (event) {
                      pap.stack.push('mousemove-child');

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

      gparent.dispatchEvent(Event('mousemove')); // first
      parent.dispatchEvent(Event('mousemove')); // second
      child.dispatchEvent(Event('mousemove')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));
      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('mousemove-g-parent'));
      expect(pap.stack.popFromStart(), equals('mousemove-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
