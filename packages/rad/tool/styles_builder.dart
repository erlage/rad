// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';

Builder styles(BuilderOptions options) => StylesBuilder(options);

///
/// Styles builder
///
/// it's a utility for dev purpose, and is not be shipped with framework.
///
/// it creates .dart files from .css files which then framework can inject
/// inside DOM
///
class StylesBuilder implements Builder {
  BuilderOptions options;

  StylesBuilder(this.options) {
    fetchAvailableImports();
  }

  /*
  |--------------------------------------------------------------------------
  | preparing state
  |--------------------------------------------------------------------------
  */

  // all public imports
  final availableImports = <String, String>{};

  void fetchAvailableImports() {
    for (final file in [
      'lib/rad.dart',
      'lib/widgets_async.dart',
      'lib/widgets_html.dart',
    ]) {
      File(file).readAsStringSync().split('\n').forEach(addToAvailableImports);
    }
  }

  void addToAvailableImports(String exportDetails) {
    var exportMatch = exportRegExp.firstMatch(exportDetails);

    if (null != exportMatch) {
      var importStatement = exportMatch.group(1)!;
      var classesExported = exportMatch.group(2)!.split(',');

      if (!importStatement.startsWith('package')) {
        importStatement = 'package:rad/$importStatement';
      }

      importStatement = "import '$importStatement';";

      for (final classInShow in classesExported) {
        if (!availableImports.containsKey(classInShow)) {
          availableImports[classInShow] = importStatement;
        }
      }
    }
  }

  /*
  |--------------------------------------------------------------------------
  | handling assets
  |--------------------------------------------------------------------------
  */

  final allowedLiteralExceptions = <String>[];

  // gets cleared for each asset
  final importsForCurrentAsset = <String>{};

  static final classRegExp = RegExp(r'(rad-wtype|wruntype)="([a-zA-Z]*)"');
  static final exportRegExp = RegExp(
    r"'([a-zA-Z_\/]*.dart)' show (.+?)(?:,|$)*;",
  );

  String parseLine(String line) {
    var match = classRegExp.firstMatch(line);

    if (null != match) {
      var className = match.group(2)!;

      if (allowedLiteralExceptions.contains(className)) {
        return line.replaceAll('"', r'\"');
      }

      // add a import requirement
      if (availableImports.containsKey(className)) {
        importsForCurrentAsset.add(availableImports[className]!);
      } else {
        throw Exception(
          '\nRad: Internal widgets should not have any CSS.\n $className is '
          'not a public class and is not allowed for CSS styling.\n',
        );
      }

      // interpolate
      line = line.replaceAll(className, '\$$className');
    }

    return line.replaceAll('"', r'\"');
  }

  @override
  final buildExtensions = const {
    '.css': ['.generated.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    var cssContents = await buildStep.readAsString(buildStep.inputId);

    var genAssetId = buildStep.inputId.changeExtension('.generated.dart');

    var fileName = buildStep.inputId.pathSegments.last;

    var genConstant = fileName.replaceAll('.css', '');

    if (!RegExp(r'^[a-zA-Z_]+$').hasMatch(genConstant)) {
      throw Exception(
        '\nRad: Name of your CSS files can contains only alphabets and '
        "underscores\n File name '$fileName' is not allowed\n",
      );
    }

    genConstant = genConstant.toUpperCase();

    var genContents = '';

    importsForCurrentAsset.clear();

    for (final line in cssContents.split('\n')) {
      genContents += '\n    " ${parseLine(line)} "';
    }

    var importStatements = '';

    if (importsForCurrentAsset.isNotEmpty) {
      importStatements = "${importsForCurrentAsset.join("\n")}\n\n";
    }

    genContents = '// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. '
        'All rights reserved.\n'
        '// Use of this source code is governed by a BSD-style license that '
        'can be\n// found in the LICENSE file.\n\n'
        '// ignore_for_file: non_constant_identifier_names\n'
        '// ignore_for_file: directives_ordering\n'
        '// ignore_for_file: prefer_single_quotes\n'
        '// ignore_for_file: constant_identifier_names\n'
        '// ignore_for_file: avoid_escaping_inner_quotes\n'
        "\n// auto-generated. please don't edit this file\n\n"
        '$importStatements'
        'const GEN_STYLES_${genConstant}_CSS = ""$genContents';
    // change const to final if there's interpolation

    genContents = '$genContents;\n';

    await buildStep.writeAsString(genAssetId, genContents);
  }
}
