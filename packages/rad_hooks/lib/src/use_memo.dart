// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_hooks/src/abstract.dart';
import 'package:rad_hooks/src/use_layout_effect.dart';

/// Returns a memoized value.
///
/// Pass a [create] function and an array of [dependencies]. [useMemo] will
/// only recompute the memoized value when one of the dependencies has changed.
/// This optimization helps to avoid expensive calculations on every render.
///
///
/// Remember that the function passed to [useMemo] runs during rendering. Don’t
/// do anything there that you wouldn’t normally do while rendering. For
/// example, side effects belong in [useLayoutEffect], not [useMemo].
///
///
/// If no [dependencies] provided, a new value will be computed on every render.
///
T useMemo<T, V>(
  T Function() create, [
  List<V>? dependencies,
]) {
  var useMemoHook = useHook();
  useMemoHook ??= setupHook(UseMemoHook<T, V>());

  if (useMemoHook is! UseMemoHook) {
    throw Exception(
      'Expecting hook of type: $UseMemoHook '
      'but got: ${useMemoHook.runtimeType}. '
      'Please make sure your hooks call order is not dynamic.',
    );
  }

  useMemoHook
    ..updateDependencies(dependencies)
    ..updateComputation(create);

  return useMemoHook.computationResult;
}

@internal
class UseMemoHook<T, V> extends DependenciesDrivenHook<V> {
  @nonVirtual
  @protected
  T get computationResult => _computationResult!;
  T? _computationResult;

  @nonVirtual
  @protected
  void updateComputation(T Function() computation) {
    if (null == _computationResult || super.areDependenciesChanged) {
      _computationResult = computation();
    }
  }
}
