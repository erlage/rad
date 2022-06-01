import 'dart:async';
import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';

/// Events service.
///
class EventsService extends Service {
  final EventsOptions options;

  /// App's target element.
  ///
  final Element target;

  /// Event subscriptions attached to target element.
  ///
  final _eventSubscriptions = <DomEventType, StreamSubscription<Event>>{};

  EventsService(BuildContext context, this.options)
      : target = document.getElementById(context.appTargetId)!,
        super(context);

  @override
  stopService() {
    for (final subscription in _eventSubscriptions.values) {
      subscription.cancel();
    }
  }

  /// Start event listener streams for event types.
  ///
  void setupEventListeners(Map<DomEventType, EventCallback?> eventListeners) {
    for (final eventType in eventListeners.keys) {
      // if callback is null
      if (null == eventListeners[eventType]) {
        continue;
      }

      // if already started
      if (_eventSubscriptions.containsKey(eventType)) {
        continue;
      }

      _startListeningForEventType(eventType);
    }
  }

  void _handle(Event event) {
    var target = event.target;

    var emittedEvent = EmittedEvent.fromNativeEvent(event);

    if (null != target && target is Element) {
      var closestWidgetObject = _getClosestTargetWidgetObject(target);

      if (null != closestWidgetObject) {
        _dispatch(emittedEvent, closestWidgetObject);
      }
    }
  }

  WidgetObject? _getClosestTargetWidgetObject(Element element) {
    var widgetObject = services.walker.getWidgetObjectUsingElement(element);

    if (null != widgetObject) {
      return widgetObject;
    }

    var parent = element.parent;

    if (null != parent) {
      return _getClosestTargetWidgetObject(parent);
    }

    return null;
  }

  void _dispatch(EmittedEvent event, WidgetObject widgetObject) {
    var eventType = fnMapEventTypeToDomEventType(event.type);

    if (null == eventType) {
      return;
    }

    var listeners = _collectListeners(
      widgetObject: widgetObject,
      eventType: eventType,
    );

    _dispatchEventToListeners(
      listeners: listeners,
      eventType: eventType,
      event: event,
    );
  }

  List<EventCallback> _collectListeners({
    required WidgetObject widgetObject,
    required DomEventType eventType,
  }) {
    var capturingCallbacks = <EventCallback>[];
    var bubblingCallbacks = <EventCallback>[];

    var current = widgetObject;
    while (true) {
      var curCapListeners = current.widget.widgetCaptureEventListeners;
      var curBubListeners = current.widget.widgetEventListeners;

      var curCapListener = curCapListeners[eventType];
      var curBubListener = curBubListeners[eventType];

      if (null != curCapListener) {
        capturingCallbacks.add(curCapListener);
      }

      if (null != curBubListener) {
        bubblingCallbacks.add(curBubListener);
      }

      var parentNode = current.renderNode.parent;
      if (null == parentNode || current.context.isRoot) {
        break;
      }

      var parentObject = services.walker.getWidgetObject(parentNode.context);
      if (null == parentObject) {
        break;
      }

      current = parentObject;
    }

    var callbacks = capturingCallbacks.reversed.toList();

    callbacks.addAll(bubblingCallbacks);

    return callbacks;
  }

  void _dispatchEventToListeners({
    required List<EventCallback> listeners,
    required DomEventType eventType,
    required EmittedEvent event,
  }) {
    // assume current event is not absorbable
    // absorbable event means that event will auto-stop propagating when reaches
    // a target that has a matching listener for that event

    var isEventAbsorbable = false;

    switch (eventType) {
      // these restrictions are purely framework-sided
      // we can promote below events to bubbling events anytime we want
      // maybe just to be more spec complaint

      // we should stop forwarding these events
      // if a valid listener callback got called
      case DomEventType.change:
      case DomEventType.input:
      case DomEventType.submit:
      case DomEventType.keyUp:
      case DomEventType.keyDown:
      case DomEventType.keyPress:

      // drag events

      case DomEventType.drag:
      case DomEventType.dragEnd:
      case DomEventType.dragEnter:
      case DomEventType.dragLeave:
      case DomEventType.dragOver:
      case DomEventType.dragStart:
      case DomEventType.drop:

      // mouse events

      case DomEventType.mouseDown:
      case DomEventType.mouseEnter:
      case DomEventType.mouseLeave:
      case DomEventType.mouseMove:
      case DomEventType.mouseOver:
      case DomEventType.mouseOut:
      case DomEventType.mouseUp:
        isEventAbsorbable = true;

        break;

      // we should forward these events to next elements
      // even if a valid listener callback got called

      case DomEventType.click:
      case DomEventType.doubleClick:
        isEventAbsorbable = false;

        break;
    }

    for (final listener in listeners) {
      if (isEventAbsorbable) {
        event.stopImmediatePropagation();
      }

      listener(event);

      if (event.isPropagationStopped) {
        break;
      }
    }
  }

  void _startListeningForEventType(DomEventType eventType) {
    switch (eventType) {
      case DomEventType.click:
        var sub = Element.clickEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.doubleClick:
        var sub = Element.doubleClickEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.change:
        var sub = Element.changeEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.input:
        var sub = Element.inputEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.submit:
        var sub = Element.submitEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.keyUp:
        var sub = Element.keyUpEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.keyDown:
        var sub = Element.keyDownEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.keyPress:
        var sub = Element.keyPressEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.drag:
        var sub = Element.dragEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.dragEnd:
        var sub = Element.dragEndEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.dragEnter:
        var sub = Element.dragEnterEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.dragLeave:
        var sub = Element.dragLeaveEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.dragOver:
        var sub = Element.dragOverEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.dragStart:
        var sub = Element.dragStartEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.drop:
        var sub = Element.dropEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.mouseDown:
        var sub = Element.mouseDownEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.mouseEnter:
        var sub = Element.mouseEnterEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.mouseLeave:
        var sub = Element.mouseLeaveEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.mouseMove:
        var sub = Element.mouseMoveEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.mouseOver:
        var sub = Element.mouseOverEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.mouseOut:
        var sub = Element.mouseOutEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;

      case DomEventType.mouseUp:
        var sub = Element.mouseUpEvent.forElement(target).capture(_handle);
        _eventSubscriptions[eventType] = sub;
        break;
    }
  }
}
