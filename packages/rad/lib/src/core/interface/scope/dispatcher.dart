// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/interface/scope/abstract.dart';

/// Try getting current render scope.
///
@internal
Scope? getScope() => _currentScope;

/// Run a task under a provided scope interface.
///
@internal
T runScopedTask<T>(Scope scope, T Function() task) {
  var previousScope = _currentScope;
  _currentScope = scope;

  var results = task();

  _currentScope = previousScope;
  return results;
}

// -----------------------------------------------------------

/// Currently executing render scope.
///
Scope? _currentScope;
