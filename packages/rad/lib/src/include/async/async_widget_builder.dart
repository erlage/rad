// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/include/async/async_snapshot.dart';
import 'package:rad/src/include/widgets/future_builder.dart';
import 'package:rad/src/include/widgets/stream_builder.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Signature for strategies that build widgets based on asynchronous
/// interaction.
///
/// See also:
///
///  * [StreamBuilder], which delegates to an [AsyncWidgetBuilder] to build
///    itself based on a snapshot from interacting with a [Stream].
///  * [FutureBuilder], which delegates to an [AsyncWidgetBuilder] to build
///    itself based on a snapshot from interacting with a [Future].
///
typedef AsyncWidgetBuilder<T> = Widget Function(
  BuildContext context,
  AsyncSnapshot<T> snapshot,
);
