// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drag_leave_test() {
  group('Event onDragLeave (native: dragleave) tests:', () {
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
            key: GlobalKey('element'),
            onDragLeave: (_) => pap.stack.push('dragleave-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('dragleave'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragleave-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('element'),
            onDragLeaveCapture: (_) => pap.stack.push('dragleave-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('dragleave'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragleave-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragLeave: (_) => pap.stack.push('dragleave-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragLeave: (_) => pap.stack.push('dragleave-parent'),
                children: [
                  RT_EventfulWidget(key: GlobalKey('el-child')),
                ],
              ),
            ],
          )
        ],
        parentContext: pap.appContext,
      );

      var gparent = pap.elementByGlobalKey('el-g-parent');
      var parent = pap.elementByGlobalKey('el-parent');
      var child = pap.elementByGlobalKey('el-child');

      gparent.dispatchEvent(Event('dragleave')); // first
      parent.dispatchEvent(Event('dragleave')); // second
      child.dispatchEvent(Event('dragleave')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-parent'));

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
              onDragLeave: (_) => pap.stack.push('dragleave-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragLeave: (event) {
                    pap.stack.push('dragleave-parent');

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

        var child = pap.elementByGlobalKey('el-child');

        child.dispatchEvent(Event('dragleave')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragleave-parent'));
        expect(pap.stack.popFromStart(), equals('dragleave-g-parent'));

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
              onDragLeave: (_) => pap.stack.push('dragleave-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragLeave: (event) {
                    pap.stack.push('dragleave-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDragLeave: (event) {
                        pap.stack.push('dragleave-child');

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

        var child = pap.elementByGlobalKey('el-child');

        child.dispatchEvent(Event('dragleave'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragleave-child'));
        expect(pap.stack.popFromStart(), equals('dragleave-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'dragleave' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for dragleave events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragLeave: (event) {
              pap.stack.push('dragleave-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragLeaveCapture: (event) {
                  pap.stack.push('dragleave-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragLeave: (event) {
                      pap.stack.push('dragleave-child');

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

      var gparent = pap.elementByGlobalKey('el-g-parent');
      var parent = pap.elementByGlobalKey('el-parent');
      var child = pap.elementByGlobalKey('el-child');

      gparent.dispatchEvent(Event('dragleave')); // first
      parent.dispatchEvent(Event('dragleave')); // second
      child.dispatchEvent(Event('dragleave')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragLeaveCapture: (event) {
              pap.stack.push('dragleave-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragLeaveCapture: (event) {
                  pap.stack.push('dragleave-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragLeave: (event) {
                      pap.stack.push('dragleave-child');

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

      var gparent = pap.elementByGlobalKey('el-g-parent');
      var parent = pap.elementByGlobalKey('el-parent');
      var child = pap.elementByGlobalKey('el-child');

      gparent.dispatchEvent(Event('dragleave')); // first
      parent.dispatchEvent(Event('dragleave')); // second
      child.dispatchEvent(Event('dragleave')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragleave-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragleave-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragleave-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
