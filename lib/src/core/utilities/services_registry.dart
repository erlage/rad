import 'package:rad/rad.dart';
import 'package:rad/src/core/foundation/services.dart';
import 'package:rad/src/core/foundation/walker/walker.dart';
import 'package:rad/src/core/utilities/debug.dart';
import 'package:rad/src/core/foundation/scheduler/scheduler.dart';

/// Services Registry.
///
/// It registers important services that framework is offering to external
/// components such as widgets.
///
class ServicesRegistry {
  ServicesRegistry._();
  static ServicesRegistry? _instance;
  static ServicesRegistry get instance => _instance ??= ServicesRegistry._();

  final _services = <String, Services>{};

  /// Register framework services object.
  ///
  void registerServices(BuildContext context, Services services) {
    if (_services.containsKey(context.appTargetKey)) {
      Debug.exception("Services are already registered with the context.");

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
    return getServices(context).scheduler;
  }

  /// Find walker instance that's enclosing give context.
  ///
  Walker getTreeWalker(BuildContext context) => getServices(context).walker;

  /// Find services instance that's enclosing give context.
  ///
  Services getServices(BuildContext context) {
    var services = _services[context.appTargetKey];

    if (null == services) {
      Debug.exception("Services are not registered yet.");

      return Services();
    }

    return services;
  }
}
