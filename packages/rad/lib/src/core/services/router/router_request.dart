// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/router_render_element.dart';

/// Router request.
///
@internal
class RouterRequest {
  /// Route path.
  ///
  final String path;

  /// Values to push.
  ///
  final Map<String, String> values;

  /// Whether to update history.
  ///
  final bool updateHistory;

  /// Whether it's a state replacement request.
  ///
  final bool isReplacement;

  /// From [RouterRenderElement].
  ///
  final RouterRenderElement routerElement;

  RouterRequest({
    required this.path,
    required this.values,
    required this.routerElement,
    required this.updateHistory,
    required this.isReplacement,
  });
}
