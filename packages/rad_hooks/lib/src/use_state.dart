// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/rad.dart';

/// Returns a state object whose .value property is initialized to the
/// passed argument [initialState].
///
/// During subsequent re-renders, the .value property of object will
/// always be the most recent value after applying updates.
///
UseStateHook<T> useState<T>(T initialState) {
  var useStateHook = useHook();
  useStateHook ??= setupHook(UseStateHook<T>._(initialState));

  if (useStateHook is! UseStateHook<T>) {
    throw Exception(
      'Expecting hook of type: $UseStateHook '
      'but got: ${useStateHook.runtimeType}. '
      'Please make sure your hooks call order is not dynamic.',
    );
  }

  return useStateHook;
}

/// A hook for creating stateful value.
///
/// Changing value of this hook will enqueues a re-render of the scope.
///
class UseStateHook<T> extends Hook {
  /// Current value.
  ///
  T get value => _value;
  T _value;

  set value(T value) {
    _value = value;

    performRebuild();
  }

  UseStateHook._(this._value);
}
