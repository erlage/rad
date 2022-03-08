import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/async/async_snapshot.dart';

/// Source taken from:
/// https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/async.dart

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
