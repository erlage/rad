import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';

/// A widget that helps pushing raw contents to the DOM.
///
/// This widget doesn't clean or sanitize inputs. This behaviour is
/// intentional to allow an application add Javascript into the DOM.
///
/// Example:
///
/// ```dart
/// Container(
///   child: Markup('<table> {...} </table>'),
/// )
/// ```
///
class MarkUp extends Widget {
  final String? key;

  final String html;

  const MarkUp(
    this.html, {
    this.key,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (MarkUp).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return MarkupRenderObject(html: html, context: context);
  }
}

class MarkupRenderObject extends RenderObject {
  final String html;

  MarkupRenderObject({
    required this.html,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) =>
      widgetObject.element.setInnerHtml(html, validator: _None());

  @override
  update(widgetObject, covariant MarkupRenderObject updatedRenderObject) {
    if (html != updatedRenderObject.html) {
      widgetObject.element.setInnerHtml(
        updatedRenderObject.html,
        validator: _None(),
      );
    }
  }
}

class _None implements NodeValidator {
  @override
  allowsElement(_) => true;

  @override
  allowsAttribute(_, __, ___) => true;
}
