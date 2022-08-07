// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/interface/scope/abstract.dart';

/// Try getting current render scope.
///
@internal
Scope? getScope() => _currentScope;

@internal
void setScope(Scope? scope) => _currentScope = scope;

// -----------------------------------------------------------

/// Currently executing render scope.
///
Scope? _currentScope;
