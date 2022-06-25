// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/types.dart';

/// A simple job queue that stack jobs and callbacks.
///
/// Jobs and PostCallbacks are dispatched in FIFO order.
///
@internal
class JobQueue {
  final _jobs = <VoidCallback>[];
  final _postJobCallbacks = <VoidCallback>[];

  var _isLocked = false;

  void addJob(VoidCallback job) {
    assert(!_isLocked, 'JobQueue is already locked');

    _jobs.add(job);
  }

  void addPostDispatchCallback(VoidCallback callback) {
    _postJobCallbacks.add(callback);
  }

  /// Dispatch all jobs.
  ///
  void dispatchJobs() {
    _isLocked = true;

    try {
      for (final job in _jobs) {
        job();
      }
    } finally {
      _jobs.clear();

      try {
        for (final callback in _postJobCallbacks) {
          callback();
        }
      } finally {
        _postJobCallbacks.clear();
      }
    }
  }
}
