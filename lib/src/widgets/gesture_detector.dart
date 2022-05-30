import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';
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

  final Callback? onTap;
  final Callback? onDoubleTap;
  final EventCallback? onTapEvent;
  final EventCallback? onDoubleTapEvent;

  /// Hit testing behaviour.
  ///
  /// Applies only to tap/double tap events.
  ///
  final HitTestBehavior behaviour;

  final EventCallback? onMouseEnterEvent;
  final EventCallback? onMouseLeaveEvent;

  const GestureDetector({
    Key? key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onTapEvent,
    this.onDoubleTapEvent,
    this.onMouseEnterEvent,
    this.onMouseLeaveEvent,
    this.behaviour = HitTestBehavior.deferToChild,
  }) : super(key: key);

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners => {
        DomEventType.mouseEnter: onMouseEnterEvent,
        DomEventType.mouseLeave: onMouseLeaveEvent,
      };

  @override
  State<GestureDetector> createState() => _GestureDetectorState();
}

class _GestureDetectorState extends State<GestureDetector> {
  HtmlElement? _element;
  HtmlElement get element => _element!;

  final _availableEventListeners = [
    DomEventType.click,
    DomEventType.doubleClick,
  ];

  @override
  initState() {
    _element = context.findElement() as HtmlElement;

    _refreshEventListeners(null);
  }

  @override
  dispose() => _removeListeners();

  @override
  build(context) => widget.child;

  @override
  didUpdateWidget(oldWidget) => _refreshEventListeners(oldWidget);

  void _refreshEventListeners(GestureDetector? oldWidget) {
    for (final eventType in _availableEventListeners) {
      var hasListener = _doWidgetHasListener(eventType, widget);
      var hadListener = false;

      if (null != oldWidget) {
        hadListener = _doWidgetHasListener(eventType, oldWidget);
      }

      //
      // we don't rebind event listeners for tap/doubleTaps.
      // i.e in -> onTap: someVar ? () { A } : () { B }, Callback containing
      // B will never binds as onTap handler
      //

      if (hasListener != hadListener) {
        if (hasListener) {
          _addListener(eventType);
        } else {
          _removeListener(eventType);
        }
      }
    }
  }

  void _removeListeners() {
    for (final eventType in _availableEventListeners) {
      _removeListener(eventType);
    }
  }

  bool _doWidgetHasListener(DomEventType eventType, GestureDetector widget) {
    switch (eventType) {
      case DomEventType.click:
        return null != widget.onTap || null != widget.onTapEvent;

      case DomEventType.doubleClick:
        return null != widget.onDoubleTap || null != widget.onDoubleTapEvent;

      default:
        return false;
    }
  }

  void _addListener(DomEventType eventType) {
    var nativeType = fnMapDomEventType(eventType);
    var useCapture = HitTestBehavior.opaque == widget.behaviour;

    element.addEventListener(nativeType, _handleNative, useCapture);
  }

  void _removeListener(DomEventType eventType) {
    var nativeType = fnMapDomEventType(eventType);

    element.removeEventListener(nativeType, _handleNative);
  }

  void _handleNative(Event event) {
    var emittedEvent = EmittedEvent.fromNativeEvent(event);

    emittedEvent.preventDefault();

    switch (widget.behaviour) {
      case HitTestBehavior.opaque:
      case HitTestBehavior.deferToChild:
        emittedEvent.stopPropagation();

        break;

      case HitTestBehavior.translucent:
        break;
    }

    _dispatch(emittedEvent);
  }

  void _dispatch(EmittedEvent event) {
    Callback? listener;
    EventCallback? eventListener;

    switch (fnMapEventTypeToDomEventType(event.type)) {
      case DomEventType.click:
        listener = widget.onTap;
        eventListener = widget.onTapEvent;

        break;

      case DomEventType.doubleClick:
        listener = widget.onDoubleTap;
        eventListener = widget.onDoubleTapEvent;

        break;

      default:
        break;
    }

    if (null != listener) {
      listener();
    }

    if (null != eventListener) {
      eventListener(event);
    }
  }
}
