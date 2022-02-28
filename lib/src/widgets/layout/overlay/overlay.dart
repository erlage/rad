import 'package:rad/rad.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/layout/overlay/overlay_entry.dart';
import 'package:rad/src/widgets/layout/overlay/overlay_state.dart';

/// A stack of entries that can be managed independently.
///
/// Overlays let independent child widgets "float" visual elements on top of
/// other widgets by inserting them into the overlay's stack. The overlay lets
/// each of these widgets manage their participation in the overlay using
/// [OverlayEntry] objects.
///
/// The [Overlay] widget uses a custom stack implementation, which is very
/// similar to the [Stack] widget but it provides more low-level controls.
///
/// See also:
///
///  * [OverlayEntry], the class that is used for describing the overlay entries.
///  * [OverlayState], which is used to insert the entries into the overlay.
///  * [Stack], which allows directly displaying a stack of widgets.
///
class Overlay extends Widget {
  final String? key;

  final String? style;

  final List<OverlayEntry> initialEntries;

  const Overlay({
    this.key,
    this.style,
    required this.initialEntries,
  });

  /// The state from the closest instance of this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// OverlayState overlay = Overlay.of(context);
  /// ```
  static OverlayState of(BuildContext context) {
    var widgetObject = Framework.findAncestorOfType<Overlay>(context);

    if (null == widgetObject) {
      throw "Overlay.of(context) called with the context that doesn't contains Overylay";
    }

    return OverlayState(widgetObject);
  }

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Overlay).toString();

  @override
  String? get initialKey => key;

  @override
  buildRenderObject(context) {
    return OverlayRenderObject(
      style: style ?? '',
      initialEntries: initialEntries,
      context: context.mergeKey(key),
    );
  }
}

class OverlayRenderObject extends RenderObject {
  final String style;

  final List<OverlayEntry> initialEntries;

  OverlayRenderObject({
    required this.style,
    required this.initialEntries,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className += " $style";
    }

    Framework.buildChildren(
      widgets: initialEntries,
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as OverlayRenderObject;

    // TODO implement
  }
}
