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
// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/include/async/async_snapshot.dart';
import 'package:rad/src/include/async/async_widget_builder.dart';
import 'package:rad/src/include/async/connection_state.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Future].
///
class FutureBuilder<T> extends StatefulWidget {
  /// Creates a widget that builds itself based on the latest snapshot of
  /// interaction with a [Future].
  ///
  /// The [builder] must not be null.
  ///
  const FutureBuilder({
    Key? key,
    this.future,
    this.initialData,
    required this.builder,
  }) : super(key: key);

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null.
  ///
  /// If no future has yet completed, including in the case where [future] is
  /// null, the data provided to the [builder] will be set to [initialData].
  ///
  final Future<T>? future;

  final AsyncWidgetBuilder<T> builder;

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
  Object? _activeCallbackIdentity;
  late AsyncSnapshot<T> _snapshot;

  @override
  void initState() {
    _snapshot = widget.initialData == null
        ? AsyncSnapshot<T>.nothing()
        : AsyncSnapshot<T>.withData(
            ConnectionState.none,
            widget.initialData as T,
          );

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
      widget.future!.then<void>(
        (data) {
          if (_activeCallbackIdentity == callbackIdentity) {
            setState(() {
              _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
            });
          }
        },
        onError: (error, stackTrace) {
          if (_activeCallbackIdentity == callbackIdentity) {
            setState(() {
              _snapshot = AsyncSnapshot<T>.withError(
                ConnectionState.done,
                error,
                stackTrace,
              );
            });
          }
          assert(
            () {
              if (FutureBuilder.debugRethrowError) {
                Future<Object>.error(error, stackTrace);
              }
              return true;
            }(),
          );
        },
      );
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
