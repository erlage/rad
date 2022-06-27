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

// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/rad.dart';
import 'package:rad/widgets_html.dart';
import 'package:rad_test/rad_test.dart';
import 'package:rad_test/src/modules/all_elements.dart';
import 'package:test/expect.dart';

void main() {
  testWidgets(
    'collectAllWidgetObjectsFrom goes in LTR DFS',
    (tester) async {
      var key = const GlobalKey('widget');

      await tester.pumpWidget(
        Division(
          key: key,
          child: const Paragraph(
            children: [
              Text('a'),
              Text('b'),
            ],
          ),
        ),
      );

      var renderElement = tester.getRenderElementByGlobalKey(key)!;

      final rElements = collectAllWidgetObjectsFrom(
        renderElement,
        skipOffstage: false,
      ).toList();

      expect(rElements.length, 3);

      expect(rElements[0].widget, isA<Paragraph>());

      expect(rElements[1].widget, isA<Text>());
      expect((rElements[1].widget as Text).text, 'a');

      expect(rElements[2].widget, isA<Text>());
      expect((rElements[2].widget as Text).text, 'b');
    },
  );
}
