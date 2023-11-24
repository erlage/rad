// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

/// Description patch for a dom node.
///
@immutable
class DomNodePatch {
  /// Attributes patch.
  ///
  /// {attribute name: null/non-null value}
  ///
  /// If value for an attribute is null, framework will remove that attribute
  /// from dom else it'll add/update it.
  ///
  final Map<String, String?>? attributes;

  /// Properties patch.
  ///
  /// If value for an property is null, framework will clear that property else
  /// it'll add/update it.
  ///
  final Map<String, String?>? properties;

  const DomNodePatch({this.attributes, this.properties});
}

/// A fillable dom node patch.
///
@internal
class DomNodePatchFillable implements DomNodePatch {
  /// Attributes patch.
  ///
  @override
  final Map<String, String?> attributes;

  /// Properties patch.
  ///
  @override
  final Map<String, String?> properties;

  const DomNodePatchFillable({
    required this.attributes,
    required this.properties,
  });
}
