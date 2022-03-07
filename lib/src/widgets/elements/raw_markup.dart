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
class RawMarkUp extends Widget {
  final String? key;

  final String html;

  const RawMarkUp(
    this.html, {
    this.key,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (RawMarkUp).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return RawMarkupRenderObject(html: html, context: context);
  }
}

class RawMarkupRenderObject extends RenderObject {
  final String html;

  RawMarkupRenderObject({
    required this.html,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) =>
      widgetObject.element.setInnerHtml(html, validator: _None());

  @override
  update(
    updateType,
    widgetObject,
    covariant RawMarkupRenderObject updatedRenderObject,
  ) {
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
