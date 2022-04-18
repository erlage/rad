import 'dart:html';

import 'package:rad/rad.dart';
import 'package:rad/src/core/window/abstract.dart';

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
  void addPopStateListener({
    required BuildContext context,
    required PopStateEventCallback callback,
  }) {
    if (!_psListeners.containsKey(context.appTargetKey)) {
      _psListeners[context.appTargetKey] = callback;
    }

    _psEnsureListening();
  }

  @override
  void removePopStateListener(BuildContext context) {
    if (_psListeners.containsKey(context.appTargetKey)) {
      _psListeners.remove(context.appTargetKey);
    }
  }

  @override
  void historyPushState({
    required String title,
    required String url,
    required BuildContext context,
  }) {
    window.history.pushState(context.appTargetKey, title, url);
  }

  @override
  void historyReplaceState({
    required String title,
    required String url,
    required BuildContext context,
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
