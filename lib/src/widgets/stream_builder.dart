import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/async/async_snapshot.dart';
import 'package:rad/src/widgets/async/async_widget_builder.dart';
import 'package:rad/src/widgets/async/connection_state.dart';
import 'package:rad/src/widgets/async/stream_builder_base.dart';

/// Source taken from:
/// https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/async.dart

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Stream].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=MkKEWHfy99Y}
///
/// Widget rebuilding is scheduled by each interaction, using [State.setState],
/// but is otherwise decoupled from the timing of the stream. The [builder]
/// is called at the discretion of the Flutter pipeline, and will thus receive a
/// timing-dependent sub-sequence of the snapshots that represent the
/// interaction with the stream.
///
/// As an example, when interacting with a stream producing the integers
/// 0 through 9, the [builder] may be called with any ordered sub-sequence
/// of the following snapshots that includes the last one (the one with
/// ConnectionState.done):
///
/// * `AsyncSnapshot<int>.withData(ConnectionState.waiting, null)`
/// * `AsyncSnapshot<int>.withData(ConnectionState.active, 0)`
/// * `AsyncSnapshot<int>.withData(ConnectionState.active, 1)`
/// * ...
/// * `AsyncSnapshot<int>.withData(ConnectionState.active, 9)`
/// * `AsyncSnapshot<int>.withData(ConnectionState.done, 9)`
///
/// The actual sequence of invocations of the [builder] depends on the relative
/// timing of events produced by the stream and the build rate of the Flutter
/// pipeline.
///
/// Changing the [StreamBuilder] configuration to another stream during event
/// generation introduces snapshot pairs of the form:
///
/// * `AsyncSnapshot<int>.withData(ConnectionState.none, 5)`
/// * `AsyncSnapshot<int>.withData(ConnectionState.waiting, 5)`
///
/// The latter will be produced only when the new stream is non-null, and the
/// former only when the old stream is non-null.
///
/// The stream may produce errors, resulting in snapshots of the form:
///
/// * `AsyncSnapshot<int>.withError(ConnectionState.active, 'some error', someStackTrace)`
///
/// The data and error fields of snapshots produced are only changed when the
/// state is `ConnectionState.active`.
///
/// The initial snapshot data can be controlled by specifying [initialData].
/// This should be used to ensure that the first frame has the expected value,
/// as the builder will always be called before the stream listener has a chance
/// to be processed.
///
/// {@tool dartpad}
/// This sample shows a [StreamBuilder] that listens to a Stream that emits bids
/// for an auction. Every time the StreamBuilder receives a bid from the Stream,
/// it will display the price of the bid below an icon. If the Stream emits an
/// error, the error is displayed below an error icon. When the Stream finishes
/// emitting bids, the final price is displayed.
///
/// ** See code in examples/api/lib/widgets/async/stream_builder.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ValueListenableBuilder], which wraps a [ValueListenable] instead of a
///    [Stream].
///  * [StreamBuilderBase], which supports widget building based on a computation
///    that spans all interactions made with the stream.
class StreamBuilder<T> extends StreamBuilderBase<T, AsyncSnapshot<T>> {
  /// Creates a new [StreamBuilder] that builds itself based on the latest
  /// snapshot of interaction with the specified [stream] and whose build
  /// strategy is given by [builder].
  ///
  /// The [initialData] is used to create the initial snapshot.
  ///
  /// The [builder] must not be null.
  const StreamBuilder({
    String? id,
    this.initialData,
    Stream<T>? stream,
    required this.builder,
  }) : super(id: id, stream: stream);

  /// The build strategy currently used by this builder.
  ///
  /// This builder must only return a widget and should not have any side
  /// effects as it may be called multiple times.
  final AsyncWidgetBuilder<T> builder;

  /// The data that will be used to create the initial snapshot.
  ///
  /// Providing this value (presumably obtained synchronously somehow when the
  /// [Stream] was created) ensures that the first frame will show useful data.
  /// Otherwise, the first frame will be built with the value null, regardless
  /// of whether a value is available on the stream: since streams are
  /// asynchronous, no events from the stream can be obtained before the initial
  /// build.
  final T? initialData;

  @override
  AsyncSnapshot<T> initial() => initialData == null
      ? AsyncSnapshot<T>.nothing()
      : AsyncSnapshot<T>.withData(ConnectionState.none, initialData as T);

  @override
  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.waiting);

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    return AsyncSnapshot<T>.withData(ConnectionState.active, data);
  }

  @override
  AsyncSnapshot<T> afterError(
      AsyncSnapshot<T> current, Object error, StackTrace stackTrace) {
    return AsyncSnapshot<T>.withError(
        ConnectionState.active, error, stackTrace);
  }

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.done);

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.none);

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> currentSummary) =>
      builder(context, currentSummary);
}
