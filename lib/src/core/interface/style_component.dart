import 'package:rad/src/core/interface/app_component.dart';

/// Interface for style injection.
///
abstract class StyleComponent extends AppComponent {
  /// CSS contents to inject in DOM
  ///
  String get styleSheetContents;
}
