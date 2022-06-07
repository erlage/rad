import 'dart:html';

import 'package:rad/src/core/interface/components/abstract.dart';

/// App components.
///
class Components {
  Components._();
  static Components? _instance;
  static Components get instance => _instance ??= Components._();

  final _scripts = <String>{};
  final _stylesheets = <String>{};
  final _styleComponents = <String, StyleComponent>{};

  /// Link a Stylesheet.
  ///
  void linkStylesheet(String href) {
    if (_stylesheets.contains(href)) {
      return;
    }

    _stylesheets.add(href);

    var stylesheet = LinkElement()
      ..type = 'text/css'
      ..rel = 'stylesheet'
      ..href = href;

    _insertIntoDocument(stylesheet, 'Stylesheet linked: $href');
  }

  /// Link a Javascript.
  ///
  void linkJavascript(String href) {
    if (_scripts.contains(href)) {
      return;
    }

    _scripts.add(href);

    var script = ScriptElement()
      ..defer = true
      ..type = 'javascript/js'
      ..src = href;

    _insertIntoDocument(script, 'Javascript linked: $href');
  }

  /// Inject styles into DOM using <style> tag.
  ///
  void injectStyleComponent(StyleComponent component) {
    var componentKey = '$component';

    if (_styleComponents.containsKey(componentKey)) {
      return;
    }

    _styleComponents[componentKey] = component;

    var contents = component.styleSheetContents;

    var stylesheet = StyleElement()..innerText = contents ?? '';

    _insertIntoDocument(stylesheet, 'Styles injected: $component');
  }

  void _insertIntoDocument(HtmlElement domNode, String flagLogEntry) {
    // insert stylesheet where possible

    if (null != document.head) {
      document.head!.append(domNode);
    } else if (null != document.body) {
      document.head!.append(domNode);
    } else {
      throw Exception(
        'For Rad to work, your page must have either a head tag or a body. '
        'Creating a body(or head) in your page will fix this problem.',
      );
    }
  }
}
