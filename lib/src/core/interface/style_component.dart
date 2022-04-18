import 'package:meta/meta.dart';
import 'package:rad/src/core/interface/app_component.dart';

/// Interface for style injection.
///
@immutable
abstract class StyleComponent extends AppComponent {
  /// CSS contents to inject in DOM
  ///
  String? get styleSheetContents;

  @override
  toString() => "From $name (v$version). Author: $author";
}
