// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';

/// A Scope event.
///
@internal
class ScopeEvent {
  /// Type of scope event.
  ///
  final ScopeEventType type;

  /// Create scope event.
  ///
  @internal
  const ScopeEvent(this.type);
}
