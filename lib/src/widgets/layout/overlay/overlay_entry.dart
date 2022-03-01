import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/props/internal/styling_props.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
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
  final String? styles;

  const OverlayEntry({
    this.key,
    this.styles,
    required this.child,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (OverlayEntry).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return OverlayEntryRenderObject(
      context: context,
      child: child,
      styleProps: StylingProps(styles),
    );
  }
}

class OverlayEntryRenderObject extends RenderObject {
  final Widget child;
  final StylingProps styleProps;

  OverlayEntryRenderObject({
    required this.child,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    styleProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as OverlayEntryRenderObject;

    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }
}
