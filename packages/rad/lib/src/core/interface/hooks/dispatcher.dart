// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/rad.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/interface/scope/abstract.dart';
import 'package:rad/src/core/interface/scope/dispatcher.dart' as scope_unit;

/// Try fetching a registered hook at current index.
///
Hook? useHook() => _getDispatcher().useHook();

/// Create and dispatch a new hook at current index.
///
Hook setupHook(Hook hook) => _getDispatcher().createHook(hook);

// -----------------------------------------------------------

/// Get dispatcher for current scope.
///
_Dispatcher _getDispatcher() => _Dispatcher.forScope();

// We attach a dispatcher object per scope, just to simplify things a bit.

/// A hook dispatcher.
///
class _Dispatcher {
  /// Current hook index.
  ///
  var _hookIndex = -1;

  /// List of associated hooks.
  ///
  final _hooks = <Hook>[];

  /// Try fetching a existing hook.
  ///
  Hook? useHook() {
    _hookIndex++;

    if (_hooks.length > _hookIndex) {
      var existingHook = _hooks[_hookIndex];

      return existingHook;
    }

    return null;
  }

  /// Create a new hook.
  ///
  Hook createHook(Hook hook) {
    _hooks.add(hook);

    hook
      ..frameworkBindScope(_scope)
      ..frameworkInitHook();

    var listeners = hook.frameworkHookEventListeners;
    listeners.forEach(_scope.addScopeEventListener);

    // We've to manually fire willBuildScope event for hooks as call to
    // createHook is dispatched inside RenderScope's body, body that starts
    // executing after RenderScope's willBuildScope is already fired.

    var willBuildListener = listeners[HookEventType.willBuildScope];
    if (null != willBuildListener) {
      willBuildListener(const HookEvent(HookEventType.willBuildScope));
    }

    return hook;
  }

  /// Current hook scope.
  ///
  static _Dispatcher? _current;

  /// Registered dispatchers.
  ///
  static final _dispatchers = <Scope, _Dispatcher>{};

  final Scope _scope;

  _Dispatcher._(this._scope);

  /// Get dispatcher associated with current scope.
  ///
  factory _Dispatcher.forScope() {
    var scope = scope_unit.getScope();
    if (null == scope) {
      throw Exception('Please use hooks inside scope.');
    }

    var dispatcherToReturn = _dispatchers[scope];

    if (null == dispatcherToReturn) {
      var newDispatcher = _Dispatcher._(scope);
      _dispatchers[scope] = newDispatcher;

      scope.addScopeEventListener(
        ScopeEventType.willBuildScope,
        newDispatcher._resetHookIndex,
      );

      scope.addScopeEventListener(
        ScopeEventType.willRebuildScope,
        newDispatcher._resetHookIndex,
      );

      scope.addScopeEventListener(ScopeEventType.didUnMountScope, (_) {
        _dispatchers.remove(newDispatcher);
      });

      dispatcherToReturn = newDispatcher;
    }

    var currentDispatcher = _current;
    if (null != currentDispatcher && currentDispatcher != dispatcherToReturn) {
      currentDispatcher._resetHookIndex(null);
      _current = dispatcherToReturn;
    }

    return dispatcherToReturn;
  }

  void _resetHookIndex(_) => _hookIndex = -1;
}
