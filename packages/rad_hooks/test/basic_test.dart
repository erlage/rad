// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/rad.dart';
import 'package:rad_hooks/rad_hooks.dart';
import 'package:rad_test/rad_test.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('useState', () {
    testWidgets('should cause re-render on value change', (tester) async {
      await tester.pumpWidget(
        HookScope(() {
          var state = useState(0);

          return Text(
            '${state.value}',
            onClick: (_) => state.value++,
            key: const Key('text'),
          );
        }),
      );

      var domNode = tester.getDomNodeByKey(const Key('text'));

      expect(domNode, domNodeHasContents('0'));
      domNode?.click();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(domNode, domNodeHasContents('1'));

      domNode?.click();
      domNode?.click();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(domNode, domNodeHasContents('3'));
    });
  });

  group('useRef', () {
    testWidgets('should not cause re-render on value change', (tester) async {
      await tester.pumpWidget(
        HookScope(() {
          var state = useRef(0);

          return Text(
            '${state.value}',
            onClick: (_) => state.value++,
            key: const Key('text'),
          );
        }),
      );

      var domNode = tester.getDomNodeByKey(const Key('text'));

      expect(domNode, domNodeHasContents('0'));
      domNode?.click();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(domNode, domNodeHasContents('0'));

      domNode?.click();
      domNode?.click();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(domNode, domNodeHasContents('0'));
    });
  });
}
