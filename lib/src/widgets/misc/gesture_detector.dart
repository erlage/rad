import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/types.dart';

/// A widget that detects gestures.
///
/// Attempts to recognize gestures that correspond to its non-null callbacks.
///
/// See also:
///
///  * [HitTestBehavior], behaviour of a [GestureDetector]
class GestureDetector extends Widget {
  final String? key;

  final Widget child;
  final VoidCallback? onTap;

  /// Same as onTap but it'll send a Pointer Event object to callback.
  final OnTapEventCallback? onTapEvent;

  /// How this gesture detector should behave during hit testing.
  ///
  /// This defaults to [HitTestBehavior.deferToChild]
  final HitTestBehavior? behaviour;

  /// Creates a widget that detects gestures.
  GestureDetector({
    this.key,
    this.onTap,
    this.onTapEvent,
    this.behaviour,
    required this.child,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (GestureDetector).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return GestureDetectorRenderObject(
      context: context,
      props: GestureDetectorProps(
        child: child,
        onTap: onTap,
        onTapEvent: onTapEvent,
        behaviour: behaviour ?? HitTestBehavior.deferToChild,
      ),
    );
  }
}

class GestureDetectorProps {
  final Widget child;
  final VoidCallback? onTap;
  final OnTapEventCallback? onTapEvent;
  final HitTestBehavior behaviour;

  GestureDetectorProps({
    required this.child,
    required this.onTap,
    required this.onTapEvent,
    required this.behaviour,
  });
}

class GestureDetectorRenderObject extends RenderObject {
  GestureDetectorProps props;

  GestureDetectorRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    widgetObject.element.addEventListener(
      "click",
      _handleOnTap,
      props.behaviour == HitTestBehavior.opaque,
    );

    Framework.buildChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as GestureDetectorRenderObject;

    switchProps(updatedRenderObject.props);

    Framework.updateChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  void switchProps(GestureDetectorProps props) {
    this.props = props;
  }

  _handleOnTap(Event event) {
    event.preventDefault();

    var userDefinedOnTap = props.onTap;
    var userDefinedOnTapEvent = props.onTapEvent;

    if (null == userDefinedOnTap && null == userDefinedOnTapEvent) {
      return;
    }

    switch (props.behaviour) {
      case HitTestBehavior.opaque:
      case HitTestBehavior.deferToChild:
        event.stopPropagation();

        break;

      case HitTestBehavior.translucent:
        break;
    }

    if (null != userDefinedOnTapEvent) {
      userDefinedOnTapEvent(event);
    }

    if (null != userDefinedOnTap) {
      userDefinedOnTap();
    }
  }
}
