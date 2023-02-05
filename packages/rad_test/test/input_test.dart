// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/matchers.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('enter text test', () {
    testWidgets('should enter text', (tester) async {
      const gKey = Key('input');

      await tester.pumpWidget(
        const Input(key: gKey),
      );

      await tester.enterText(tester.find.byType(Input), 'hello world');

      expect(
        tester.getDomNodeByKey(gKey),
        domNodeHasValue('hello world'),
      );
    });

    testWidgets('should clear old text', (tester) async {
      const gKey = Key('input');

      await tester.pumpWidget(
        const Input(key: gKey, value: 'some text'),
      );

      expect(
        tester.getDomNodeByKey(gKey),
        domNodeHasValue('some text'),
      );

      await tester.enterText(tester.find.byType(Input), '');
      expect(tester.getDomNodeByKey(gKey), domNodeHasValue(''));
    });
  });

  group('focus test', () {
    testWidgets('should not focus by default', (tester) async {
      const gKey = Key('input');

      await tester.pumpWidget(
        const Input(key: gKey),
      );

      expect(tester.getDomNodeByKey(gKey), domNodeHasNotFocus);
    });

    testWidgets('should focus', (tester) async {
      const gKey = Key('input');

      await tester.pumpWidget(
        const Input(key: gKey),
      );

      await tester.focus(tester.find.byType(Input));

      expect(tester.getDomNodeByKey(gKey), domNodeHasFocus);
    });
  });
}
