// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/hook.dart';
import 'package:rad/src/core/interface/hooks/dispatcher.dart';

/// Returns nearest [BuildContext].
///
BuildContext useContext() {
  var useContextHook = useHook();
  useContextHook ??= setupHook(_UseContextHook());

  if (useContextHook is! _UseContextHook) {
    throw Exception(
      'Expecting hook of type: $_UseContextHook '
      'but got: ${useContextHook.runtimeType}. '
      'Please make sure your hooks call order is not dynamic.',
    );
  }

  return useContextHook.context!;
}

/// A hook for getting nearest context.
///
class _UseContextHook extends Hook {}
