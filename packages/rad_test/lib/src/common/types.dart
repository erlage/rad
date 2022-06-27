// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/finders.dart';
import 'package:rad_test/src/modules/testers.dart';
import 'package:rad_test/src/modules/widget_tester.dart';

/// Signature for callback to [testWidgets].
///
typedef WidgetTesterCallback = FutureOr<void> Function(
  WidgetTester widgetTester,
);

/// Signature for [CommonFinders.byWidgetPredicate].
///
typedef WidgetPredicate = bool Function(Widget widget);

/// Signature for [CommonFinders.byRenderElementPredicate].
///
typedef RenderElementPredicate = bool Function(RenderElement element);
