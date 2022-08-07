// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: require_trailing_commas

import 'package:rad/rad.dart';
import 'package:rad_hooks/rad_hooks.dart';
import 'package:rad_test/rad_test.dart';

void main() {
  testWidgets(
    'should compute on each render if dependencies are null',
    (tester) async {
      var count = 0;
      while (count++ < 5) {
        await tester.rePumpWidget(HookScope(() {
          useMemo<int, int>(() {
            tester.push('$count');

            return 0;
          });

          return const Text('hello world');
        }));
      }

      tester.assertMatchStack(['1', '2', '3', '4', '5']);
    },
  );

  testWidgets(
    'should compute only when dependencies are changed',
    (tester) async {
      Future<void> rebuildWithDependencies<T>([List<T>? dependencies]) async {
        await tester.rePumpWidget(HookScope(() {
          useMemo(() {
            tester.push('compute');

            return 0;
          }, dependencies);

          return const Text('hello world');
        }));
      }

      await rebuildWithDependencies([]);
      await rebuildWithDependencies([]);
      await rebuildWithDependencies([]);
      tester.assertMatchStack(List.generate(1, (_) => 'compute'));

      await rebuildWithDependencies([1, 2, 3]);
      await rebuildWithDependencies([1, 2, 3]);
      await rebuildWithDependencies([1, 2, 3, 4]);
      tester.assertMatchStack(List.generate(2, (_) => 'compute'));

      await rebuildWithDependencies<dynamic>(null);
      await rebuildWithDependencies<dynamic>(null);
      await rebuildWithDependencies<dynamic>(null);
      tester.assertMatchStack(List.generate(3, (_) => 'compute'));
    },
  );
}
