// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

void main() {
  group('update dependent tests:', () {
    testWidgets('should call update on dependent', (tester) async {
      var gKey = Key('gKey');

      await tester.pumpWidget(
        RT_TestWidget(
          key: gKey,
          roEventUpdate: () => tester.push('update'),
        ),
      );

      var wo = tester.getRenderElementByKeyValue(gKey)!;

      await tester.updateRenderElementAsIfDependant(wo);
      await tester.updateRenderElementAsIfDependant(wo);

      tester.assertMatchStack([
        'update',
        'update',
      ]);
    });

    testWidgets('should set update type to dependencyChanged', (tester) async {
      var gKey = Key('gKey');

      await tester.pumpWidget(
        RT_TestWidget(
          key: gKey,
          roHookUpdate: (type) => tester.push(type.name),
        ),
      );

      var wo = tester.getRenderElementByKeyValue(gKey)!;

      await tester.updateRenderElementAsIfDependant(wo);
      await tester.updateRenderElementAsIfDependant(wo);

      tester.assertMatchStack([
        UpdateType.dependencyChanged.name,
        UpdateType.dependencyChanged.name,
      ]);
    });
  });
}
