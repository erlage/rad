import 'dart:async';
import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';

/// Events service.
///
class EventsService extends Service {
  final EventsOptions options;

  final _eventSubscriptions = <StreamSubscription<Event>>[];

  EventsService(BuildContext context, this.options) : super(context);

  @override
  startService() {
    var rootElement = document.getElementById(rootContext.appTargetId);

    if (null != rootElement) {
      _eventSubscriptions.addAll([
        rootElement.onClick.listen(_handle),
        rootElement.onInput.listen(_handle),
        rootElement.onChange.listen(_handle),
        rootElement.onSubmit.listen(_handle),
        rootElement.onKeyUp.listen(_handle),
        rootElement.onKeyDown.listen(_handle),
        rootElement.onKeyPress.listen(_handle),
      ]);
    }
  }

  @override
  stopService() {
    while (_eventSubscriptions.isNotEmpty) {
      _eventSubscriptions.removeLast().cancel();
    }
  }

  void _handle(Event event) {
    var target = event.target;

    var emittedEvent = EmittedEvent.fromNativeEvent(event);

    if (null != target && target is Element) {
      _dispatch(emittedEvent, _getWidgetObjectForDispatch(target));
    }
  }

  WidgetObject? _getWidgetObjectForDispatch(Element element) {
    var widgetObject = services.walker.getWidgetObjectUsingElement(element);

    if (null != widgetObject) {
      return widgetObject;
    }

    var parent = element.parent;

    if (null != parent) {
      return _getWidgetObjectForDispatch(parent);
    }

    return null;
  }

  void _dispatch(EmittedEvent event, WidgetObject? widgetObject) {
    if (null == widgetObject) {
      return;
    }

    var eventType = fnMapEventTypeToDomEventType(event.type);
    var listener = widgetObject.widget.widgetEventListeners[eventType];

    // assume event is not absorbed yet
    var isEventAbsorbed = false;

    if (null != listener) {
      listener(event);

      switch (eventType) {

        // these events should not propagate to parents
        // if target is listening for them
        case DomEventType.change:
        case DomEventType.input:
        case DomEventType.submit:
        case DomEventType.keyUp:
        case DomEventType.keyDown:
        case DomEventType.keyPress:
          isEventAbsorbed = true;

          break;

        // these events should propagate to parents
        // even if target is listening for them
        case DomEventType.click:
        case null:
          isEventAbsorbed = false;

          break;
      }
    }

    var isBubbling = null != event.bubbles && event.bubbles!;

    // if bubbling and propagation isn't stopped

    if (isBubbling && !isEventAbsorbed && !event.isPropagationStopped) {
      var parentNode = widgetObject.renderNode.parent;

      if (!widgetObject.context.isRoot && null != parentNode) {
        _dispatch(event, services.walker.getWidgetObject(parentNode.context));
      }
    }
  }
}
