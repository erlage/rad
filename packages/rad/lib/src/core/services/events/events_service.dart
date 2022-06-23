import 'dart:async';
import 'dart:html';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';

/// Events service.
///
class EventsService extends Service {
  final EventsOptions options;

  /// Event subscriptions attached to target dom node.
  ///
  final _eventSubscriptions = <DomEventType, StreamSubscription<Event>>{};

  EventsService(RootElement rootElement, this.options) : super(rootElement);

  @override
  void stopService() {
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
    var emittedEvent = EmittedEvent.fromNativeEvent(event);

    _dispatch(emittedEvent);
  }

  void _dispatch(EmittedEvent event) {
    var targetDomNode = event.target;

    if (null != targetDomNode && targetDomNode is Element) {
      var eventType = fnMapEventTypeToDomEventType(event.type);

      if (null == eventType) {
        return;
      }

      var listeners = _collectListeners(
        targetDomNodePath: _getDomNodePath(targetDomNode),
        eventType: eventType,
      );

      _dispatchEventToListeners(
        listeners: listeners,
        eventType: eventType,
        event: event,
      );
    }
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

      // we should forwarding below type of events to next nodes
      // in propagation chain even if a valid listener has already got called

      case DomEventType.click:
      case DomEventType.doubleClick:
        isEventAbsorbable = false;

        break;

      // we should stop forwarding below type of events
      // if a valid event listener callback already got called

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

      // these restrictions are purely framework-sided
      // we can promote below events to bubbling events anytime we want
      // maybe just to be more spec complaint

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
    var target = rootElement.domNode!;

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

  // ----------------------------------------------------------------------
  //  methods that walk both dom and render trees to collect event listeners
  // ----------------------------------------------------------------------

  List<EventCallback> _collectListeners({
    required List<int> targetDomNodePath,
    required DomEventType eventType,
  }) {
    var capturingCallbacks = <EventCallback>[];
    var bubblingCallbacks = <EventCallback>[];

    void collectEventListeners(RenderElement fromElement) {
      var capturingListeners = fromElement.widget.widgetCaptureEventListeners;
      var bubblingListeners = fromElement.widget.widgetEventListeners;

      var matchedCapturingListener = capturingListeners[eventType];
      var matchedBubblingListener = bubblingListeners[eventType];

      if (null != matchedCapturingListener) {
        capturingCallbacks.add(matchedCapturingListener);
      }

      if (null != matchedBubblingListener) {
        bubblingCallbacks.add(matchedBubblingListener);
      }
    }

    RenderElement currentElement = rootElement;

    while (targetDomNodePath.isNotEmpty) {
      var index = targetDomNodePath.removeLast();

      // we've reached to the point where user might have rendered
      // custom HTML using RawMarkUp widget or something

      if (index >= currentElement.frameworkChildElements.length) {
        break;
      }

      // else get the corresponding render element
      // and collect event listeners from that

      currentElement = currentElement.frameworkChildElements[index];
      collectEventListeners(currentElement);

      // element, from where we've just collected event listeners,
      // might don't have a dom node of its own. since our traversal is based on
      // dom-tree, we've to jump over elements that don't have corresponding
      // dom nodes.

      while (!currentElement.hasDomNode) {
        // make sure we're not running in the wild

        if (currentElement.frameworkChildElements.isEmpty) {
          break;
        }

        // render elements that don't have corresponding dom node can have
        // only one child widget.

        currentElement = currentElement.frameworkChildElements.first;
        collectEventListeners(currentElement);
      }
    }

    // place callbacks in order

    var callbacks = capturingCallbacks;

    while (bubblingCallbacks.isNotEmpty) {
      callbacks.add(bubblingCallbacks.removeLast());
    }

    return callbacks;
  }

  List<int> _getDomNodePath(Element domNode) {
    var path = <int>[];

    var previousAncestor = domNode;
    var ancestor = domNode.parent;

    while (null != ancestor && previousAncestor.id != rootElement.appTargetId) {
      path.add(ancestor.childNodes.indexOf(previousAncestor));

      previousAncestor = ancestor;
      ancestor = ancestor.parent;
    }

    return path;
  }
}
