// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drag_end_test() {
  group('Event onDragEnd (native: dragend) tests:', () {
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
            onDragEnd: (_) => pap.stack.push('dragend-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('dragend'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragend-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('element'),
            onDragEndCapture: (_) => pap.stack.push('dragend-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('dragend'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragend-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragEnd: (_) => pap.stack.push('dragend-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragEnd: (_) => pap.stack.push('dragend-parent'),
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

      gparent.dispatchEvent(Event('dragend')); // first
      parent.dispatchEvent(Event('dragend')); // second
      child.dispatchEvent(Event('dragend')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

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
              onDragEnd: (_) => pap.stack.push('dragend-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragEnd: (event) {
                    pap.stack.push('dragend-parent');

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

        child.dispatchEvent(Event('dragend')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragend-parent'));
        expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

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
              onDragEnd: (_) => pap.stack.push('dragend-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragEnd: (event) {
                    pap.stack.push('dragend-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDragEnd: (event) {
                        pap.stack.push('dragend-child');

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

        child.dispatchEvent(Event('dragend'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragend-child'));
        expect(pap.stack.popFromStart(), equals('dragend-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'dragend' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for dragend events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragEnd: (event) {
              pap.stack.push('dragend-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragEndCapture: (event) {
                  pap.stack.push('dragend-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragEnd: (event) {
                      pap.stack.push('dragend-child');

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

      gparent.dispatchEvent(Event('dragend')); // first
      parent.dispatchEvent(Event('dragend')); // second
      child.dispatchEvent(Event('dragend')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragEndCapture: (event) {
              pap.stack.push('dragend-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragEndCapture: (event) {
                  pap.stack.push('dragend-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragEnd: (event) {
                      pap.stack.push('dragend-child');

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

      gparent.dispatchEvent(Event('dragend')); // first
      parent.dispatchEvent(Event('dragend')); // second
      child.dispatchEvent(Event('dragend')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragend-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragend-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
