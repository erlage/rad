import 'dart:html';

import 'package:trad/src/core/classes/framework.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget_object.dart';
import 'package:trad/src/core/types.dart';

/// How to behave during hit tests.
enum HitTestBehavior {
  /// Child gesture detectors will receive events and won't let them propagate to parents
  deferToChild,

  /// Receive events and prevent child gesture detectors from receiving events.
  opaque,

  /// All detectors that are hit will receive events.
  translucent,
}

class GestureDetector extends Widget {
  final String? key;

  final Widget child;
  final OnTapCallback? onTap;

  /// How this gesture detector should behave during hit testing.
  ///
  /// This defaults to [HitTestBehavior.deferToChild]
  final HitTestBehavior? behaviour;

  /// Creates a widget that detects gestures.
  GestureDetector({
    this.key,
    this.onTap,
    this.behaviour,
    required this.child,
  });

  @override
  RenderObject builder(BuildableContext context) {
    return GestureDetectorRenderObject(
      child: child,
      onTap: onTap,
      behaviour: behaviour ?? HitTestBehavior.deferToChild,
      buildableContext: context.mergeKey(key),
    );
  }
}

class GestureDetectorRenderObject extends RenderObject<GestureDetector> {
  final Widget child;
  final OnTapCallback? onTap;
  final HitTestBehavior behaviour;

  GestureDetectorRenderObject({
    required this.child,
    required this.onTap,
    required this.behaviour,
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
        );

  @override
  render(WidgetObject widgetObject) {
    widgetObject.htmlElement.addEventListener("click", _handleOnTap, behaviour == HitTestBehavior.opaque);

    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }

  _handleOnTap(Event event) {
    event.preventDefault();

    var userDefinedOnTap = onTap;

    if (null == userDefinedOnTap) {
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

    userDefinedOnTap(event);
  }
}
