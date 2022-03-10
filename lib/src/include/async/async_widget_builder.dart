import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/include/async/async_snapshot.dart';
import 'package:rad/src/include/widgets/future_builder.dart';
import 'package:rad/src/include/widgets/stream_builder.dart';

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
