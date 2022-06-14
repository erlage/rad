import 'package:rad/src/core/common/types.dart';

/// A simple job queue that stack jobs and callbacks.
///
/// Jobs and PostCallbacks are dispatched in FIFO order.
///
class JobQueue {
  final _jobs = <Callback>[];
  final _postJobCallbacks = <Callback>[];

  var _isLocked = false;

  void addJob(Callback job) {
    assert(!_isLocked, 'JobQueue is already locked');

    _jobs.add(job);
  }

  void addPostDispatchCallback(Callback callback) {
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
