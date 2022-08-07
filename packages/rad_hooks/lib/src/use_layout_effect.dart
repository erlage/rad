// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_hooks/src/abstract.dart';

typedef NullableVoidCallback = VoidCallback? Function();

/// The signature is identical to useEffect, but it fires before DOM updates
/// are flushed to the DOM. At this point, DOM is still in previous state
/// (possibly stale).
///
void useLayoutEffect<T>(
  NullableVoidCallback callback, [
  List<T>? dependencies,
]) {
  var useLayoutEffectHook = useHook();
  useLayoutEffectHook ??= setupHook(UseLayoutEffectHook<T>());

  if (useLayoutEffectHook is! UseLayoutEffectHook) {
    throw Exception(
      'Expecting hook of type: $UseLayoutEffectHook '
      'but got: ${useLayoutEffectHook.runtimeType}. '
      'Please make sure your hooks call order is not dynamic.',
    );
  }

  useLayoutEffectHook
    ..updateDependencies(dependencies)
    ..updateEffectCallback(callback);
}

/// A hook for doing side effects.
///
@internal
class UseLayoutEffectHook<T> extends DependenciesDrivenHook<T> {
  @nonVirtual
  @protected
  VoidCallback? _cleanUpCallback;

  @nonVirtual
  @protected
  NullableVoidCallback? _effectCallback;

  @override
  void register() {
    addHookEventListeners({
      HookEventType.didBuildScope: runHookTasks,
      HookEventType.didRebuildScope: runHookTasks,
      HookEventType.willUnMountScope: runHookTasks,
    });
  }

  @nonVirtual
  @protected
  void runHookTasks(HookEvent event) {
    if (HookEventType.willUnMountScope == event.type) {
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
