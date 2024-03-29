// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import 'package:rad_test/src/imports.dart';

/// Browser's window mock.
///
class TestWindow extends WindowDelegate {
  final RootRenderElement rootElement;

  TestWindow(this.rootElement);

  final _psListeners = <String, PopStateEventCallback>{};

  var _locationHash = '';
  var _locationPathname = '';
  var _locationHref = window.location.host;
  var _host = window.location.host;
  final logs = <String>[];
  final hashStack = <String>[];
  final pathStack = <String>[];
  final hrefStack = <String>[];

  final _history = <_HistoryEntry>[];
  final _forwardAbleHistory = <_HistoryEntry>[];

  void clearState() {
    window.history.pushState('', '/', '/');

    _host = window.location.href;

    _locationHash = '';
    _locationPathname = '';
    _locationHref = window.location.href;

    _history.clear();
    _forwardAbleHistory.clear();

    logs.clear();
    hashStack.clear();
    pathStack.clear();
    hrefStack.clear();
  }

  @override
  String get locationHref => _locationHref;

  @override
  String get locationHash => _locationHash;

  @override
  String get locationPathName => _locationPathname;

  String get locationHost => _host;

  void setHref(String toSet) => _updateLocation('/$toSet');
  void setHash(String toSet) => _updateLocation('/#/$toSet');
  void setPath(String toSet) => _updateLocation('/$toSet');

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
    _forwardAbleHistory.clear();

    var entry = _HistoryEntry(
      url: url,
      title: title,
      data: rootElement.appTargetId,
    );

    _setHistoryEntry(entry);

    _history.add(entry);
  }

  @override
  historyReplaceState({
    required title,
    required url,
    required rootElement,
  }) {
    _forwardAbleHistory.clear();

    if (_history.isNotEmpty) {
      _history.removeLast();

      hashStack.removeLast();
      pathStack.removeLast();
      hrefStack.removeLast();
    }

    var entry = _HistoryEntry(
      url: url,
      title: title,
      data: rootElement.appTargetId,
    );

    _setHistoryEntry(entry);

    _history.add(entry);
  }

  @override
  historyBack({
    required rootElement,
  }) {
    if (_history.length < 2) {
      throw Exception('History is empty');
    }

    _forwardAbleHistory.add(_history.removeLast());

    hashStack.removeLast();
    pathStack.removeLast();
    hrefStack.removeLast();

    _setHistoryEntry(_history.last);

    _psOnPopState(_history.last.data);
  }

  void dispatchBackAction() {
    historyBack(rootElement: rootElement);
  }

  void dispatchForwardAction() {
    if (_forwardAbleHistory.isEmpty) {
      throw Exception('Forward-able History is empty');
    }

    _history.add(_forwardAbleHistory.removeLast());

    _setHistoryEntry(_history.last);

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

  void _setHistoryEntry(_HistoryEntry entry) {
    _updateLocation(entry.url);

    logs.add(
      'Set href: $locationHref, hash: $locationHash, path: $locationPathName',
    );

    hrefStack.add(locationHref);
    hashStack.add(locationHash);
    pathStack.add(locationPathName);
  }

  void _updateLocation(String location) {
    var pathWithHash = location.replaceAll(RegExp(r'\/\/+'), '/');

    _locationHref = '$_host/$pathWithHash'.replaceAll(RegExp(r'\/\/+'), '/');

    var split = pathWithHash.split('#');

    if (split.isNotEmpty) {
      _locationPathname = split[0];
    } else {
      _locationPathname = '';
    }

    if (split.length > 1) {
      _locationHash = '#${split[1]}';
    } else {
      _locationHash = '';
    }
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
