// ignore_for_file: camel_case_types

import 'package:rad/src/core/interface/window/abstract.dart';

import '../test_imports.dart';

/// Browser's window mock.
///
class RT_TestWindow extends WindowDelegate {
  final _psListeners = <String, PopStateEventCallback>{};

  var _locationHash = '';
  var _locationPathname = '';
  var _locationHref = window.location.host;
  var _host = window.location.host;
  final logs = <String>[];

  final _history = <_HistoryEntry>[];

  void clearState() {
    window.history.pushState('', '/', '/');

    _host = window.location.href;

    _locationHash = '';
    _locationPathname = '';
    _locationHref = window.location.href;

    _history.clear();
    logs.clear();
  }

  @override
  String get locationHref => _locationHref;

  @override
  String get locationHash => _locationHash;

  @override
  String get locationPathName => _locationPathname;

  void setHref(String toSet) => _locationHref = toSet;
  void setHash(String toSet) => _locationHash = toSet;
  void setPath(String toSet) => _locationPathname = toSet;

  @override
  locationReload() => throw UnimplementedError();

  @override
  addPopStateListener({
    required context,
    required callback,
  }) {
    if (!_psListeners.containsKey(context.appTargetId)) {
      _psListeners[context.appTargetId] = callback;
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
    required context,
  }) {
    var entry = _HistoryEntry(
      url: url,
      title: title,
      data: context.appTargetId,
    );

    _setHistoryEntry(entry);

    _history.add(entry);
  }

  @override
  historyReplaceState({
    required title,
    required url,
    required context,
  }) {
    if (_history.isNotEmpty) {
      _history.removeLast();
    }

    var entry = _HistoryEntry(
      url: url,
      title: title,
      data: context.appTargetId,
    );

    _setHistoryEntry(entry);

    _history.add(entry);
  }

  @override
  historyBack({
    required context,
  }) {
    if (_history.length < 2) {
      throw Exception('History is empty');
    }

    _history.removeLast();

    _setHistoryEntry(_history.last);

    _psOnPopState(_history.last.data);
  }

  void _psOnPopState(dynamic data) {
    var appTargetKey = '';
    try {
      appTargetKey = data;
    } finally {
      var listener = _psListeners[appTargetKey];

      if (null != listener) {
        listener(PopStateEvent(''));
      }
    }
  }

  void _setHistoryEntry(_HistoryEntry entry) {
    var cleanedUrl = entry.url.replaceAll(RegExp(r'\/\/+'), '/');

    _locationHref = '$_host/$cleanedUrl'.replaceAll(RegExp(r'\/\/+'), '/');

    var split = cleanedUrl.split('#');

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
