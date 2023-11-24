// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/widgets/abstract/widget.dart';

/// A [Key] is an identifier for [Widget]s.
///
/// Keys must be unique amongst the [Widget]s with the same parent.
///
@immutable
class Key {
  /// Create key.
  ///
  const Key(this._value);

  @override
  operator ==(Object other) {
    return other is Key && other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => 'key($_value)';

  /*
  |--------------------------------------------------------------------------
  | framework reserved api
  |--------------------------------------------------------------------------
  */

  /// Value that was used while creating the key.
  ///
  /// @nodoc
  @internal
  String get frameworkValue => _value;
  final String _value;
}
