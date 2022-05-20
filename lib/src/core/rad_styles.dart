import 'package:rad/src/core/interface/components/abstract.dart';
import 'package:rad/src/css/main.generated.dart';

/// Framework CSS styles.
///
class RadStylesComponent extends StyleComponent {
  @override
  String get name => 'Rad framework default styles';

  @override
  String get author => 'rad-core';

  @override
  String get version => '0.8.0';

  @override
  String? get styleSheetContents => GEN_STYLES_MAIN_CSS;
}
