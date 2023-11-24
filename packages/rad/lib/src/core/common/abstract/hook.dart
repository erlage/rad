// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/interface/hooks/types.dart';
import 'package:rad/src/core/interface/scope/abstract.dart';

/// Base class for hooks.
///
abstract class Hook {
  /// Get context from associated scope.
  ///
  @nonVirtual
  BuildContext? get context => _scope?.context;

  /// Register hook.
  ///
  /// It's safe to use [addHookEventListeners] in this method for registering
  /// hook event listeners.
  ///
  void register() {}

  /// Tells framework to rebuild the hook's scope.
  ///
  /// There are couple of things to note while performing rebuilds:
  ///
  /// - A call to [performRebuild] will enqueue a render request which
  ///   framework can decide to process at a later stage so hooks should not
  ///   depend on the expected results of re-render request.
  ///
  /// - A call to [performRebuild] before or inside [register] is an error.
  ///
  @protected
  @nonVirtual
  void performRebuild() => _scope!.performRebuild();

  /// Register hook's scope event listeners.
  ///
  @protected
  @nonVirtual
  void addHookEventListeners(
    Map<HookEventType, HookEventCallback> listeners,
  ) {
    assert(
      _isInRegisterPhase,
      'Please use addHookEventListeners only once inside register()',
    );
    _isInRegisterPhase = false;

    frameworkAddHookEventListeners(listeners);
  }

  /*
  |--------------------------------------------------------------------------
  | framework reserved
  |--------------------------------------------------------------------------
  */

  /// Associated scope.
  ///
  Scope? _scope;

  /// Whether execution of register is pending.
  ///
  var _isInRegisterPhase = true;

  /// Scope event listeners.
  ///
  var _eventListeners = const <HookEventType, HookEventCallback>{};

  /// @nodoc
  @internal
  @nonVirtual
  Map<HookEventType, HookEventCallback> get frameworkHookEventListeners {
    return _eventListeners;
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAddHookEventListeners(
    Map<HookEventType, HookEventCallback> listeners,
  ) {
    _eventListeners = listeners;
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkBindScope(Scope scope) {
    assert(null == _scope, 'Scope is already bound');
    _scope = scope;
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkInitHook() {
    register();
    _isInRegisterPhase = false;
  }
}
