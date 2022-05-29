// Auto-generated file
//
// Sources of these tests can be found in /test/templates/events folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_events_test.dart';

void event_on_click_test() {
  group('Event onClick (native: click) tests:', () {
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
            onClick: (_) => pap.stack.push('click-element'),
          ),
        ],
        parentContext: pap.appContext,
      );

      var element = pap.elementByGlobalKey('element');

      element.dispatchEvent(Event('click'));

      expect(pap.stack.popFromStart(), equals('click-element'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should propagate event', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onClick: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onClick: (_) => pap.stack.push('click-parent'),
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
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

      gparent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));
      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-child'));
      expect(pap.stack.popFromStart(), equals('click-parent'));
      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should stop propagation after stopPropagation() is called', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onClick: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onClick: (event) {
                  event.stopPropagation();

                  pap.stack.push('click-parent');
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
                  ),
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

      gparent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-child'));
      expect(pap.stack.popFromStart(), equals('click-parent'));

      expect(pap.stack.canPop(), equals(false));
    });

    test('should stop after stopImmediatePropagation() is called', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_EventfulWidget(
            key: GlobalKey('el-g-parent'),
            onClick: (_) => pap.stack.push('click-g-parent'),
            children: [
              RT_EventfulWidget(
                key: GlobalKey('el-parent'),
                onClick: (event) {
                  event.stopImmediatePropagation();

                  pap.stack.push('click-parent');
                },
                children: [
                  RT_EventfulWidget(
                    key: GlobalKey('el-child'),
                    onClick: (_) => pap.stack.push('click-child'),
                  ),
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

      gparent.dispatchEvent(Event('click')); // first
      parent.dispatchEvent(Event('click')); // second
      child.dispatchEvent(Event('click')); // third

      // after 1st dispatch

      expect(pap.stack.popFromStart(), equals('click-g-parent'));

      // after 2nd dispatch

      expect(pap.stack.popFromStart(), equals('click-parent'));

      // after 3rd dispatch

      expect(pap.stack.popFromStart(), equals('click-child'));
      expect(pap.stack.popFromStart(), equals('click-parent'));

      expect(pap.stack.canPop(), equals(false));
    });
  });
}
