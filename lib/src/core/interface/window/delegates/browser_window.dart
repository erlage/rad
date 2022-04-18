import 'dart:html';

import 'package:rad/rad.dart';
import 'package:rad/src/core/interface/window/abstract.dart';

/// A window delegate that uses browser's window object.
///
class BrowserWindow extends WindowDelegate {
  var _psIsListening = false;
  final _psListeners = <String, PopStateEventCallback>{};

  @override
  get locationHref => window.location.href;

  @override
  get locationHash => window.location.hash;

  @override
  get locationPathName => window.location.pathname ?? '';

  @override
  addPopStateListener({
    required context,
    required callback,
  }) {
    if (!_psListeners.containsKey(context.appTargetKey)) {
      _psListeners[context.appTargetKey] = callback;
    }

    _psEnsureListening();
  }

  @override
  removePopStateListener(context) {
    if (_psListeners.containsKey(context.appTargetKey)) {
      _psListeners.remove(context.appTargetKey);
    }
  }

  @override
  historyPushState({
    required title,
    required url,
    required context,
  }) {
    window.history.pushState(context.appTargetKey, title, url);
  }

  @override
  historyReplaceState({
    required title,
    required url,
    required context,
  }) {
    window.history.replaceState(context.appTargetKey, title, url);
  }

  void _psEnsureListening() {
    if (_psIsListening) return;

    window.onPopState.listen(_psOnPopState);

    _psIsListening = true;
  }

  void _psOnPopState(PopStateEvent event) {
    var appTargetKey = '';
    try {
      appTargetKey = event.state;
    } finally {
      var listener = _psListeners[appTargetKey];

      if (null != listener) {
        listener(event);
      }
    }
  }
}