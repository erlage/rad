// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/widgets/navigator.dart';

/// Router request.
///
@internal
class RouterRequest {
  /// Route name.
  ///
  final String name;

  /// Values to push.
  ///
  final Map<String, String> values;

  /// Whether to update history.
  ///
  final bool updateHistory;

  /// Whether it's a state replacement request.
  ///
  final bool isReplacement;

  /// From navigator.
  ///
  final NavigatorRenderElement navigator;

  RouterRequest({
    required this.name,
    required this.values,
    required this.navigator,
    required this.updateHistory,
    required this.isReplacement,
  });
}
