// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/rad.dart';

import 'package:rad_hooks/src/use_state.dart';

/// [useRef] returns a mutable ref object whose .value property is
/// initialized to the passed argument [initialValue].
///
/// The returned object will persist for the full lifetime of the scope.
///
UseRefHook<T> useRef<T>(T initialValue) {
  var useRefHook = useHook();
  useRefHook ??= setupHook(UseRefHook._(initialValue));

  if (useRefHook is! UseRefHook<T>) {
    throw Exception(
      'Expecting hook of type: $UseRefHook '
      'but got: ${useRefHook.runtimeType}. '
      'Please make sure your hooks call order is not dynamic.',
    );
  }

  return useRefHook;
}

/// A hook for creating stateless value.
///
/// Unlike value of a [useState] hook, a change in value of [useRef] won't cause
/// scope re-render.
///
class UseRefHook<T> extends Hook {
  /// Current value.
  ///
  T value;

  UseRefHook._(this.value);
}
