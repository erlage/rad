// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_key_press_test() {
  group('Event onKeyPress (native: keypress) tests:', () {
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
            onKeyPress: (_) => pap.stack.push('keypress-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('keypress'));

      expect(pap.stack.popFromStart(), equals('keypress-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onKeyPress: (_) => pap.stack.push('keypress-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onKeyPress: (_) => pap.stack.push('keypress-parent'),
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

      gparent.dispatchEvent(Event('keypress')); // first
      parent.dispatchEvent(Event('keypress')); // second
      child.dispatchEvent(Event('keypress')); // third

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('keypress-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('keypress-parent'));

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
              onKeyPress: (_) => pap.stack.push('keypress-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyPress: (event) {
                    pap.stack.push('keypress-parent');

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

        child.dispatchEvent(Event('keypress')); // third

        expect(pap.stack.popFromStart(), equals('keypress-parent'));
        expect(pap.stack.popFromStart(), equals('keypress-g-parent'));

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
              onKeyPress: (_) => pap.stack.push('keypress-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onKeyPress: (event) {
                    pap.stack.push('keypress-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onKeyPress: (event) {
                        pap.stack.push('keypress-child');

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

        child.dispatchEvent(Event('keypress'));

        expect(pap.stack.popFromStart(), equals('keypress-child'));
        expect(pap.stack.popFromStart(), equals('keypress-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );
  });
}