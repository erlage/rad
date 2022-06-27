// Copyright 2014 The Flutter Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:async' show StreamSubscription;

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

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

  /// Returns an updated version of the [current] summary following a data event
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
      _subscription = widget.stream!.listen(
        (data) {
          setState(() {
            _summary = widget.afterData(_summary, data);
          });
        },
        onError: (error, stackTrace) {
          setState(() {
            _summary = widget.afterError(_summary, error, stackTrace);
          });
        },
        onDone: () {
          setState(() {
            _summary = widget.afterDone(_summary);
          });
        },
      );
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
