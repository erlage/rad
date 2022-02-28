import 'package:rad/rad.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/layout/overlay/overlay_state.dart';

/// A place in an [Overlay] that can contain a widget.
///
/// Overlay entries are inserted into an [Overlay] using the
/// [OverlayState.insert] or [OverlayState.insertAll] functions. To find the
/// closest enclosing overlay for a given [BuildContext], use the [Overlay.of]
/// function.
///
/// See also:
///
///  * [Overlay]
///  * [OverlayState]
class OverlayEntry extends Widget {
  final String? key;

  final Widget child;
  final String? style;

  const OverlayEntry({
    this.key,
    this.style,
    required this.child,
  });

  @override
  String get type => (OverlayEntry).toString();

  @override
  DomTag get tag => DomTag.div;

  @override
  buildRenderObject(context) {
    return OverlayEntryRenderObject(
      child: child,
      style: style ?? '',
      context: context.mergeKey(key),
    );
  }
}

class OverlayEntryRenderObject extends RenderObject {
  final Widget child;
  final String style;

  OverlayEntryRenderObject({
    required this.child,
    required this.style,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className += " $style";
    }

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as OverlayEntryRenderObject;

    // TODO implement

    Framework.updateChildren(
      widgets: [child],
      parentContext: context,
    );
  }
}
