import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
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
  builder(context) {
    return OverlayEntryRenderObject(
      child: child,
      style: style ?? '',
      buildableContext: context.mergeKey(key),
    );
  }
}

class OverlayEntryRenderObject extends RenderObject<OverlayEntry> {
  final Widget child;
  final String style;

  final BuildableContext buildableContext;

  OverlayEntryRenderObject({
    required this.child,
    required this.style,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.div,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className += " $style";
    }

    Framework.buildWidget(
      widget: child,
      parentContext: context,
    );
  }
}
