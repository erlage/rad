// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: require_trailing_commas

import 'package:rad/rad.dart';
import 'package:rad_hooks/rad_hooks.dart';
import 'package:rad_test/rad_test.dart';
import 'package:test/expect.dart';

import 'utils.dart';

void main() {
  testWidgets('should gets called after dom updates', (tester) async {
    var isRendered = false;
    await tester.pumpWidget(
      HookScope(() {
        useEffect(() {
          expect(tester.getAppDomNode, domNodeHasContents('hello world'));
          isRendered = true;

          return null;
        }, []);

        return const Text('hello world');
      }),
    );

    expect(isRendered, equals(true));
  });

  testWidgets('should clean after dom updates are flushed', (tester) async {
    await tester.pumpWidget(
      HookScope(() {
        useEffect(() {
          return () {
            expect(tester.getAppDomNode, domNodeHasContents('dom is updated'));
          };
        }, []);

        return const Text('hello world');
      }),
    );

    await tester.pumpWidget(const Text('dom is updated'));
  });

  testWidgets(
    'should gets called on each render if dependencies are null',
    (tester) async {
      var count = 0;
      while (count++ < 5) {
        await tester.rePumpWidget(
          testUseScopedEffectsWidget([
            TestEffectCallback(() {
              tester.push('$count');

              return null;
            })
          ]),
        );
      }

      tester.assertMatchStack(['1', '2', '3', '4', '5']);
    },
  );

  testWidgets(
    'should run cleanup before re-rendering',
    (tester) async {
      Future<void> rebuildWithCallback<T>(
        List<TestEffectCallback<dynamic>> callbacks,
      ) async {
        await tester.rePumpWidget(
          testUseScopedEffectsWidget(callbacks),
        );
      }

      await rebuildWithCallback<dynamic>([
        TestEffectCallback(() {
          tester.push('render 1');
          return () => tester.push('clean 1');
        }),
      ]);

      await rebuildWithCallback<dynamic>([
        TestEffectCallback(() {
          tester.push('render 2');
          return () => tester.push('clean 2');
        }, [1]),
      ]);

      tester.assertMatchStack(['render 1', 'clean 1', 'render 2']);

      await rebuildWithCallback<dynamic>([
        TestEffectCallback(() {
          tester.push('skipped render 3');
          return () => tester.push('skipped clean 3');
        }, [1]),
      ]);

      await rebuildWithCallback<dynamic>([
        TestEffectCallback(() {
          tester.push('render 4');
          return () => tester.push('clean 4');
        }, [2]),
      ]);

      tester.assertMatchStack(['clean 2', 'render 4']);

      // will dispose hook scope
      await tester.pumpWidget(const Text('hello world'));
      tester.assertMatchStack(['clean 4']);
    },
  );

  testWidgets(
    'should render only when dependencies are changed',
    (tester) async {
      Future<void> rebuildWithDependencies<T>([List<T>? dependencies]) async {
        await tester.rePumpWidget(
          testUseScopedEffectsWidget([
            TestEffectCallback(() {
              tester.push('render');

              return null;
            }, dependencies)
          ]),
        );
      }

      await rebuildWithDependencies([]);
      await rebuildWithDependencies([]);
      await rebuildWithDependencies([]);
      tester.assertMatchStack(List.generate(1, (_) => 'render'));

      await rebuildWithDependencies([1, 2, 3]);
      await rebuildWithDependencies([1, 2, 3]);
      await rebuildWithDependencies([1, 2, 3, 4]);
      tester.assertMatchStack(List.generate(2, (_) => 'render'));

      await rebuildWithDependencies<dynamic>(null);
      await rebuildWithDependencies<dynamic>(null);
      await rebuildWithDependencies<dynamic>(null);
      tester.assertMatchStack(List.generate(3, (_) => 'render'));
    },
  );
}
