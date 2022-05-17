import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/services/walker/walker.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget_with_event_listeners.dart';

/// Event handler utility for [RenderObject]s that want to support event
/// handling.
///
@immutable
class EventHandler {
  final BuildContext context;

  const EventHandler(this.context);

  /*
  |--------------------------------------------------------------------------
  | getters
  |--------------------------------------------------------------------------
  */

  Walker get walker => ServicesRegistry.instance.getWalker(context);

  /*
  |--------------------------------------------------------------------------
  | event dispatcher
  |--------------------------------------------------------------------------
  */

  void _dispatchEvent(Event event) {
    var widget = walker.getWidgetObject(context)?.widget;

    if (widget is WidgetWithEventListeners) {
      EventCallback? eventCallback;

      switch (fnMapEventTypeToDomEventType(event.type)) {
        case DomEventType.input:
          eventCallback = widget.onInputEventListener;

          break;

        case DomEventType.change:
          eventCallback = widget.onChangeEventListener;

          break;

        case DomEventType.submit:
          eventCallback = widget.onSubmitEventListener;

          break;

        case DomEventType.click:
          eventCallback = widget.onClickEventListener;

          break;

        case null:
          break;
      }

      if (null != eventCallback) {
        eventCallback(event);
      }
    }
  }

  /*
  |--------------------------------------------------------------------------
  | helpers
  |--------------------------------------------------------------------------
  */

  /// Return list of event listeners to be added on the element.
  ///
  Map<DomEventType, EventCallback> prepareEventListenersToAdd({
    required EventListenersConfiguration newConfiguration,
    EventListenersConfiguration? oldConfiguration,
  }) {
    var eventListenersToAdd = <DomEventType, EventCallback>{};

    var newCallbacks = {
      DomEventType.change: newConfiguration.onInputEventListener,
      DomEventType.input: newConfiguration.onChangeEventListener,
      DomEventType.submit: newConfiguration.onSubmitEventListener,
      DomEventType.click: newConfiguration.onClickEventListener,
    };

    if (null == oldConfiguration) {
      for (var domEventType in newCallbacks.keys) {
        if (null != newCallbacks[domEventType]) {
          eventListenersToAdd[domEventType] = _dispatchEvent;
        }
      }

      return eventListenersToAdd;
    }

    var oldCallbacks = {
      DomEventType.change: oldConfiguration.onInputEventListener,
      DomEventType.input: oldConfiguration.onChangeEventListener,
      DomEventType.submit: oldConfiguration.onSubmitEventListener,
      DomEventType.click: oldConfiguration.onClickEventListener,
    };

    for (var domEventType in newCallbacks.keys) {
      if (null != newCallbacks[domEventType]) {
        if (null == oldCallbacks[domEventType]) {
          eventListenersToAdd[domEventType] = _dispatchEvent;
        }
      }
    }

    return eventListenersToAdd;
  }

  /// Return list of event listeners to be removed from the element.
  ///
  Map<DomEventType, EventCallback> prepareEventListenersToRemove({
    required EventListenersConfiguration newConfiguration,
    required EventListenersConfiguration oldConfiguration,
  }) {
    var eventListenersToRemove = <DomEventType, EventCallback>{};

    var newCallbacks = {
      DomEventType.change: newConfiguration.onInputEventListener,
      DomEventType.input: newConfiguration.onChangeEventListener,
      DomEventType.submit: newConfiguration.onSubmitEventListener,
      DomEventType.click: newConfiguration.onClickEventListener,
    };

    var oldCallbacks = {
      DomEventType.change: oldConfiguration.onInputEventListener,
      DomEventType.input: oldConfiguration.onChangeEventListener,
      DomEventType.submit: oldConfiguration.onSubmitEventListener,
      DomEventType.click: oldConfiguration.onClickEventListener,
    };

    for (var domEventType in oldCallbacks.keys) {
      if (null != oldCallbacks[domEventType]) {
        if (null == newCallbacks[domEventType]) {
          eventListenersToRemove[domEventType] = _dispatchEvent;
        }
      }
    }

    return eventListenersToRemove;
  }
}
