// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad_hooks/src/use_memo.dart';

/// Returns a memoized callback.
///
/// Pass an inline [callback] and an array of [dependencies]. [useCallback] will
/// return a memoized version of the callback that only changes if one of the
/// dependencies has changed.
///
T Function() useCallback<T, V>(
  T Function() callback, [
  List<V>? dependencies,
]) {
  return useMemo<T Function(), V>(() => callback, dependencies);
}
