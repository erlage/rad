// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_registry.dart';

/// A mixin with a services resolver getter.
///
/// @nodoc
@internal
mixin ServicesResolver {
  Services? _services;

  /// @nodoc
  @internal
  Services resolveServices(BuildContext context) {
    return _services ??= ServicesRegistry.instance.getServices(context);
  }
}
