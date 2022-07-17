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

// ignore_for_file: prefer_asserts_with_message

import 'package:rad/src/include/async/connection_state.dart';
import 'package:rad/src/include/widgets/future_builder.dart';
import 'package:rad/src/include/widgets/stream_builder.dart';

/// Immutable representation of the most recent interaction with an asynchronous
/// computation.
///
/// See also:
///
///  * [StreamBuilder], which builds itself based on a snapshot from interacting
///    with a [Stream].
///  * [FutureBuilder], which builds itself based on a snapshot from interacting
///    with a [Future].
///
class AsyncSnapshot<T> {
  /// Creates an [AsyncSnapshot] with the specified [connectionState],
  /// and optionally either [data] or [error] with an optional [stackTrace]
  /// (but not both data and error).
  ///
  const AsyncSnapshot._(
    this.connectionState,
    this.data,
    this.error,
    this.stackTrace,
  )   : assert(!(data != null && error != null)),
        assert(stackTrace == null || error != null);

  /// Creates an [AsyncSnapshot] in [ConnectionState.none] with null data and
  /// error.
  ///
  const AsyncSnapshot.nothing()
      : this._(ConnectionState.none, null, null, null);

  /// Creates an [AsyncSnapshot] in [ConnectionState.waiting] with null data and
  /// error.
  ///
  const AsyncSnapshot.waiting()
      : this._(ConnectionState.waiting, null, null, null);

  /// Creates an [AsyncSnapshot] in the specified [state] and with the specified
  /// [data].
  ///
  const AsyncSnapshot.withData(ConnectionState state, T data)
      : this._(state, data, null, null);

  /// Creates an [AsyncSnapshot] in the specified [state] with the specified
  /// [error] and a [stackTrace].
  ///
  /// If no [stackTrace] is explicitly specified, [StackTrace.empty] will be
  /// used instead.
  ///
  const AsyncSnapshot.withError(
    ConnectionState state,
    Object error, [
    StackTrace stackTrace = StackTrace.empty,
  ]) : this._(state, null, error, stackTrace);

  /// Current state of connection to the asynchronous computation.
  ///
  final ConnectionState connectionState;

  /// The latest data received by the asynchronous computation.
  ///
  /// If this is non-null, [hasData] will be true.
  ///
  /// If [error] is not null, this will be null. See [hasError].
  ///
  /// If the asynchronous computation has never returned a value, this may be
  /// set to an initial data value specified by the relevant widget. See
  /// [FutureBuilder.initialData] and [StreamBuilder.initialData].
  ///
  final T? data;

  /// Returns latest data received, failing if there is no data.
  ///
  /// Throws [error], if [hasError]. Throws [StateError], if neither [hasData]
  /// nor [hasError].
  ///
  T get requireData {
    if (hasData) return data!;
    if (hasError) Error.throwWithStackTrace(error!, stackTrace!);
    throw StateError('Snapshot has neither data nor error');
  }

  /// The latest error object received by the asynchronous computation.
  ///
  /// If this is non-null, [hasError] will be true.
  ///
  /// If [data] is not null, this will be null.
  ///
  final Object? error;

  /// The latest stack trace object received by the asynchronous computation.
  ///
  /// This will not be null iff [error] is not null. Consequently, [stackTrace]
  /// will be non-null when [hasError] is true.
  ///
  /// However, even when not null, [stackTrace] might be empty. The stack trace
  /// is empty when there is an error but no stack trace has been provided.
  ///
  final StackTrace? stackTrace;

  /// Returns a snapshot like this one, but in the specified [state].
  ///
  /// The [data], [error], and [stackTrace] fields persist unmodified, even if
  /// the new state is [ConnectionState.none].
  ///
  AsyncSnapshot<T> inState(ConnectionState state) =>
      AsyncSnapshot<T>._(state, data, error, stackTrace);

  /// Returns whether this snapshot contains a non-null [data] value.
  ///
  /// This can be false even when the asynchronous computation has completed
  /// successfully, if the computation did not return a non-null value. For
  /// example, a [Future<void>] will complete with the null value even if it
  /// completes successfully.
  ///
  bool get hasData => data != null;

  /// Returns whether this snapshot contains a non-null [error] value.
  ///
  /// This is always true if the asynchronous computation's last result was
  /// failure.
  ///
  bool get hasError => error != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AsyncSnapshot<T> &&
        other.connectionState == connectionState &&
        other.data == data &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode => Object.hash(connectionState, data, error);

  @override
  toString() => '$runtimeType($connectionState, $data, $error, $stackTrace)';
}
