// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/router_render_element.dart';
import 'package:rad/src/core/services/router/router_stack_entry.dart';

/// Router stack.
///
/// For managing page history.
///
@internal
class RouterStack {
  /// Entries on router stack.
  ///
  /// window's location => entry
  ///
  final entries = <String, RouterStackEntry>{};

  void push(RouterStackEntry entry) => entries[entry.location] = entry;

  RouterStackEntry? find(String location) => entries[location];

  /// Clean all entries of a specific Navigator.
  ///
  void remove(RouterRenderElement routerElement) {
    entries.removeWhere((loc, entry) => entry.routerElement == routerElement);
  }

  void clear() => entries.clear();
}
