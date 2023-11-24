// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_hooks/src/abstract.dart';

typedef NullableVoidCallback = VoidCallback? Function();

/// Accepts a function that contains imperative, possibly effect-full code.
///
/// Mutations, subscriptions, timers, logging, and other side effects are not
/// allowed inside the main body of a function widget (referred to as Rad's
/// render phase). Doing so will lead to confusing bugs and inconsistencies in
/// the UI.
///
/// By default, effects run after every completed render, but you can choose to
/// fire them only when certain values have changed.
///
/// ### Cleaning up an effect
///
/// Often, effects create resources that need to be cleaned up before the scope
/// leaves the screen, such as a subscription or timer ID. To do this, the
/// function passed to [useEffect] can return a clean-up function.
///
/// The clean-up function runs after the scope is removed from the UI to
/// prevent memory leaks. Additionally, if scope renders multiple times
/// (as they typically do), the previous effect is cleaned up before executing
/// the next effect.
///
void useEffect<T>(
  NullableVoidCallback callback, [
  List<T>? dependencies,
]) {
  var useEffectHook = useHook();
  useEffectHook ??= setupHook(_UseEffectHook<T>());

  if (useEffectHook is! _UseEffectHook) {
    throw Exception(
      'Expecting hook of type: $_UseEffectHook '
      'but got: ${useEffectHook.runtimeType}. '
      'Please make sure your hooks call order is not dynamic.',
    );
  }

  useEffectHook
    ..updateDependencies(dependencies)
    ..updateEffectCallback(callback);
}

/// A hook for doing side effects.
///
class _UseEffectHook<T> extends DependenciesDrivenHook<T> {
  @nonVirtual
  @protected
  VoidCallback? _cleanUpCallback;

  @nonVirtual
  @protected
  NullableVoidCallback? _effectCallback;

  @override
  void register() {
    addHookEventListeners({
      HookEventType.didRenderScope: runHookTasks,
      HookEventType.didUpdateScope: runHookTasks,
      HookEventType.didUnMountScope: runHookTasks,
    });
  }

  @nonVirtual
  @protected
  void runHookTasks(HookEvent event) {
    if (HookEventType.didUnMountScope == event.type) {
      runHookCleanUpTasks();

      return;
    }

    if (super.areDependenciesChanged) {
      runHookCleanUpTasks();
      runHookEffectTasks();
    }
  }

  @nonVirtual
  @protected
  void updateEffectCallback(NullableVoidCallback effectCallback) {
    _effectCallback = effectCallback;
  }

  @nonVirtual
  @protected
  void runHookEffectTasks() {
    _cleanUpCallback = _effectCallback!();
  }

  @nonVirtual
  @protected
  void runHookCleanUpTasks() {
    var cleanUpCallback = _cleanUpCallback;
    if (null != cleanUpCallback) {
      cleanUpCallback();
    }
  }
}
