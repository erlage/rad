import 'dart:async';
import 'dart:html';

import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Events service.
///
class EventsService extends Service {
  final EventsOptions options;

  final _eventSubscriptions = <StreamSubscription>[];

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

    if (null != target && target is Element) {
      _dispatch(event, _getWidgetObjectForDispatch(target));
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

  void _dispatch(Event event, WidgetObject? widgetObject) {
    if (null == widgetObject) {
      return;
    }

    var eventType = fnMapEventTypeToDomEventType(event.type);

    var listener = widgetObject.widget.widgetEventListeners[eventType];

    if (null != listener) {
      listener(event);
    }

    var isBubbling = null != event.bubbles && event.bubbles!;

    // if bubbling isn't stopped

    if (isBubbling) {
      var parentNode = widgetObject.renderNode.parent;

      if (!widgetObject.context.isRoot && null != parentNode) {
        _dispatch(event, services.walker.getWidgetObject(parentNode.context));
      }
    }
  }
}
