// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_input_test() {
  group('Event onInput (native: input) tests:', () {
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
            onInput: (_) => pap.stack.push('input-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('input'));

      expect(pap.stack.popFromStart(), equals('input-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onInput: (_) => pap.stack.push('input-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onInput: (_) => pap.stack.push('input-parent'),
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

      gparent.dispatchEvent(Event('input')); // first
      parent.dispatchEvent(Event('input')); // second
      child.dispatchEvent(Event('input')); // third

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('input-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('input-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('input-parent'));

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
              onInput: (_) => pap.stack.push('input-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onInput: (event) {
                    pap.stack.push('input-parent');

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

        child.dispatchEvent(Event('input')); // third

        expect(pap.stack.popFromStart(), equals('input-parent'));
        expect(pap.stack.popFromStart(), equals('input-g-parent'));

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
              onInput: (_) => pap.stack.push('input-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onInput: (event) {
                    pap.stack.push('input-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onInput: (event) {
                        pap.stack.push('input-child');

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

        child.dispatchEvent(Event('input'));

        expect(pap.stack.popFromStart(), equals('input-child'));
        expect(pap.stack.popFromStart(), equals('input-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );
  });
}
