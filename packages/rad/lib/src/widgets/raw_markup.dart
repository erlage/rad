import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
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
  String get widgetType => 'RawMarkUp';

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  bool shouldUpdateWidget(covariant RawMarkUp oldWidget) {
    return html != oldWidget.html;
  }

  @override
  createRenderObject(context) => _RawMarkupRenderObject(context);
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
    required covariant RawMarkUp widget,
  }) {
    return DomNodeDescription(rawContents: widget.html);
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required covariant RawMarkUp newWidget,
  }) {
    return DomNodeDescription(rawContents: newWidget.html);
  }
}
