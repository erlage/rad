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

import 'package:rad_test/src/modules/matchers.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

/// Class that makes it easy to mock common toStringDeep behavior.
///
class _MockToStringDeep {
  _MockToStringDeep(String str) : _lines = <String>[] {
    final List<String> lines = str.split('\n');
    for (int i = 0; i < lines.length - 1; ++i) {
      _lines.add('${lines[i]}\n');
    }

    // If the last line is empty, that really just means that the previous
    // line was terminated with a line break.

    if (lines.isNotEmpty && lines.last.isNotEmpty) {
      _lines.add(lines.last);
    }
  }

  _MockToStringDeep.fromLines(this._lines);

  /// Lines in the message to display when [toStringDeep] is called.
  /// For correct toStringDeep behavior, each line should be terminated with a
  /// line break.
  ///
  final List<String> _lines;

  String toStringDeep({
    String prefixLineOne = '',
    String prefixOtherLines = '',
  }) {
    final StringBuffer sb = StringBuffer();
    if (_lines.isNotEmpty) sb.write('$prefixLineOne${_lines.first}');

    for (int i = 1; i < _lines.length; ++i) {
      sb.write('$prefixOtherLines${_lines[i]}');
    }

    return sb.toString();
  }

  @override
  String toString() => toStringDeep();
}

void main() {
  test('hasOneLineDescription', () {
    expect('Hello', hasOneLineDescription);
    expect('Hello\nHello', isNot(hasOneLineDescription));
    expect(' Hello', isNot(hasOneLineDescription));
    expect('Hello ', isNot(hasOneLineDescription));
    expect(Object(), isNot(hasOneLineDescription));
  });

  test('hasAGoodToStringDeep', () {
    expect(_MockToStringDeep('Hello\n World\n'), hasAGoodToStringDeep);
    // Not terminated with a line break.
    expect(_MockToStringDeep('Hello\n World'), isNot(hasAGoodToStringDeep));
    // Trailing whitespace on last line.
    expect(_MockToStringDeep('Hello\n World \n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('Hello\n World\t\n'), isNot(hasAGoodToStringDeep));
    // Leading whitespace on line 1.
    expect(_MockToStringDeep(' Hello\n World \n'), isNot(hasAGoodToStringDeep));

    // Single line.
    expect(_MockToStringDeep('Hello World'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('Hello World\n'), isNot(hasAGoodToStringDeep));

    expect(_MockToStringDeep('Hello: World\nFoo: bar\n'), hasAGoodToStringDeep);
    expect(_MockToStringDeep('Hello: World\nFoo: 42\n'), hasAGoodToStringDeep);
    // Contains default Object.toString().
    expect(
      _MockToStringDeep('Hello: World\nFoo: ${Object()}\n'),
      isNot(hasAGoodToStringDeep),
    );
    expect(_MockToStringDeep('A\n├─B\n'), hasAGoodToStringDeep);
    expect(_MockToStringDeep('A\n├─B\n╘══════\n'), hasAGoodToStringDeep);
    // Last line is all whitespace or vertical line art.
    expect(_MockToStringDeep('A\n├─B\n\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n│\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n│\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n│\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n╎\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n║\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n │\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n ╎\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n ║\n'), isNot(hasAGoodToStringDeep));
    expect(_MockToStringDeep('A\n├─B\n ││\n'), isNot(hasAGoodToStringDeep));

    expect(
      _MockToStringDeep(
        'A\n'
        '├─B\n'
        '│\n'
        '└─C\n',
      ),
      hasAGoodToStringDeep,
    );
    // Last line is all whitespace or vertical line art.
    expect(
      _MockToStringDeep(
        'A\n'
        '├─B\n'
        '│\n',
      ),
      isNot(
        hasAGoodToStringDeep,
      ),
    );

    expect(
      _MockToStringDeep.fromLines(<String>[
        'Paragraph#00000\n',
        ' │ size: (400x200)\n',
        ' ╘═╦══ text ═══\n',
        '   ║ TextSpan:\n',
        '   ║   "I polished up that handle so carefullee\n',
        '   ║   That now I am the Ruler of the Queen\'s Navee!"\n',
        '   ╚═══════════\n'
      ]),
      hasAGoodToStringDeep,
    );

    // Text span
    expect(
      _MockToStringDeep.fromLines(<String>[
        'Paragraph#00000\n',
        ' │ size: (400x200)\n',
        ' ╘═╦══ text ═══\n',
        '   ║ TextSpan:\n',
        '   ║   "I polished up that handle so carefullee\nThat now I am the '
            'Ruler of the Queen\'s Navee!"\n',
        '   ╚═══════════\n'
      ]),
      isNot(hasAGoodToStringDeep),
    );
  });
}
