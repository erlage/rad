// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drag_start_test() {
  group('Event onDragStart (native: dragstart) tests:', () {
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
            onDragStart: (_) => pap.stack.push('dragstart-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('dragstart'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragstart-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('element'),
            onDragStartCapture: (_) => pap.stack.push('dragstart-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('dragstart'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragstart-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragStart: (_) => pap.stack.push('dragstart-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragStart: (_) => pap.stack.push('dragstart-parent'),
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

      gparent.dispatchEvent(Event('dragstart')); // first
      parent.dispatchEvent(Event('dragstart')); // second
      child.dispatchEvent(Event('dragstart')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

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
              onDragStart: (_) => pap.stack.push('dragstart-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragStart: (event) {
                    pap.stack.push('dragstart-parent');

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

        child.dispatchEvent(Event('dragstart')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragstart-parent'));
        expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

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
              onDragStart: (_) => pap.stack.push('dragstart-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragStart: (event) {
                    pap.stack.push('dragstart-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDragStart: (event) {
                        pap.stack.push('dragstart-child');

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

        child.dispatchEvent(Event('dragstart'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragstart-child'));
        expect(pap.stack.popFromStart(), equals('dragstart-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'dragstart' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for dragstart events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragStart: (event) {
              pap.stack.push('dragstart-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragStartCapture: (event) {
                  pap.stack.push('dragstart-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragStart: (event) {
                      pap.stack.push('dragstart-child');

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

      gparent.dispatchEvent(Event('dragstart')); // first
      parent.dispatchEvent(Event('dragstart')); // second
      child.dispatchEvent(Event('dragstart')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragStartCapture: (event) {
              pap.stack.push('dragstart-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragStartCapture: (event) {
                  pap.stack.push('dragstart-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragStart: (event) {
                      pap.stack.push('dragstart-child');

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

      gparent.dispatchEvent(Event('dragstart')); // first
      parent.dispatchEvent(Event('dragstart')); // second
      child.dispatchEvent(Event('dragstart')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragstart-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragstart-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
