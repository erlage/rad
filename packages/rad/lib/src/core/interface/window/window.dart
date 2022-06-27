// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/interface/window/abstract.dart';

/// Window interface.
///
class Window {
  Window._();
  static Window? _instance;
  static Window get instance => _instance ??= Window._();

  WindowDelegate? _delegate;
  static WindowDelegate get delegate => instance._delegate!;

  /// Bind delegate for window.
  ///
  void bindDelegate(WindowDelegate delegate) => _delegate = delegate;
}
