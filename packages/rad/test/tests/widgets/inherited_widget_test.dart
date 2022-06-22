// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  group('Inherited widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render child', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_InheritedWidget(
            eventUpdateShouldNotify: () => testStack.push('notify-1'),
            child: Text('contents'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(testStack.canPop(), equals(false));

      expect(app!.appDomNode, RT_hasContents('contents'));
    });

    test('should not call updateShouldNotify on initial build', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_InheritedWidget(
            eventUpdateShouldNotify: () => testStack.push('notify'),
            child: Text('contents'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(testStack.canPop(), equals(false));

      expect(app!.appDomNode, RT_hasContents('contents'));
    });

    test('should call updateShouldNotify on new instance', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_InheritedWidget(
            customHash: 'widget-1a',
            hookUpdateShouldNotify: ({
              required calledOnWidget,
              required calledWithWidget,
            }) {
              // this hook should never gets called
              // as it exists on old instance

              testStack.push('notify-on-1a');
            },
            child: RT_TestWidget(),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          RT_InheritedWidget(
            customHash: 'widget-2a',
            hookUpdateShouldNotify: ({
              required calledOnWidget,
              required calledWithWidget,
            }) {
              testStack.push('notify-on-2a');

              expect(calledOnWidget.hash, 'widget-2a');
              expect(calledWithWidget.hash, 'widget-1a');
            },
            child: RT_TestWidget(),
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          RT_InheritedWidget(
            customHash: 'widget-3a',
            hookUpdateShouldNotify: ({
              required calledOnWidget,
              required calledWithWidget,
            }) {
              testStack.push('notify-on-3a');

              expect(calledOnWidget.hash, 'widget-3a');
              expect(calledWithWidget.hash, 'widget-2a');
            },
            child: RT_TestWidget(),
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      // check stack

      expect(testStack.popFromStart(), equals('notify-on-2a'));
      expect(testStack.popFromStart(), equals('notify-on-3a'));

      expect(testStack.canPop(), equals(false));
    });

    test(
      'should cause context(dependents) to build '
      'if context inherits using dependOnInheritedWidgetOfExactType',
      () async {
        var testStack = RT_TestStack();

        // inherited widgets are effecient only when there is a short-circuit
        // at any node between inherited widget and dependent. to test inherited
        // widget we have to mannualy create a short-circuit in tree.

        var shortCircuitableSubTree = RT_TestWidget(
          children: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                testStack.push('call-dependOnInhe..-1a');

                state.context
                    .dependOnInheritedWidgetOfExactType<RT_InheritedWidget>();
              },
              stateEventBuild: () => testStack.push('build-stateful-1a'),
            )
          ],
        );

        await app!.buildChildren(
          widgets: [
            RT_InheritedWidget(
              eventUpdateShouldNotify: () => testStack.push('notify-1a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-1a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_InheritedWidget(
              overrideUpdateShouldNotify: () => true,
              eventUpdateShouldNotify: () => testStack.push('notify-2a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-2a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_InheritedWidget(
              overrideUpdateShouldNotify: () => false,
              eventUpdateShouldNotify: () => testStack.push('notify-2a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-2a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_InheritedWidget(
              overrideUpdateShouldNotify: () => true,
              eventUpdateShouldNotify: () => testStack.push('notify-3a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-3a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        // build phase

        expect(testStack.popFromStart(), equals('build-stateful-1a'));
        expect(testStack.popFromStart(), equals('call-dependOnInhe..-1a'));

        expect(testStack.popFromStart(), equals('mount-container-1a'));

        // update phase when updateShouldNotify return true

        expect(testStack.popFromStart(), equals('notify-2a'));
        expect(testStack.popFromStart(), equals('build-stateful-1a'));
        expect(testStack.popFromStart(), equals('call-dependOnInhe..-1a'));

        // update phase when updateShouldNotify return false

        expect(testStack.popFromStart(), equals('notify-2a'));

        // update phase when updateShouldNotify return true

        expect(testStack.popFromStart(), equals('notify-3a'));
        expect(testStack.popFromStart(), equals('build-stateful-1a'));
        expect(testStack.popFromStart(), equals('call-dependOnInhe..-1a'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should not cause context to build '
      'if context inherits using findAncestorWidgetOfExactType',
      () async {
        var testStack = RT_TestStack();

        var shortCircuitableSubTree = RT_TestWidget(
          children: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                testStack.push('call-findAnces..-1a');

                state.context
                    .findAncestorWidgetOfExactType<RT_InheritedWidget>();
              },
              stateEventBuild: () => testStack.push('build-stateful-1a'),
            )
          ],
        );

        await app!.buildChildren(
          widgets: [
            RT_InheritedWidget(
              eventUpdateShouldNotify: () => testStack.push('notify-1a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-1a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_InheritedWidget(
              overrideUpdateShouldNotify: () => true,
              eventUpdateShouldNotify: () => testStack.push('notify-2a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-2a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_InheritedWidget(
              overrideUpdateShouldNotify: () => false,
              eventUpdateShouldNotify: () => testStack.push('notify-3a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-2a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_InheritedWidget(
              overrideUpdateShouldNotify: () => true,
              eventUpdateShouldNotify: () => testStack.push('notify-4a'),
              child: RT_TestWidget(
                roEventAfterMount: () => testStack.push('mount-container-4a'),
                children: [shortCircuitableSubTree],
              ),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        // build phase

        expect(testStack.popFromStart(), equals('build-stateful-1a'));
        expect(testStack.popFromStart(), equals('call-findAnces..-1a'));

        expect(testStack.popFromStart(), equals('mount-container-1a'));

        // update phase when updateShouldNotify return true

        expect(testStack.popFromStart(), equals('notify-2a'));

        // update phase when updateShouldNotify return false

        expect(testStack.popFromStart(), equals('notify-3a'));

        // update phase when updateShouldNotify return true

        expect(testStack.popFromStart(), equals('notify-4a'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test('should build widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => testStack.push('mount-a'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => testStack.push('mount-b'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => testStack.push('mount-c'),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
      await Future.delayed(Duration.zero);

      expect(testStack.popFromStart(), equals('mount-a'));
      expect(testStack.popFromStart(), equals('mount-b'));
      expect(testStack.popFromStart(), equals('mount-c'));

      expect(testStack.canPop(), equals(false));
    });

    test('should update widgets in order', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => testStack.push('mount-a'),
              roEventUpdate: () => testStack.push('update-a'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => testStack.push('mount-b'),
              roEventUpdate: () => testStack.push('update-b'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => testStack.push('mount-c'),
              roEventUpdate: () => testStack.push('update-c'),
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          RT_InheritedWidget(child: RT_TestWidget()),
          RT_InheritedWidget(child: RT_TestWidget()),
          RT_InheritedWidget(child: RT_TestWidget()),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(testStack.popFromStart(), equals('mount-a'));
      expect(testStack.popFromStart(), equals('mount-b'));
      expect(testStack.popFromStart(), equals('mount-c'));

      expect(testStack.popFromStart(), equals('update-a'));
      expect(testStack.popFromStart(), equals('update-b'));
      expect(testStack.popFromStart(), equals('update-c'));

      expect(testStack.canPop(), equals(false));
    });
  });
}
