import 'dart:html';

import 'package:castor/src/core/classes/painter.dart';
import 'package:castor/src/core/enums.dart';
import 'package:castor/src/core/structures/widget.dart';
import 'package:castor/src/core/structures/render_object.dart';
import 'package:castor/src/core/structures/build_context.dart';
import 'package:castor/src/core/structures/widget_object.dart';
import 'package:castor/src/core/types.dart';

enum HitTestBehaviour {
  /// child gesture detectors will receive events and won't let them propagate to parents
  deferToChild,

  /// receive events and prevent child gesture detectors from receiving events
  opaque,

  /// all of the detectors that are hit will receive events
  translucent,
}

class GestureDetector extends Widget {
  final String? key;
  final String? classes;

  final Widget child;
  final OnTapCallback? onTap;
  final HitTestBehaviour? behaviour;

  GestureDetector({
    this.key,
    this.classes,
    this.onTap,
    this.behaviour,
    required this.child,
  });

  @override
  RenderObject builder(BuildableContext context) {
    return GestureDetectorRenderObject(
      child: child,
      classes: classes,
      onTap: onTap,
      behaviour: behaviour ?? HitTestBehaviour.deferToChild,
      buildableContext: BuildableContext(parentKey: context.parentKey),
    );
  }
}

class GestureDetectorRenderObject extends RenderObject<GestureDetector> {
  final String? classes;

  final Widget child;
  final OnTapCallback? onTap;
  final HitTestBehaviour behaviour;

  GestureDetectorRenderObject({
    required this.child,
    required this.classes,
    required this.onTap,
    required this.behaviour,
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
        );

  @override
  render(WidgetObject widgetObject) {
    if (null != classes) {
      widgetObject.htmlElement.className = classes!;
    }

    widgetObject.htmlElement.addEventListener("click", _handleOnTap, behaviour == HitTestBehaviour.opaque);

    Painter(widgetObject).renderSingleWidget(child);
  }

  _handleOnTap(Event event) {
    event.preventDefault();

    var userDefinedOnTap = onTap;

    if (null == userDefinedOnTap) {
      return;
    }

    switch (behaviour) {
      case HitTestBehaviour.opaque:
      case HitTestBehaviour.deferToChild:
        event.stopPropagation();

        break;

      case HitTestBehaviour.translucent:
        break;
    }

    userDefinedOnTap(event);
  }
}
