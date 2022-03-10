import 'package:meta/meta.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/interface/style_component.dart';

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
}

/// App components.
///
@immutable
class AppComponents {
  final List<StyleComponent>? styleComponents;

  AppComponents({this.styleComponents});

  load() {
    var styleComponents = this.styleComponents;

    if (null != styleComponents && styleComponents.isNotEmpty) {
      for (var styleComponent in styleComponents) {
        Framework.addGlobalStyles(
          styleComponent.styleSheetContents,
          "From ${styleComponent.name} (v ${styleComponent.version}). Author: ${styleComponent.author}",
        );
      }
    }
  }
}
