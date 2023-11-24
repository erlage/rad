// Copyright 2014 The Flutter Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/matchers.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('text', () {
    testWidgets('finds Text widgets', (tester) async {
      await tester.pumpWidget(
        const Text('test'),
      );

      expect(tester.find.text('test'), findsOneWidget);
    });
  });

  group('textContaining', () {
    testWidgets('finds Text widgets', (tester) async {
      await tester.pumpWidget(
        const Text('this is a test'),
      );

      expect(tester.find.textContaining(RegExp(r'test')), findsOneWidget);
      expect(tester.find.textContaining('test'), findsOneWidget);
      expect(tester.find.textContaining('a'), findsOneWidget);
      expect(tester.find.textContaining('s'), findsOneWidget);
    });
  });

  group('widgetWithText', () {
    testWidgets('finds widget', (tester) async {
      await tester.pumpWidget(
        const Button(
          key: Key('btn'),
          children: [
            Text('Update'),
          ],
        ),
      );

      expect(
        tester.find.widgetWithText(Button, 'Update'),
        findsOneWidget,
      );
    });
  });

  testWidgets('ChainedFinders chain properly', (tester) async {
    const key1 = Key('key1');

    await tester.pumpWidget(
      const Division(
        children: <Widget>[
          Division(
            key: key1,
            children: [
              Text('1'),
            ],
          ),
          Text('2'),
        ],
      ),
    );

    // Get the text back. By correctly chaining the descendant finder's
    // candidates, it should find 1 instead of 2. If the _LastFinder wasn't
    // correctly chained after the descendant's candidates, the last element
    // with a Text widget would have been 2.
    final Text text = tester.find
        .descendant(
          of: tester.find.byKey(key1),
          matching: tester.find.byType(Text),
        )
        .last
        .evaluate()
        .single
        .widget as Text;

    expect(text.text, '1');
  });

  testWidgets('finds multiple subtypes', (tester) async {
    await tester.pumpWidget(
      const Division(
        children: [
          Paragraph(
            children: [
              Text('Hello'),
              Text('World'),
            ],
          ),
          Paragraph(
            children: [
              Image(src: 'some-src'),
            ],
          ),
          Paragraph(
            children: [
              SimpleGenericWidget<int>(child: Text('one')),
              SimpleGenericWidget<double>(child: Text('pi')),
              SimpleGenericWidget<String>(child: Text('two')),
            ],
          ),
        ],
      ),
    );

    expect(tester.find.bySubtype<Division>(), findsOneWidget);

    expect(tester.find.bySubtype<Paragraph>(), findsNWidgets(3));

    // Finds only the requested generic subtypes.
    expect(
      tester.find.bySubtype<SimpleGenericWidget<int>>(),
      findsOneWidget,
    );

    expect(
      tester.find.bySubtype<SimpleGenericWidget<num>>(),
      findsNWidgets(2),
    );

    expect(
      tester.find.bySubtype<SimpleGenericWidget<Object>>(),
      findsNWidgets(3),
    );

    // Finds all widgets.
    final int totalWidgetCount = tester.find
        .byWidgetPredicate(
          (_) => true,
        )
        .evaluate()
        .length;

    expect(
      tester.find.bySubtype<Widget>(),
      findsNWidgets(totalWidgetCount),
    );
  });
}

class SimpleGenericWidget<T> extends StatelessWidget {
  const SimpleGenericWidget({required Widget child, super.key})
      : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
