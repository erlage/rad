// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Copyright (c) 2022, the Rad developers. All rights reserved.
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
