import 'dart:html';

import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/interface/components/abstract.dart';

/// App components.
///
class Components with ServicesResolver {
  /// Root context.
  ///
  final BuildContext rootContext;

  final List<String>? scripts;
  final List<String>? stylesheets;
  final List<StyleComponent>? styleComponents;

  /// Resolve services reference.
  ///
  Services get services => resolveServices(rootContext);

  Components({
    this.scripts,
    this.stylesheets,
    this.styleComponents,
    required this.rootContext,
  });

  void load() {
    scripts?.forEach(linkJavascript);

    stylesheets?.forEach(linkStylesheet);

    _loadStyleComponents();
  }

  void _loadStyleComponents() {
    var styleComponents = this.styleComponents;

    if (null != styleComponents && styleComponents.isNotEmpty) {
      for (final styleComponent in styleComponents) {
        var contents = styleComponent.styleSheetContents;
        if (null != contents) {
          if (contents.length > 1000) {
            return services.debug.exception(
              'Package is trying to inject larger stylesheet than allowed. '
              'Please use your HTML page to inject stylesheets larger than 200 '
              'characters. \n\n Package details: $styleComponent',
            );
          }

          injectStyles(contents, '$styleComponent');
        }
      }
    }
  }

  /// Link a Stylesheet.
  ///
  void linkStylesheet(String href) {
    // create dom element

    var stylesheet = LinkElement()
      ..type = 'text/css'
      ..rel = 'stylesheet'
      ..href = href;

    insertIntoDocument(stylesheet, 'Stylesheet linked: $href');
  }

  /// Link a Javascript.
  ///
  void linkJavascript(String href) {
    // create dom element

    var script = ScriptElement()
      ..defer = true
      ..type = 'javascript/js'
      ..src = href;

    insertIntoDocument(script, 'Javascript linked: $href');
  }

  /// Inject styles into DOM using <style> tag.
  ///
  void injectStyles(String styles, String flagLogEntry) {
    // create dom element

    var stylesheet = StyleElement()..innerText = styles;

    insertIntoDocument(stylesheet, 'Styles injected: $flagLogEntry');
  }

  void insertIntoDocument(HtmlElement element, String flagLogEntry) {
    // insert stylesheet where possible

    if (null != document.head) {
      document.head!.insertBefore(element, null);
    } else if (null != document.body) {
      document.head!.insertBefore(element, null);
    } else {
      return services.debug.exception(
        'For Rad to work, your page must have either a head tag or a body.'
        'Creating a body(or head) in your page will fix this problem.',
      );
    }

    // log if flag is on

    if (services.debug.frameworkLogs) {
      print(flagLogEntry);
    }
  }
}
