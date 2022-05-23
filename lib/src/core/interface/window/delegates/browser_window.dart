import 'dart:html';

import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/interface/window/abstract.dart';

/// A window delegate that uses browser's window object.
///
class BrowserWindow extends WindowDelegate {
  var _psIsListening = false;
  final _psListeners = <String, PopStateEventCallback>{};

  @override
  String get locationHref => window.location.href;

  @override
  String get locationHash => window.location.hash;

  @override
  String get locationPathName => window.location.pathname ?? '';

  @override
  locationReload() => window.location.reload();

  @override
  addPopStateListener({
    required context,
    required callback,
  }) {
    if (!_psListeners.containsKey(context.appTargetId)) {
      _psListeners[context.appTargetId] = callback;
    }

    _psEnsureListening();
  }

  @override
  removePopStateListener(context) {
    if (_psListeners.containsKey(context.appTargetId)) {
      _psListeners.remove(context.appTargetId);
    }
  }

  @override
  historyPushState({
    required title,
    required url,
    required context,
  }) {
    window.history.pushState(context.appTargetId, title, url);
  }

  @override
  historyReplaceState({
    required title,
    required url,
    required context,
  }) {
    window.history.replaceState(context.appTargetId, title, url);
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
