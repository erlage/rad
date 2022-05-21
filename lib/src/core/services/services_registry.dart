import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/services/debug/debug_service.dart';
import 'package:rad/src/core/services/keygen/key_gen_service.dart';
import 'package:rad/src/core/services/router/router_service.dart';
import 'package:rad/src/core/services/scheduler/scheduler_service.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/walker/walker_service.dart';

/// Services Registry.
///
class ServicesRegistry {
  ServicesRegistry._();
  static ServicesRegistry? _instance;
  static ServicesRegistry get instance => _instance ??= ServicesRegistry._();

  final _services = <String, Services>{};

  void registerServices(BuildContext context, Services services) {
    if (_services.containsKey(context.appTargetId)) {
      throw Exception('Services are already registered with the context.');
    }

    _services[context.appTargetId] = services;
  }

  void unRegisterServices(BuildContext context) {
    _services.remove(context.appTargetId);
  }

  Services getServices(BuildContext context) {
    var services = _services[context.appTargetId];

    if (null == services) {
      throw Exception('Services are not registered yet.');
    }

    return services;
  }

  // helpers

  DebugService getDebug(BuildContext context) {
    return getServices(context).debug;
  }

  KeyGenService getKeyGen(BuildContext context) {
    return getServices(context).keyGen;
  }

  RouterService getRouter(BuildContext context) {
    return getServices(context).router;
  }

  WalkerService getWalker(BuildContext context) {
    return getServices(context).walker;
  }

  SchedulerService getScheduler(BuildContext context) {
    return getServices(context).scheduler;
  }
}
