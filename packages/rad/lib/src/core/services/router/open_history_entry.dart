// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

/// A NavigatorState.open() call representation.
///
@internal
class OpenHistoryEntry {
  /// Name of the route opened.
  ///
  String name;

  /// Values passed during route open.
  ///
  Map<String, String> values;

  OpenHistoryEntry(this.name, this.values);
}
