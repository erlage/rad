// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_drag_enter_test() {
  group('Event onDragEnter (native: dragenter) tests:', () {
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
            onDragEnter: (_) => pap.stack.push('dragenter-domNode'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('dragenter'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragenter-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should add a capture event listener', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('domNode'),
            onDragEnterCapture: (_) => pap.stack.push('dragenter-domNode'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var domNode = pap.domNodeByGlobalKey('domNode');

      domNode.dispatchEvent(Event('dragenter'));
      await Future.delayed(Duration(milliseconds: 50));

      expect(pap.stack.popFromStart(), equals('dragenter-domNode'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragEnter: (_) => pap.stack.push('dragenter-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragEnter: (_) => pap.stack.push('dragenter-parent'),
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

      gparent.dispatchEvent(Event('dragenter')); // first
      parent.dispatchEvent(Event('dragenter')); // second
      child.dispatchEvent(Event('dragenter')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-parent'));

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
              onDragEnter: (_) => pap.stack.push('dragenter-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragEnter: (event) {
                    pap.stack.push('dragenter-parent');

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

        child.dispatchEvent(Event('dragenter')); // third
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragenter-parent'));
        expect(pap.stack.popFromStart(), equals('dragenter-g-parent'));

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
              onDragEnter: (_) => pap.stack.push('dragenter-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onDragEnter: (event) {
                    pap.stack.push('dragenter-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onDragEnter: (event) {
                        pap.stack.push('dragenter-child');

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

        child.dispatchEvent(Event('dragenter'));
        await Future.delayed(Duration(milliseconds: 50));

        expect(pap.stack.popFromStart(), equals('dragenter-child'));
        expect(pap.stack.popFromStart(), equals('dragenter-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );

// framework stop propagation of 'dragenter' events
// when they reachs a matching target(that is listening for those type of
// events). to test capturing for dragenter events, we artifically
// restart propagation using restartPropagationIfStopped()

    test('should capture event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragEnter: (event) {
              pap.stack.push('dragenter-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragEnterCapture: (event) {
                  pap.stack.push('dragenter-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragEnter: (event) {
                      pap.stack.push('dragenter-child');

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

      gparent.dispatchEvent(Event('dragenter')); // first
      parent.dispatchEvent(Event('dragenter')); // second
      child.dispatchEvent(Event('dragenter')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should capture event(with multiple capture listeners)', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onDragEnterCapture: (event) {
              pap.stack.push('dragenter-g-parent');

              event.restartPropagationIfStopped();
            },
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onDragEnterCapture: (event) {
                  pap.stack.push('dragenter-parent');

                  event.stopPropagation();
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onDragEnter: (event) {
                      pap.stack.push('dragenter-child');

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

      gparent.dispatchEvent(Event('dragenter')); // first
      parent.dispatchEvent(Event('dragenter')); // second
      child.dispatchEvent(Event('dragenter')); // third
      await Future.delayed(Duration(milliseconds: 50));

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragenter-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('dragenter-g-parent'));
      expect(pap.stack.popFromStart(), equals('dragenter-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
