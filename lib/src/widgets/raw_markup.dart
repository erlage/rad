import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';

/// A widget that helps pushing raw contents to the DOM.
///
/// This widget doesn't clean or sanitize inputs. This behaviour is
/// intentional to allow an application add Javascript into the DOM.
///
/// Example:
///
/// ```dart
/// Span(
///   child: RawMarkup('<table> {...} </table>'),
/// )
/// ```
///
class RawMarkUp extends Widget {
  final String html;

  const RawMarkUp(this.html, {Key? key}) : super(key: key);

  @nonVirtual
  @override
  get widgetType => "$RawMarkUp";

  @override
  get correspondingTag => DomTag.division;

  @override
  createConfiguration() => _RawMarkUpConfiguration(html);

  @override
  isConfigurationChanged(covariant _RawMarkUpConfiguration oldConfiguration) {
    return html != oldConfiguration.html;
  }

  @override
  createRenderObject(context) => _RawMarkupRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _RawMarkUpConfiguration extends WidgetConfiguration {
  final String html;

  const _RawMarkUpConfiguration(this.html);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _RawMarkupRenderObject extends RenderObject {
  const _RawMarkupRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _RawMarkUpConfiguration configuration,
  ) {
    element.setInnerHtml(configuration.html, validator: const _None());
  }

  @override
  update({
    required element,
    required updateType,
    required oldConfiguration,
    required covariant _RawMarkUpConfiguration newConfiguration,
  }) {
    element.setInnerHtml(newConfiguration.html, validator: const _None());
  }
}

/*
|--------------------------------------------------------------------------
| validator
|--------------------------------------------------------------------------
*/

class _None implements NodeValidator {
  const _None();

  @override
  allowsElement(_) => true;

  @override
  allowsAttribute(_, __, ___) => true;
}
