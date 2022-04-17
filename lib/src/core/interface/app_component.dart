import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/classes/debug.dart';
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
    scripts?.forEach(linkJavascript);

    stylesheets?.forEach(linkStylesheet);

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

          injectStyles(contents, "$styleComponent");
        }
      }
    }
  }

  /// Link a Stylesheet.
  ///
  void linkStylesheet(String href) {
    // create dom element

    var stylesheet = LinkElement()
      ..type = "text/css"
      ..rel = "stylesheet"
      ..href = href;

    insertIntoDocument(stylesheet, "Stylesheet linked: $href");
  }

  /// Link a Javascript.
  ///
  void linkJavascript(String href) {
    // create dom element

    var script = ScriptElement()
      ..defer = true
      ..type = "javascript/js"
      ..src = href;

    insertIntoDocument(script, "Javascript linked: $href");
  }

  /// Inject styles into DOM using <style> tag.
  ///
  void injectStyles(String styles, String flagLogEntry) {
    // create dom element

    var stylesheet = StyleElement()..innerText = styles;

    insertIntoDocument(stylesheet, "Styles injected: $flagLogEntry");
  }

  void insertIntoDocument(HtmlElement element, String flagLogEntry) {
    // insert stylesheet where possible

    if (null != document.head) {
      document.head!.insertBefore(element, null);
    } else if (null != document.body) {
      document.head!.insertBefore(element, null);
    } else {
      return Debug.exception(
        "For Rad to work, your page must have either a head tag or a body."
        "Creating a body(or head) in your page will fix this problem.",
      );
    }

    // log if flag is on

    if (Debug.frameworkLogs) {
      print(flagLogEntry);
    }
  }
}
