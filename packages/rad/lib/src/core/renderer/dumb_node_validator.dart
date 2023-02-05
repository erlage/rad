// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';

/// A node validator that won't validate...
///
@internal
class DumbNodeValidator implements NodeValidator {
  const DumbNodeValidator();

  @override
  allowsElement(_) => true;

  @override
  allowsAttribute(_, __, ___) => true;
}
