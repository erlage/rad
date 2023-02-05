// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: require_trailing_commas

import 'package:rad/rad.dart';
import 'package:rad_hooks/rad_hooks.dart';
import 'package:rad_test/rad_test.dart';
import 'package:test/expect.dart';

void main() {
  testWidgets(
    'should update callback on each render if dependencies are null',
    (tester) async {
      var count = 0;
      var callbacks = <VoidCallback>{};

      while (count++ < 5) {
        await tester.rePumpWidget(HookScope(() {
          callbacks.add(
            useCallback<void, void>(() {}),
          );

          return const Text('hello world');
        }));
      }

      expect(callbacks.length, equals(5));
    },
  );

  testWidgets(
    'should update only when dependencies are changed',
    (tester) async {
      var callbacks = <VoidCallback>{};

      Future<void> rebuildWithDependencies<T>([List<T>? dependencies]) async {
        await tester.rePumpWidget(HookScope(() {
          callbacks.add(
            useCallback<void, void>(() {}, dependencies),
          );

          return const Text('hello world');
        }));
      }

      await rebuildWithDependencies([]);
      await rebuildWithDependencies([]);
      await rebuildWithDependencies([]);
      expect(callbacks.length, equals(1));
      callbacks.clear();

      await rebuildWithDependencies([1, 2, 3]);
      await rebuildWithDependencies([1, 2, 3]);
      await rebuildWithDependencies([1, 2, 3, 4]);
      expect(callbacks.length, equals(2));
      callbacks.clear();

      await rebuildWithDependencies<dynamic>(null);
      await rebuildWithDependencies<dynamic>(null);
      await rebuildWithDependencies<dynamic>(null);
      expect(callbacks.length, equals(3));
      callbacks.clear();
    },
  );
}
