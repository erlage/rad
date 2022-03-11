import 'package:rad/src/include/async/async_snapshot.dart';
import 'package:rad/src/include/async/async_widget_builder.dart';
import 'package:rad/src/include/async/connection_state.dart';
import 'package:rad/src/widgets/stateful_widget.dart';
import 'package:rad/src/include/widgets/stream_builder.dart';

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Future].
///
/// ## Builder contract
///
/// For a future that completes successfully with data, assuming [initialData]
/// is null, the [builder] will be called with either both or only the latter of
/// the following snapshots:
///
/// * `AsyncSnapshot<String>.withData(ConnectionState.waiting, null)`
/// * `AsyncSnapshot<String>.withData(ConnectionState.done, 'some data')`
///
/// If that same future instead completed with an error, the [builder] would be
/// called with either both or only the latter of:
///
/// * `AsyncSnapshot<String>.withData(ConnectionState.waiting, null)`
/// * `AsyncSnapshot<String>.withError(ConnectionState.done, 'some error', someStackTrace)`
///
/// The initial snapshot data can be controlled by specifying [initialData]. You
/// would use this facility to ensure that if the [builder] is invoked before
/// the future completes, the snapshot carries data of your choice rather than
/// the default null value.
///
/// The data and error fields of the snapshot change only as the connection
/// state field transitions from `waiting` to `done`, and they will be retained
/// when changing the [FutureBuilder] configuration to another future. If the
/// old future has already completed successfully with data as above, changing
/// configuration to a new future results in snapshot pairs of the form:
///
/// * `AsyncSnapshot<String>.withData(ConnectionState.none, 'data of first future')`
/// * `AsyncSnapshot<String>.withData(ConnectionState.waiting, 'data of second future')`
///
/// In general, the latter will be produced only when the new future is
/// non-null, and the former only when the old future is non-null.
///
/// A [FutureBuilder] behaves identically to a [StreamBuilder] configured with
/// `future?.asStream()`, except that snapshots with `ConnectionState.active`
/// may appear for the latter, depending on how the stream is implemented.
///
class FutureBuilder<T> extends StatefulWidget {
  /// Creates a widget that builds itself based on the latest snapshot of
  /// interaction with a [Future].
  ///
  /// The [builder] must not be null.
  const FutureBuilder({
    String? key,
    this.future,
    this.initialData,
    required this.builder,
  }) : super(key: key);

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null.
  ///
  /// If no future has yet completed, including in the case where [future] is
  /// null, the data provided to the [builder] will be set to [initialData].
  final Future<T>? future;

  /// The build strategy currently used by this builder.
  ///
  /// The builder is provided with an [AsyncSnapshot] object whose
  /// [AsyncSnapshot.connectionState] property will be one of the following
  /// values:
  ///
  ///  * [ConnectionState.none]: [future] is null. The [AsyncSnapshot.data] will
  ///    be set to [initialData], unless a future has previously completed, in
  ///    which case the previous result persists.
  ///
  ///  * [ConnectionState.waiting]: [future] is not null, but has not yet
  ///    completed. The [AsyncSnapshot.data] will be set to [initialData],
  ///    unless a future has previously completed, in which case the previous
  ///    result persists.
  ///
  ///  * [ConnectionState.done]: [future] is not null, and has completed. If the
  ///    future completed successfully, the [AsyncSnapshot.data] will be set to
  ///    the value to which the future completed. If it completed with an error,
  ///    [AsyncSnapshot.hasError] will be true and [AsyncSnapshot.error] will be
  ///    set to the error object.
  ///
  /// This builder must only return a widget and should not have any side
  /// effects as it may be called multiple times.
  final AsyncWidgetBuilder<T> builder;

  /// The data that will be used to create the snapshots provided until a
  /// non-null [future] has completed.
  ///
  /// If the future completes with an error, the data in the [AsyncSnapshot]
  /// provided to the [builder] will become null, regardless of [initialData].
  /// (The error itself will be available in [AsyncSnapshot.error], and
  /// [AsyncSnapshot.hasError] will be true.)
  final T? initialData;

  /// Whether the latest error received by the asynchronous computation should
  /// be rethrown or swallowed. This property is useful for debugging purposes.
  ///
  /// When set to true, will rethrow the latest error only in debug mode.
  ///
  /// Defaults to `false`, resulting in swallowing of errors.
  static bool debugRethrowError = false;

  @override
  State<FutureBuilder<T>> createState() => _FutureBuilderState<T>();
}

/// State for [FutureBuilder].
class _FutureBuilderState<T> extends State<FutureBuilder<T>> {
  /// An object that identifies the currently active callbacks. Used to avoid
  /// calling setState from stale callbacks, e.g. after disposal of this state,
  /// or after widget reconfiguration to a new Future.
  Object? _activeCallbackIdentity;
  late AsyncSnapshot<T> _snapshot;

  @override
  void initState() {
    _snapshot = widget.initialData == null
        ? AsyncSnapshot<T>.nothing()
        : AsyncSnapshot<T>.withData(
            ConnectionState.none, widget.initialData as T);

    _subscribe();
  }

  @override
  void didUpdateWidget(FutureBuilder<T> oldWidget) {
    if (oldWidget.future != widget.future) {
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _snapshot = _snapshot.inState(ConnectionState.none);
      }

      _subscribe();
    }
  }

  @override
  build(context) => widget.builder(context, _snapshot);

  @override
  void dispose() => _unsubscribe();

  void _subscribe() {
    if (widget.future != null) {
      final Object callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      widget.future!.then<void>((T data) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
          });
        }
      }, onError: (Object error, StackTrace stackTrace) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withError(
                ConnectionState.done, error, stackTrace);
          });
        }
        assert(() {
          if (FutureBuilder.debugRethrowError) {
            Future<Object>.error(error, stackTrace);
          }
          return true;
        }());
      });
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
