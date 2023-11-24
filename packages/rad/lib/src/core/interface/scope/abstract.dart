// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';

/// A scope interface.
///
@internal
abstract class Scope {
  /// Nearest BuildContext.
  ///
  BuildContext get context;

  /// Rebuild scope.
  ///
  void performRebuild();

  /// Add a scope event listener.
  ///
  void addScopeEventListener(
    ScopeEventType eventType,
    ScopeEventCallback listener,
  );
}
