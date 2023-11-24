// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// Browser's window mock.
///
class RT_TestWindow extends WindowDelegate {
  final logs = <String>[];
  final locationHistory = <Uri>[];

  final _history = <_HistoryEntry>[];
  final _forwardAbleHistory = <_HistoryEntry>[];

  var _location = Uri.parse(window.location.href);
  Uri get location => _location;

  final _psListeners = <String, PopStateEventCallback>{};

  void clearState() {
    logs.clear();
    locationHistory.clear();

    _history.clear();
    _forwardAbleHistory.clear();

    window.history.pushState('', '/', '/');
    _location = Uri.parse(window.location.href);
  }

  @override
  String get locationHref => _location.toString();

  @override
  String get locationHash => _location.fragment;

  @override
  String get locationPathName => _location.path;

  @override
  locationReload() => throw UnimplementedError();

  @override
  addPopStateListener({
    required rootElement,
    required callback,
  }) {
    if (!_psListeners.containsKey(rootElement.appTargetId)) {
      _psListeners[rootElement.appTargetId] = callback;
    }
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
    required rootElement,
  }) {
    _forwardAbleHistory.clear();
    setLocation(url);
  }

  @override
  historyReplaceState({
    required title,
    required url,
    required rootElement,
  }) {
    _forwardAbleHistory.clear();
    setLocation(url, replace: true);
  }

  @override
  historyBack({
    required rootElement,
  }) {
    if (_history.length < 2) {
      throw Exception('History is empty');
    }

    _forwardAbleHistory.add(_history.removeLast());

    setLocation(_history.last.url, replace: true);
    _psOnPopState(_history.last.data);
  }

  void dispatchBackAction() {
    historyBack(rootElement: RT_TestBed.rootRenderElement);
  }

  void dispatchForwardAction() {
    if (_forwardAbleHistory.isEmpty) {
      throw Exception('Forward-able History is empty');
    }

    _history.add(_forwardAbleHistory.removeLast());

    setLocation(_history.last.url, replace: true);
    _psOnPopState(_history.last.data);
  }

  void _psOnPopState(dynamic data) {
    var appTargetId = '';
    try {
      appTargetId = data;
    } finally {
      var listener = _psListeners[appTargetId];

      if (null != listener) {
        listener(PopStateEvent(''));
      }
    }
  }

  void setLocation(String location, {bool replace = false}) {
    var prevLocation = _location;
    var nextLocation = Uri.parse(location);

    if (nextLocation.isAbsolute) {
      _location = nextLocation;
    } else {
      _location = Uri(
        scheme: prevLocation.scheme,
        userInfo: prevLocation.userInfo,
        host: prevLocation.host,
        port: prevLocation.port,
        path: nextLocation.path,
        query: nextLocation.query,
        fragment: nextLocation.fragment,
      );
    }

    var historyEntry = _HistoryEntry(
      url: location,
      title: '',
      data: RT_TestBed.rootTargetId,
    );

    if (replace) {
      if (_history.isNotEmpty) {
        _history.removeLast();
      }

      if (locationHistory.isNotEmpty) {
        locationHistory.removeLast();
      }
    }

    _history.add(historyEntry);
    locationHistory.add(nextLocation);

    logs.add(
      'Set href: $locationHref, hash: $locationHash, path: $locationPathName',
    );
  }
}

class _HistoryEntry {
  final String url;
  final String title;
  final dynamic data;

  _HistoryEntry({
    required this.url,
    required this.title,
    required this.data,
  });
}
