// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// !WARN: manually run browser_window_test.dart after updating this file.

import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/interface/window/abstract.dart';

/// A window delegate that uses browser's window object.
///
@internal
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
    required rootElement,
    required callback,
  }) {
    if (!_psListeners.containsKey(rootElement.appTargetId)) {
      _psListeners[rootElement.appTargetId] = callback;
    }

    _psEnsureListening();
  }

  @override
  removePopStateListener(rootElement) {
    if (_psListeners.containsKey(rootElement.appTargetId)) {
      _psListeners.remove(rootElement.appTargetId);
    }
  }

  @override
  historyPushState({
    required title,
    required url,
    required rootElement,
  }) {
    window.history.pushState(rootElement.appTargetId, title, url);
  }

  @override
  historyReplaceState({
    required title,
    required url,
    required rootElement,
  }) {
    window.history.replaceState(rootElement.appTargetId, title, url);
  }

  @override
  historyBack({
    required rootElement,
  }) {
    window.history.back();
  }

  void _psEnsureListening() {
    if (_psIsListening) return;

    window.onPopState.listen(_psOnPopState);

    _psIsListening = true;
  }

  void _psOnPopState(PopStateEvent event) {
    if (event.state is String) {
      var appTargetId = event.state;

      var listener = _psListeners[appTargetId];

      if (null != listener) {
        listener(event);
      }
    }
  }
}
