import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/widgets/abstract/single_child_render_object.dart';
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
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return OverlayEntryRenderObject(
      context: context,
      child: child,
      styleProps: StyleProps(styles),
    );
  }
}

class OverlayEntryRenderObject extends SingleChildRenderObject {
  final StyleProps styleProps;

  OverlayEntryRenderObject({
    required Widget child,
    required this.styleProps,
    required BuildContext context,
  }) : super(child, context);

  @override
  beforeRender(widgetObject) {
    styleProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant OverlayEntryRenderObject updatedRenderObject,
  ) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);
  }
}
