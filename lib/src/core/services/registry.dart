import 'package:rad/rad.dart';
import 'package:rad/src/core/foundation/walker/walker.dart';
import 'package:rad/src/core/services/debug.dart';
import 'package:rad/src/core/foundation/scheduler/scheduler.dart';

/// Global Registry.
///
class Registry {
  Registry._();
  static Registry? _instance;
  static Registry get instance => _instance ??= Registry._();

  final _treeWalkers = <String, Walker>{};
  final _taskSchedulers = <String, Scheduler>{};

  /*
  |--------------------------------------------------------------------------
  | Task scheduler related
  |--------------------------------------------------------------------------
  */

  /// Add a reference of task scheduler corresponding to app root context.
  ///
  void registerTaskScheduler(BuildContext context, Scheduler scheduler) {
    if (_taskSchedulers.containsKey(context.appTargetKey)) {
      Debug.exception(
        "A single instance of App can register only one scheduler.",
      );

      return;
    }

    _taskSchedulers[context.appTargetKey] = scheduler;
  }

  /// Find scheduler instance that's enclosing given context.
  ///
  Scheduler getTaskScheduler(BuildContext context) {
    var scheduler = _taskSchedulers[context.appTargetKey];

    if (null == scheduler) {
      Debug.exception(
        "No scheduler is registered on the provided context.",
      );

      /// Return dummy scheduler if user has registered there own error handler that
      /// doesn't throw exception onError.
      ///
      return Scheduler();
    }

    return scheduler;
  }

  /// Remove the reference of task scheduler from registered schedulers.
  ///
  void unRegisterTaskScheduler(BuildContext context) {
    _taskSchedulers.remove(context.appTargetKey);
  }

  /*
  |--------------------------------------------------------------------------
  | Tree walker related
  |--------------------------------------------------------------------------
  */

  /// Add a reference of tree walker corresponding to app root context.
  ///
  void registerTreeWalker(BuildContext context, Walker walker) {
    if (_treeWalkers.containsKey(context.appTargetKey)) {
      Debug.exception(
        "A single instance of App can register only one walker.",
      );

      return;
    }

    _treeWalkers[context.appTargetKey] = walker;
  }

  /// Find walker instance that's enclosing give context.
  ///
  Walker getTreeWalker(BuildContext context) {
    var walker = _treeWalkers[context.appTargetKey];

    if (null == walker) {
      Debug.exception(
        "No walker is registered on the provided context.",
      );

      return Walker();
    }

    return walker;
  }

  /// Remove the reference of tree walker from registered walkers.
  ///
  void unRegisterTreeWalker(BuildContext context) {
    _treeWalkers.remove(context.appTargetKey);
  }
}
