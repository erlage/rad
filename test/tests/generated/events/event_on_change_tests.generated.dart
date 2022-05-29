// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_change_test() {
  group('Event onChange (native: change) tests:', () {
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
            onChange: (_) => pap.stack.push('change-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('change'));

      expect(pap.stack.popFromStart(), equals('change-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event only upto matching target', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onChange: (_) => pap.stack.push('change-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onChange: (_) => pap.stack.push('change-parent'),
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

      gparent.dispatchEvent(Event('change')); // first
      parent.dispatchEvent(Event('change')); // second
      child.dispatchEvent(Event('change')); // third

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('change-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('change-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('change-parent'));

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
              onChange: (_) => pap.stack.push('change-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onChange: (event) {
                    pap.stack.push('change-parent');

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

        child.dispatchEvent(Event('change')); // third

        expect(pap.stack.popFromStart(), equals('change-parent'));
        expect(pap.stack.popFromStart(), equals('change-g-parent'));

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
              onChange: (_) => pap.stack.push('change-g-parent'),
              children: [
                RT_EventfulWidget(
                  key: GlobalKey('el-parent'),
                  onChange: (event) {
                    pap.stack.push('change-parent');

                    event.stopPropagation();
                  },
                  children: [
                    RT_EventfulWidget(
                      onChange: (event) {
                        pap.stack.push('change-child');

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

        child.dispatchEvent(Event('change'));

        expect(pap.stack.popFromStart(), equals('change-child'));
        expect(pap.stack.popFromStart(), equals('change-parent'));

        expect(pap.stack.canPop(), equals(false));
      },
    );
  });
}