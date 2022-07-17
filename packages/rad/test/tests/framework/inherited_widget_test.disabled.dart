// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

// just to check that our test library is working fine

void main() {
  group('Inherited widget tests:', () {
    testWidgets('should render child', (tester) async {
      await tester.pumpWidget(
        RT_InheritedWidget(
          eventUpdateShouldNotify: () => tester.push('notify-1'),
          child: Text('contents'),
        ),
      );

      tester.assertMatchStack([]);

      expect(tester.getAppDomNode, domNodeHasContents('contents'));
    });

    testWidgets(
      'should not call updateShouldNotify on initial build',
      (tester) async {
        await tester.pumpWidget(
          RT_InheritedWidget(
            eventUpdateShouldNotify: () => tester.push('notify'),
            child: Text('contents'),
          ),
        );

        tester.assertMatchStack([]);

        expect(tester.getAppDomNode, domNodeHasContents('contents'));
      },
    );

    testWidgets(
      'should call updateShouldNotify on new instance',
      (tester) async {
        await tester.pumpWidget(
          RT_InheritedWidget(
            customHash: 'widget-1a',
            hookUpdateShouldNotify: ({
              required calledOnWidget,
              required calledWithWidget,
            }) {
              // this hook should never gets called
              // as it exists on old instance

              tester.push('notify-on-1a');
            },
            child: RT_TestWidget(),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            customHash: 'widget-2a',
            hookUpdateShouldNotify: ({
              required calledOnWidget,
              required calledWithWidget,
            }) {
              tester.push('notify-on-2a');

              expect(calledOnWidget.hash, 'widget-2a');
              expect(calledWithWidget.hash, 'widget-1a');
            },
            child: RT_TestWidget(),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            customHash: 'widget-3a',
            hookUpdateShouldNotify: ({
              required calledOnWidget,
              required calledWithWidget,
            }) {
              tester.push('notify-on-3a');

              expect(calledOnWidget.hash, 'widget-3a');
              expect(calledWithWidget.hash, 'widget-2a');
            },
            child: RT_TestWidget(),
          ),
        );

        // check stack

        tester.assertMatchStack([
          'notify-on-2a',
          'notify-on-3a',
        ]);
      },
    );

    testWidgets(
      'should cause context(dependents) to build '
      'if context inherits using dependOnInheritedWidgetOfExactType',
      (tester) async {
        // inherited widgets are effecient only when there is a short-circuit
        // at any node between inherited widget and dependent. to test inherited
        // widget we have to mannualy create a short-circuit in tree.

        var shortCircuitableSubTree = RT_TestWidget(
          children: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                tester.push('call-dependOnInhe..-1a');

                state.context
                    .dependOnInheritedWidgetOfExactType<RT_InheritedWidget>();
              },
              stateEventBuild: () => tester.push('build-stateful-1a'),
            )
          ],
        );

        await tester.pumpWidget(
          RT_InheritedWidget(
            eventUpdateShouldNotify: () => tester.push('notify-1a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-1a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            overrideUpdateShouldNotify: () => true,
            eventUpdateShouldNotify: () => tester.push('notify-2a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-2a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            overrideUpdateShouldNotify: () => false,
            eventUpdateShouldNotify: () => tester.push('notify-2a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-2a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            overrideUpdateShouldNotify: () => true,
            eventUpdateShouldNotify: () => tester.push('notify-3a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-3a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        tester.assertMatchStack([
          // build phase

          'build-stateful-1a',
          'call-dependOnInhe..-1a',

          'mount-container-1a',

          // update phase when updateShouldNotify return true

          'notify-2a',
          'build-stateful-1a',
          'call-dependOnInhe..-1a',

          // update phase when updateShouldNotify return false

          'notify-2a',

          // update phase when updateShouldNotify return true

          'notify-3a',
          'build-stateful-1a',
          'call-dependOnInhe..-1a',
        ]);
      },
    );

    testWidgets(
      'should not cause context to build '
      'if context inherits using findAncestorWidgetOfExactType',
      (tester) async {
        var shortCircuitableSubTree = RT_TestWidget(
          children: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                tester.push('call-findAnces..-1a');

                state.context
                    .findAncestorWidgetOfExactType<RT_InheritedWidget>();
              },
              stateEventBuild: () => tester.push('build-stateful-1a'),
            )
          ],
        );

        await tester.pumpWidget(
          RT_InheritedWidget(
            eventUpdateShouldNotify: () => tester.push('notify-1a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-1a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            overrideUpdateShouldNotify: () => true,
            eventUpdateShouldNotify: () => tester.push('notify-2a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-2a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            overrideUpdateShouldNotify: () => false,
            eventUpdateShouldNotify: () => tester.push('notify-3a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-2a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        await tester.rePumpWidget(
          RT_InheritedWidget(
            overrideUpdateShouldNotify: () => true,
            eventUpdateShouldNotify: () => tester.push('notify-4a'),
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-container-4a'),
              children: [shortCircuitableSubTree],
            ),
          ),
        );

        tester.assertMatchStack([
          // build phase

          'build-stateful-1a',
          'call-findAnces..-1a',

          'mount-container-1a',

          // update phase when updateShouldNotify return true

          'notify-2a',

          // update phase when updateShouldNotify return false

          'notify-3a',

          // update phase when updateShouldNotify return true

          'notify-4a',
        ]);
      },
    );

    testWidgets('should build widgets in order', (tester) async {
      await tester.pumpMultipleWidgets(
        [
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-a'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-b'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-c'),
            ),
          ),
        ],
      );

      tester.assertMatchStack([
        'mount-a',
        'mount-b',
        'mount-c',
      ]);
    });

    testWidgets('should update widgets in order', (tester) async {
      await tester.pumpMultipleWidgets(
        [
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-a'),
              roEventUpdate: () => tester.push('update-a'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-b'),
              roEventUpdate: () => tester.push('update-b'),
            ),
          ),
          RT_InheritedWidget(
            child: RT_TestWidget(
              roEventAfterMount: () => tester.push('mount-c'),
              roEventUpdate: () => tester.push('update-c'),
            ),
          ),
        ],
      );

      await tester.rePumpMultipleWidgets(
        [
          RT_InheritedWidget(child: RT_TestWidget()),
          RT_InheritedWidget(child: RT_TestWidget()),
          RT_InheritedWidget(child: RT_TestWidget()),
        ],
        updateType: UpdateType.setState,
      );

      tester.assertMatchStack([
        'mount-a',
        'mount-b',
        'mount-c',
        'update-a',
        'update-b',
        'update-c',
      ]);
    });
  });
}
