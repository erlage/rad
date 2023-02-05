// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/scope_event.dart';
import 'package:rad/src/widgets/render_scope.dart';

/// A scope for using hooks.
///
typedef HookScope = RenderScope;

/// A hook event.
///
typedef HookEvent = ScopeEvent;

/// Type of hook event.
///
typedef HookEventType = ScopeEventType;

/// A hook event callback.
///
typedef HookEventCallback = void Function(HookEvent event);
