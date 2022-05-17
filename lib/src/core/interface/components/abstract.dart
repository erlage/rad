import 'package:meta/meta.dart';

/// Interface for external components.
///
@immutable
abstract class AppComponent {
  /// Name of the component.
  ///
  String get name;

  /// Auther name.
  ///
  String get author;

  /// Component version.
  ///
  String get version;

  @override
  toString() => 'From $name (v$version). Author: $author';
}

/// Interface for style injection.
///
@immutable
abstract class StyleComponent extends AppComponent {
  /// CSS contents to inject in DOM
  ///
  String? get styleSheetContents;

  @override
  toString() => 'From $name (v$version). Author: $author';
}
