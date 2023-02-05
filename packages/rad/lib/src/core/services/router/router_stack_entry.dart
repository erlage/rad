// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/router_render_element.dart';

/// A entry on Router stack.
///
@internal
class RouterStackEntry {
  /// Route path.
  ///
  final String path;

  /// Values pushed.
  ///
  final Map<String, String> values;

  /// Entry location.
  ///
  final String location;

  /// [RouterRenderElement] that pushed the entry.
  ///
  final RouterRenderElement routerElement;

  RouterStackEntry({
    required this.path,
    required this.values,
    required this.routerElement,
    required this.location,
  });
}
