import 'dart:async' show StreamSubscription;

import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';
import 'package:rad/src/core/common/objects/key.dart';

/// Base class for widgets that build themselves based on interaction with
/// a specified [Stream].
///
abstract class StreamBuilderBase<T, S> extends StatefulWidget {
  /// Creates a [StreamBuilderBase] connected to the specified [stream].
  const StreamBuilderBase({Key? key, this.stream}) : super(key: key);

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null. When changed, the current summary is updated using
  /// [afterDisconnected], if the previous stream was not null, followed by
  /// [afterConnected], if the new stream is not null.
  ///
  final Stream<T>? stream;

  /// Returns the initial summary of stream interaction, typically representing
  /// the fact that no interaction has happened at all.
  ///
  /// Sub-classes must override this method to provide the initial value for
  /// the fold computation.
  ///
  S initial();

  /// Returns an updated version of the [current] summary reflecting that we
  /// are now connected to a stream.
  ///
  /// The default implementation returns [current] as is.
  ///
  S afterConnected(S current) => current;

  /// Returns an updated version of the [current] summary following a data event.
  ///
  /// Sub-classes must override this method to specify how the current summary
  /// is combined with the new data item in the fold computation.
  ///
  S afterData(S current, T data);

  /// Returns an updated version of the [current] summary following an error
  /// with a stack trace.
  ///
  /// The default implementation returns [current] as is.
  ///
  S afterError(S current, Object error, StackTrace stackTrace) => current;

  /// Returns an updated version of the [current] summary following stream
  /// termination.
  ///
  /// The default implementation returns [current] as is.
  ///
  S afterDone(S current) => current;

  /// Returns an updated version of the [current] summary reflecting that we
  /// are no longer connected to a stream.
  ///
  /// The default implementation returns [current] as is.
  ///
  S afterDisconnected(S current) => current;

  /// Returns a Widget based on the [currentSummary].
  Widget build(BuildContext context, S currentSummary);

  @override
  State<StreamBuilderBase<T, S>> createState() =>
      _StreamBuilderBaseState<T, S>();
}

/// State for [StreamBuilderBase].
class _StreamBuilderBaseState<T, S> extends State<StreamBuilderBase<T, S>> {
  StreamSubscription<T>? _subscription; // ignore: cancel_subscriptions
  late S _summary;

  @override
  void initState() {
    _summary = widget.initial();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant StreamBuilderBase<T, S> oldWidget) {
    if (oldWidget.stream != widget.stream) {
      if (_subscription != null) {
        _unsubscribe();
        _summary = widget.afterDisconnected(_summary);
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _summary);

  @override
  void dispose() {
    _unsubscribe();
  }

  void _subscribe() {
    if (widget.stream != null) {
      _subscription = widget.stream!.listen((T data) {
        setState(() {
          _summary = widget.afterData(_summary, data);
        });
      }, onError: (Object error, StackTrace stackTrace) {
        setState(() {
          _summary = widget.afterError(_summary, error, stackTrace);
        });
      }, onDone: () {
        setState(() {
          _summary = widget.afterDone(_summary);
        });
      });
      _summary = widget.afterConnected(_summary);
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }
}
