// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:collection';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

final rExpStart = RegExp(r'\/\/\/\/ TEST__COMMENTABLE_MUTATION_START');
final rExpEnd = RegExp(r'\/\/\/\/ TEST__COMMENTABLE_MUTATION_END');

const inFilePath = '../lib/src/core/renderer/reconciler.dart';
const outFilePath = '../reconciler_tests.sh';

void main() {
  var mutations = _prepareMutations();

  _writeMutations(mutations);
}

List<String> _prepareMutations() {
  var mutations = <String>[];

  var file = io.File(inFilePath);

  var contents = file.readAsStringSync();

  contents = contents.replaceAllMapped(rExpEnd, (match) => '}');

  contents = contents.replaceAllMapped(rExpStart, (match) {
    mutations.add('${mutations.length}');

    return r"if(const String.fromEnvironment('m"
        "${mutations.length - 1}'"
        r", defaultValue: 'off') == 'off') {";
  });

  // !WARN: side effect
  file.writeAsStringSync(contents);

  return mutations;
}

void _writeMutations(List<String> mutations) {
  var outContents = '';
  var permutations = HashSet<String>();

  for (var index = 0; index <= mutations.length; index++) {
    permutations.addAll(
      findAllPermutations(
        List.generate(
          mutations.length,
          (i) => i > index ? '0' : '1',
        ).join(''),
      ),
    );
  }

  for (final permutation in permutations) {
    var splits = permutation.split('');

    outContents += '\n dart test test/tests/framework-hc';

    for (var i = 0; i < splits.length; i++) {
      if (splits[i] == '1') {
        outContents += ' --dart2js-args --define=m$i="on"';
      }
    }
  }

  io.File(outFilePath).writeAsStringSync(outContents);
}

String retrieveFilePath(String fileName, [String? baseDir]) {
  // https://stackoverflow.com/a/36128386

  path.Context context;
  if (io.Platform.isWindows) {
    context = path.Context(style: path.Style.windows);
  } else {
    context = path.Context(style: path.Style.posix);
  }

  baseDir ??= path.dirname(io.Platform.script.path);

  var filePath = context.join(baseDir, fileName);
  filePath = context.fromUri(context.normalize(filePath));
  filePath = path.fromUri(filePath).split('file:').last;

  return filePath;
}

List<String> findAllPermutations(String source) {
  // https://gist.github.com/montyr75/7632761

  // ignore: strict_raw_type
  List allPermutations = [];

  void permutate(List<String> list, int cursor) {
    if (cursor == list.length) {
      allPermutations.add(list);
      return;
    }

    for (int i = cursor; i < list.length; i++) {
      var permutation = List<String>.from(list);
      permutation[cursor] = list[i];
      permutation[i] = list[cursor];
      permutate(permutation, cursor + 1);
    }
  }

  permutate(source.split(''), 0);

  List<String> strPermutations = [];
  for (final permutation in allPermutations) {
    strPermutations.add(permutation.join());
  }

  return strPermutations;
}
