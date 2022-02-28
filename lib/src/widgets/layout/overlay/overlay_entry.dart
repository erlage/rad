import 'dart:html';

import 'package:rad/rad.dart';
import 'package:rad/src/core/constants.dart';
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
      props: OverlayEntryProps(
        child: child,
        styles: null != styles ? styles!.split(" ") : [],
      ),
    );
  }
}

class OverlayEntryProps {
  final Widget child;
  final List<String> styles;

  OverlayEntryProps({
    required this.child,
    required this.styles,
  });
}

class OverlayEntryRenderObject extends RenderObject {
  OverlayEntryProps props;

  OverlayEntryRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    applyProps(widgetObject.htmlElement);

    Framework.buildChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as OverlayEntryRenderObject;

    clearProps(widgetObject.htmlElement);

    switchProps(updatedRenderObject.props);

    applyProps(widgetObject.htmlElement);

    Framework.updateChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  void switchProps(OverlayEntryProps props) {
    this.props = props;
  }

  void applyProps(HtmlElement htmlElement) {
    if (props.styles.isNotEmpty) {
      htmlElement.classes.addAll(props.styles);
    }
  }

  void clearProps(HtmlElement htmlElement) {
    if (props.styles.isNotEmpty) {
      htmlElement.classes.removeAll(props.styles);
    }
  }
}
