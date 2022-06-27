// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('dispatchEvent', () {
    testWidgets('should dispatch event', (tester) async {
      await tester.pumpWidget(
        Division(
          onClick: (_) => tester.stack.push('fired'),
          child: const Text('foo'),
        ),
      );

      await tester.dispatchEvent(
        event: Event('click'),
        finder: tester.find.widgetWithText(Division, 'foo'),
      );

      expect(tester.stack.popFromStart(), equals('fired'));
      expect(tester.stack.canPop(), equals(false));
    });

    testWidgets('should throw if matched n-widgets by default', (tester) async {
      await tester.pumpWidget(
        const Span(
          child: Span(
            child: Division(
              child: Text('foo'),
            ),
          ),
        ),
      );

      await tester.dispatchEvent(
        event: Event('change'),
        finder: tester.find.ancestor(
          of: tester.find.byType(Division),
          matching: tester.find.widgetWithText(Span, 'foo'),
        ),
      );

      expect(
        tester.takeException().toString(),
        contains('Found multiple matching widgets with the finder'),
      );
    });

    testWidgets('should dispatch to n-widgets', (tester) async {
      await tester.pumpWidget(
        Span(
          onClick: (_) => tester.stack.push('fired-parent'),
          child: Span(
            onClick: (e) {
              tester.stack.push('fired-child');

              // if event bubbles, it's corrupt our test stack
              e.stopImmediatePropagation();
            },
            child: const Division(
              child: Text('foo'),
            ),
          ),
        ),
      );

      await tester.dispatchEvent(
        event: Event('click'),
        finder: tester.find.ancestor(
          of: tester.find.byType(Division),
          matching: tester.find.widgetWithText(Span, 'foo'),
        ),
        dispatchToMultipleNodes: true,
      );

      expect(tester.stack.popFromStart(), equals('fired-child'));
      expect(tester.stack.popFromStart(), equals('fired-parent'));

      expect(tester.stack.canPop(), equals(false));
    });
  });

  group('click', () {
    testWidgets('should dispatch event', (tester) async {
      await tester.pumpWidget(
        Span(
          onClick: (_) => tester.stack.push('fired'),
          child: const Text('foo'),
        ),
      );

      await tester.click(tester.find.widgetWithText(Span, 'foo'));

      expect(tester.stack.popFromStart(), equals('fired'));
      expect(tester.stack.canPop(), equals(false));
    });

    testWidgets('should dispatch to n-widgets', (tester) async {
      await tester.pumpWidget(
        Span(
          onClick: (_) => tester.stack.push('fired-parent'),
          child: Span(
            onClick: (e) {
              tester.stack.push('fired-child');

              // if event bubbles, it's corrupt our test stack
              e.stopImmediatePropagation();
            },
            child: const Division(
              child: Text('foo'),
            ),
          ),
        ),
      );

      await tester.click(
        tester.find.ancestor(
          of: tester.find.byType(Division),
          matching: tester.find.widgetWithText(Span, 'foo'),
        ),
        dispatchToMultipleNodes: true,
      );

      expect(tester.stack.popFromStart(), equals('fired-child'));
      expect(tester.stack.popFromStart(), equals('fired-parent'));

      expect(tester.stack.canPop(), equals(false));
    });
  });
}
