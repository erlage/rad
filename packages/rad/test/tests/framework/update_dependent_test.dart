import '../../test_imports.dart';

void main() {
  group('update dependent context:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() {
      app!.stop();
    });

    test('should call update on dependent', () async {
      var pap = app!;

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('widget'),
            roEventHookUpdate: () => pap.stack.push('update'),
          ),
        ],
        parentContext: app!.appContext,
      );

      var widget = pap.widgetObjectByGlobalKey('widget');

      await pap.updateDependent(widget.context);
      await pap.updateDependent(widget.context);

      expect(pap.stack.popFromStart(), equals('update'));
      expect(pap.stack.popFromStart(), equals('update'));
      expect(pap.stack.canPop(), equals(false));
    });

    test('should set update type to dependencyChanged', () async {
      var pap = app!;

      await app!.buildChildren(
        widgets: [
          RT_TestWidget(
            key: GlobalKey('widget'),
            roHookUpdate: (type) => pap.stack.push(type.name),
          ),
        ],
        parentContext: app!.appContext,
      );

      var widget = pap.widgetObjectByGlobalKey('widget');

      await pap.updateDependent(widget.context);
      await pap.updateDependent(widget.context);

      var expectedName = UpdateType.dependencyChanged.name;

      expect(pap.stack.popFromStart(), equals(expectedName));
      expect(pap.stack.popFromStart(), equals(expectedName));
      expect(pap.stack.canPop(), equals(false));
    });
  });
}
