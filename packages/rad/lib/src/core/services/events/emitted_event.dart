// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

/// A wrapper for native-events.
///
class EmittedEvent {
  /// Native event instance.
  ///
  Event get nativeEvent => _nativeEvent;
  final Event _nativeEvent;

  /// Create emitted event from native-event.
  ///
  EmittedEvent.fromNativeEvent(this._nativeEvent);

  // framework specific api(s)

  var _isPropagationStopped = false;

  bool get isPropagationStopped => _isPropagationStopped;

  /// Events such as 'change' are immediately stopped after they reach a target
  /// that is listening for those events. Calling this method on event will
  /// force the framework to re-start propagation of that event.
  ///
  void restartPropagationIfStopped() {
    _isPropagationStopped = false;
  }

  // native api(s)

  String get type => _nativeEvent.type;

  bool? get bubbles => _nativeEvent.bubbles;

  bool? get composed => _nativeEvent.composed;

  num? get timeStamp => _nativeEvent.timeStamp;

  int get eventPhase => _nativeEvent.eventPhase;

  bool? get isTrusted => _nativeEvent.isTrusted;

  bool? get cancelable => _nativeEvent.cancelable;

  bool get defaultPrevented => _nativeEvent.defaultPrevented;

  List<EventTarget> get path => _nativeEvent.path;

  EventTarget? get target => _nativeEvent.target;

  EventTarget? get currentTarget => _nativeEvent.currentTarget;

  void preventDefault() => _nativeEvent.preventDefault();

  List<EventTarget> composedPath() => _nativeEvent.composedPath();

  void stopPropagation() {
    _isPropagationStopped = true;

    _nativeEvent.stopPropagation();
  }

  void stopImmediatePropagation() {
    _isPropagationStopped = true;

    _nativeEvent.stopImmediatePropagation();
  }
}
