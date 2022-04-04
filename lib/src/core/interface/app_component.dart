import 'package:meta/meta.dart';
import 'package:rad/src/core/classes/debug.dart';
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

  @override
  toString() => "From $name (v$version). Author: $author";
}

/// App components.
///
@immutable
class Components {
  final List<String>? scripts;
  final List<String>? stylesheets;
  final List<StyleComponent>? styleComponents;

  const Components({
    this.scripts,
    this.stylesheets,
    this.styleComponents,
  });

  load() {
    scripts?.forEach(Framework.linkJavascript);

    stylesheets?.forEach(Framework.linkStylesheet);

    _loadStyleComponents();
  }

  _loadStyleComponents() {
    var styleComponents = this.styleComponents;

    if (null != styleComponents && styleComponents.isNotEmpty) {
      for (final styleComponent in styleComponents) {
        var contents = styleComponent.styleSheetContents;
        if (null != contents) {
          if (contents.length > 200) {
            return Debug.exception(
              "Package is trying to inject larger stylesheet than allowed. "
              "Please use your HTML page to inject stylesheets larger than 200 characters. \n\n"
              "Package details: $styleComponent",
            );
          }

          Framework.injectStyles(contents, "$styleComponent");
        }
      }
    }
  }
}
