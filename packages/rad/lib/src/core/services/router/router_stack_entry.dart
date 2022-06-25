// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/widgets/navigator.dart';

/// A entry on Router stack.
///
@internal
class RouterStackEntry {
  /// Route name.
  ///
  final String name;

  /// Values pushed.
  ///
  final Map<String, String> values;

  /// Entry location.
  ///
  final String location;

  /// Navigator that pushed the entry.
  ///
  final NavigatorRenderElement navigator;

  RouterStackEntry({
    required this.name,
    required this.values,
    required this.navigator,
    required this.location,
  });
}
