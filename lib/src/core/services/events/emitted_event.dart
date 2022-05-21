import 'dart:html';

/// A wrapper for native-events.
///
class EmittedEvent {
  /// Native event instance.
  ///
  final Event _rawEvent;

  /// Create emitted event from native-event.
  ///
  EmittedEvent.fromNativeEvent(this._rawEvent);

  // framework specific api(s)

  var _isPropagationStopped = false;

  bool get isPropagationStopped => _isPropagationStopped;

  // native api(s)

  String get type => _rawEvent.type;

  bool? get bubbles => _rawEvent.bubbles;

  bool? get composed => _rawEvent.composed;

  num? get timeStamp => _rawEvent.timeStamp;

  int get eventPhase => _rawEvent.eventPhase;

  bool? get isTrusted => _rawEvent.isTrusted;

  bool? get cancelable => _rawEvent.cancelable;

  bool get defaultPrevented => _rawEvent.defaultPrevented;

  List<EventTarget> get path => _rawEvent.path;

  EventTarget? get target => _rawEvent.target;

  EventTarget? get currentTarget => _rawEvent.currentTarget;

  void preventDefault() => _rawEvent.preventDefault();

  List<EventTarget> composedPath() => _rawEvent.composedPath();

  void stopPropagation() {
    _isPropagationStopped = true;

    _rawEvent.stopPropagation();
  }

  void stopImmediatePropagation() {
    _isPropagationStopped = true;

    _rawEvent.stopImmediatePropagation();
  }

  @override
  String toString() => _rawEvent.toString();
}
