// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/interface/components/abstract.dart';
import 'package:rad/src/css/main.generated.dart';

/// Framework CSS styles.
///
@internal
class RadStylesComponent extends StyleComponent {
  @override
  String get name => 'Rad framework default styles';

  @override
  String get author => 'rad-core';

  @override
  String get version => '0.8.0';

  @override
  String? get styleSheetContents => GEN_STYLES_MAIN_CSS;
}
