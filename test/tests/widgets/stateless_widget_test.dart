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

      await app!.buildChildren(
        widgets: [
          RT_StatelessWidget(
            eventBuild: () => testStack.push('build-1'),
            children: [Text('contents')],
          ),
        ],
        parentContext: app!.appContext,
      );

      expect(testStack.popFromStart(), equals('build-1'));
      expect(testStack.canPop(), equals(false));

      expect(app!.appElement, RT_hasContents('contents'));
    });

    test('should always call build on new widget instance', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-1a')),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-2a')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-3a')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      expect(testStack.popFromStart(), equals('build-1a'));
      expect(testStack.popFromStart(), equals('build-2a'));
      expect(testStack.popFromStart(), equals('build-3a'));

      expect(testStack.canPop(), equals(false));
    });

    test('should build widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-1a')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-1b')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-1c')),
        ],
        parentContext: app!.appContext,
      );

      expect(testStack.popFromStart(), equals('build-1a'));
      expect(testStack.popFromStart(), equals('build-1b'));
      expect(testStack.popFromStart(), equals('build-1c'));

      expect(testStack.canPop(), equals(false));
    });

    test('should update widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('build-a')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-b')),
          RT_StatelessWidget(eventBuild: () => testStack.push('build-c')),
        ],
        parentContext: app!.appContext,
      );

      await app!.updateChildren(
        widgets: [
          RT_StatelessWidget(eventBuild: () => testStack.push('update-a')),
          RT_StatelessWidget(eventBuild: () => testStack.push('update-b')),
          RT_StatelessWidget(eventBuild: () => testStack.push('update-c')),
        ],
        updateType: UpdateType.setState,
        parentContext: app!.appContext,
      );

      expect(testStack.popFromStart(), equals('build-a'));
      expect(testStack.popFromStart(), equals('build-b'));
      expect(testStack.popFromStart(), equals('build-c'));

      expect(testStack.popFromStart(), equals('update-a'));
      expect(testStack.popFromStart(), equals('update-b'));
      expect(testStack.popFromStart(), equals('update-c'));

      expect(testStack.canPop(), equals(false));
    });
  });
}
