import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// A widget that detects gestures.
///
/// Attempts to recognize gestures that correspond to its non-null callbacks.
///
/// See also:
///
///  * [HitTestBehavior], behaviour of a [GestureDetector]
///
class GestureDetector extends StatefulWidget {
  final Widget child;

  final VoidCallback? onTap;
  final OnTapEventCallback? onTapEvent;
  final HitTestBehavior behaviour;

  GestureDetector({
    String? key,
    required this.child,
    this.onTap,
    this.onTapEvent,
    this.behaviour = HitTestBehavior.deferToChild,
  }) : super(key: key);

  @override
  State<GestureDetector> createState() => _GestureDetectorState();
}

class _GestureDetectorState extends State<GestureDetector> {
  @override
  initState() => _addListeners();

  @override
  dispose() => _removeListeners();

  @override
  build(context) => widget.child;

  @override
  didUpdateWidget(oldWidget) {
    //
    // we don't rebind onTap callback.
    // i.e in -> onTap: someVar ? () { A } : () { B }, Callback containing
    // B will never binds as onTap handler
    //

    var hadTap = hasOnTap(oldWidget);
    var hasTap = hasOnTap(widget);

    if (hadTap != hasTap) {
      if (hasTap) {
        _addOnTap();
      } else {
        _removeOnTap();
      }
    }
  }

  bool hasOnTap(GestureDetector detector) {
    return null != detector.onTap || null != detector.onTapEvent;
  }

  void _addListeners() {
    if (hasOnTap(widget)) {
      _addOnTap();
    }
  }

  void _removeListeners() {
    if (hasOnTap(widget)) {
      _removeOnTap();
    }
  }

  void _addOnTap() {
    var useCapture = HitTestBehavior.opaque == widget.behaviour;

    element.addEventListener("click", _handleOnTap, useCapture);
  }

  void _removeOnTap() {
    element.removeEventListener("click", _handleOnTap);
  }

  void _handleOnTap(Event event) {
    event.preventDefault();

    switch (widget.behaviour) {
      case HitTestBehavior.opaque:
      case HitTestBehavior.deferToChild:
        event.stopPropagation();

        break;

      case HitTestBehavior.translucent:
        break;
    }

    var userDefinedOnTap = widget.onTap;
    var userDefinedOnTapEvent = widget.onTapEvent;

    if (null != userDefinedOnTapEvent) {
      userDefinedOnTapEvent(event);
    }

    if (null != userDefinedOnTap) {
      userDefinedOnTap();
    }
  }
}
