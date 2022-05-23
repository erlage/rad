// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('Stateless widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render widgets returned by the build method', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_StatelessWidget(
            eventBuild: () => testStack.push('build-1'),
            children: [Text('contents')],
          ),
        ],
        parentContext: app!.appContext,
      );

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('build-1'));
        expect(testStack.canPop(), equals(false));

        expect(app!.appElement, RT_hasContents('contents'));
      });
    });

    test('should always call build on new widget instance', () async {
      var testStack = RT_TestStack();

      app!.framework.buildChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-1a')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-1b')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-1c')),
        ],
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-2a')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-2b')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-2c')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      app!.framework.updateChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-3a')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-3b')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-3c')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      await Future.delayed(Duration.zero, () {
        expect(testStack.popFromStart(), equals('build-1a'));
        expect(testStack.popFromStart(), equals('build-1b'));
        expect(testStack.popFromStart(), equals('build-1c'));

        expect(testStack.popFromStart(), equals('build-2a'));
        expect(testStack.popFromStart(), equals('build-2b'));
        expect(testStack.popFromStart(), equals('build-2c'));

        expect(testStack.popFromStart(), equals('build-3a'));
        expect(testStack.popFromStart(), equals('build-3b'));
        expect(testStack.popFromStart(), equals('build-3c'));

        expect(testStack.canPop(), equals(false));
      });
    });
  });
}
