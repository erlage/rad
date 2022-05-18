import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/widgets_internals.dart';

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
  get widgetType => '$RawMarkUp';

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
  render({
    required covariant _RawMarkUpConfiguration configuration,
  }) {
    return ElementDescription(rawContents: configuration.html);
  }

  @override
  update({
    required updateType,
    required oldConfiguration,
    required covariant _RawMarkUpConfiguration newConfiguration,
  }) {
    return ElementDescription(rawContents: newConfiguration.html);
  }
}
