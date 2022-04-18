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
  toString() => "From $name (v$version). Author: $author";
}
