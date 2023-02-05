// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/router_render_element.dart';

/// A [RouterRenderElement.openPath] call.
///
@internal
class OpenHistoryEntry {
  /// Path of the route opened.
  ///
  String path;

  /// Values passed during route open.
  ///
  Map<String, String> values;

  OpenHistoryEntry(this.path, this.values);
}
