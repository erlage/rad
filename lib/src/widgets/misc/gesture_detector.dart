import 'dart:html';

import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';

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
  builder(context) {
    return GestureDetectorRenderObject(
      child: child,
      onTap: onTap,
      onTapEvent: onTapEvent,
      behaviour: behaviour ?? HitTestBehavior.deferToChild,
      buildableContext: context.mergeKey(key),
    );
  }
}

class GestureDetectorRenderObject extends RenderObject<GestureDetector> {
  final Widget child;
  final VoidCallback? onTap;
  final OnTapEventCallback? onTapEvent;
  final HitTestBehavior behaviour;

  GestureDetectorRenderObject({
    required this.child,
    required this.onTap,
    required this.onTapEvent,
    required this.behaviour,
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
        );

  @override
  render(widgetObject) {
    widgetObject.htmlElement.addEventListener(
      "click",
      _handleOnTap,
      behaviour == HitTestBehavior.opaque,
    );

    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }

  _handleOnTap(Event event) {
    event.preventDefault();

    var userDefinedOnTap = onTap;
    var userDefinedOnTapEvent = onTapEvent;

    if (null == userDefinedOnTap && null == userDefinedOnTapEvent) {
      return;
    }

    switch (behaviour) {
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
