// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

/// Interface for external components.
///
@internal
@immutable
abstract class AppComponent {
  /// Name of the component.
  ///
  String get name;

  /// Author name.
  ///
  String get author;

  /// Component version.
  ///
  String get version;

  @override
  toString() => '$name (v$version by $author)';
}

/// Interface for style injection.
///
@internal
@immutable
abstract class StyleComponent extends AppComponent {
  /// CSS contents to inject in DOM
  ///
  String? get styleSheetContents;
}
