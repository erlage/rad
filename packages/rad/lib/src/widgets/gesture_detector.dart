import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget that detects gestures.
///
/// Attempts to recognize gestures that correspond to its non-null callbacks.
///
/// See also:
///
///  * [HitTestBehavior], behaviour of a [GestureDetector]
///
class GestureDetector extends Widget {
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

  /*
  |--------------------------------------------------------------------------
  | widget internals
  |--------------------------------------------------------------------------
  */

  @override
  List<Widget> get widgetChildren => [child];

  @nonVirtual
  @override
  String get widgetType => 'GestureDetector';

  // gesture detector creates a dom node(div) because it has to
  // register event listeners on a dom node.

  @nonVirtual
  @override
  DomTagType get correspondingTag => DomTagType.division;

  @nonVirtual
  @override
  bool shouldWidgetUpdate(oldWidget) => true;

  @nonVirtual
  @override
  createRenderObject(context) => _GestureDetectorRenderObject(
        context: context,
        state: _GestureDetectorState(),
      );
}

/*
|--------------------------------------------------------------------------
| description(never changes for gesture detector widget)
|--------------------------------------------------------------------------
*/

const _description = DomNodeDescription(
  attributes: {
    Attributes.classAttribute: Constants.classGestureDetector,
  },
);

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _GestureDetectorRenderObject extends RenderObject {
  final _GestureDetectorState state;

  const _GestureDetectorRenderObject({
    required BuildContext context,
    required this.state,
  }) : super(context);

  @override
  render({
    required covariant GestureDetector widget,
  }) {
    var services = ServicesRegistry.instance.getServices(context);
    var widget = services.walker.getWidgetObject(context)!.widget;

    state
      ..frameworkBindDomNode(context.findDomNode())
      ..frameworkBindWidget(widget)
      ..initState();

    return _description;
  }

  @override
  afterWidgetRebind({
    required oldWidget,
    required newWidget,
    required updateType,
  }) {
    state.frameworkRebindWidget(
      oldWidget: oldWidget,
      newWidget: newWidget,
    );
  }

  @override
  beforeUnMount() => state.frameworkDispose();
}

class _GestureDetectorState {
  Element? _domNode;
  Element get domNode => _domNode!;

  GestureDetector? _widget;
  GestureDetector get widget => _widget!;

  final _availableEventListeners = [
    DomEventType.click,
    DomEventType.doubleClick,
  ];

  void initState() {
    _refreshEventListeners(null);
  }

  void didUpdateWidget(GestureDetector oldWidget) {
    _refreshEventListeners(oldWidget);
  }

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
    var nativeType = eventType.nativeName;
    var useCapture = HitTestBehavior.opaque == widget.behaviour;

    domNode.addEventListener(nativeType, _handleNative, useCapture);
  }

  void _removeListener(DomEventType eventType) {
    var nativeType = eventType.nativeName;

    domNode.removeEventListener(nativeType, _handleNative);
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

  void dispose() {
    _removeListeners();
  }

  /*
  |--------------------------------------------------------------------------
  | for internal use
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @protected
  void frameworkBindDomNode(Element domNode) {
    _domNode = domNode;
  }

  @nonVirtual
  @protected
  void frameworkBindWidget(Widget widget) {
    _widget = widget as GestureDetector;
  }

  @nonVirtual
  @protected
  void frameworkRebindWidget({
    required Widget oldWidget,
    required Widget newWidget,
  }) {
    _widget = newWidget as GestureDetector;

    didUpdateWidget(oldWidget as GestureDetector);
  }

  @nonVirtual
  @protected
  void frameworkDispose() {
    dispose();
  }
}
