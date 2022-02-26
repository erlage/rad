import 'package:build/build.dart';

class StylesBuilder implements Builder {
  BuilderOptions options;

  StylesBuilder(this.options);

  @override
  final buildExtensions = const {
    '.css': ['.gen.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    var cssContents = await buildStep.readAsString(buildStep.inputId);

    var genAssetId = buildStep.inputId.changeExtension('.gen.dart');

    var fileName = buildStep.inputId.pathSegments.last;

    var genConstant = fileName.replaceAll('.css', '');

    if (!RegExp(r'^[a-zA-Z_]+$').hasMatch(genConstant)) {
      throw "\nTrad: Name of your CSS files can contains only alphabets and underscores\n"
          "File name '$fileName' is not allowed\n";
    }

    genConstant.toUpperCase();

    var genContents = "// ignore_for_file: constant_identifier_names\n"
        "\n// auto-generated. please don't edit this file\n\n"
        "const GEN_STYLES_${genConstant}_CSS = \"\"";

    for (var line in cssContents.split('\n')) {
      genContents = genContents + "\n    \" ${line.replaceAll('"', '\\"')} \"";
    }

    genContents = genContents + ";\n";

    await buildStep.writeAsString(genAssetId, genContents);
  }
}
