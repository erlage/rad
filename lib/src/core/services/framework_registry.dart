import 'package:rad/rad.dart';
import 'package:rad/src/core/foundation/common/framework_services.dart';
import 'package:rad/src/core/foundation/walker/walker.dart';
import 'package:rad/src/core/services/debug.dart';
import 'package:rad/src/core/foundation/scheduler/scheduler.dart';

/// Framework Registry.
///
/// It registers important services that framework is offering to external
/// components such as widgets.
///
class FrameworkRegistry {
  FrameworkRegistry._();
  static FrameworkRegistry? _instance;
  static FrameworkRegistry get instance => _instance ??= FrameworkRegistry._();

  final _services = <String, FrameworkServices>{};

  /// Register framework services object.
  ///
  void registerServices(BuildContext context, FrameworkServices services) {
    if (_services.containsKey(context.appTargetKey)) {
      Debug.exception("Framework has already registered its services.");

      return;
    }

    _services[context.appTargetKey] = services;
  }

  /// Unregister services registered by the framework.
  ///
  void unRegisterServices(BuildContext context) {
    _services.remove(context.appTargetKey);
  }

  /// Find framework services from registered services.
  ///
  Scheduler getTaskScheduler(BuildContext context) {
    var services = _services[context.appTargetKey];

    if (null == services) {
      Debug.exception("Services are not registered yet.");

      /// Return dummy scheduler if user has registered there own error handler that
      /// doesn't throw exception onError.
      ///
      return Scheduler();
    }

    return services.scheduler;
  }

  /// Find walker instance that's enclosing give context.
  ///
  Walker getTreeWalker(BuildContext context) {
    var services = _services[context.appTargetKey];

    if (null == services) {
      Debug.exception("Services are not registered yet.");

      return Walker();
    }

    return services.walker;
  }
}
