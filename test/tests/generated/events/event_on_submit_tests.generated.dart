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
            key: GlobalKey('element'),
            onSubmit: (_) => pap.stack.push('submit-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('submit'));

      expect(pap.stack.popFromStart(), equals('submit-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onSubmit: (_) => pap.stack.push('submit-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onSubmit: (_) => pap.stack.push('submit-parent'),
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

      gparent.dispatchEvent(Event('submit')); // first
      parent.dispatchEvent(Event('submit')); // second
      child.dispatchEvent(Event('submit')); // third

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
              key: GlobalKey('el-g-parent'),
              onSubmit: (_) => pap.stack.push('submit-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onSubmit: (event) {
                    pap.stack.push('submit-parent');

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

        child.dispatchEvent(Event('submit')); // third

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
              key: GlobalKey('el-g-parent'),
              onSubmit: (_) => pap.stack.push('submit-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
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

        child.dispatchEvent(Event('submit'));

        expect(pap.stack.popFromStart(), equals('submit-child'));
        expect(pap.stack.popFromStart(), equals('submit-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );
  });
}