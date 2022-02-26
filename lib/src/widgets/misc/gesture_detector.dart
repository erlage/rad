import 'dart:html';

import 'package:trad/src/core/framework.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/buildable_context.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/objects/render_object.dart';
import 'package:trad/src/core/types.dart';

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
  builder(context) {
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
  render(widgetObject) {
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
