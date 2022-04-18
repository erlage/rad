import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/services/debug/debug.dart';
import 'package:rad/src/core/services/keygen/keygen.dart';
import 'package:rad/src/core/services/router/router.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/walker/walker.dart';
import 'package:rad/src/core/services/scheduler/scheduler.dart';

/// Services Registry registers services offered by the framework.
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
      throw "Services are already registered with the context.";
    }

    _services[context.appTargetKey] = services;
  }

  /// Unregister services registered by the framework.
  ///
  void unRegisterServices(BuildContext context) {
    _services.remove(context.appTargetKey);
  }

  /// Find debug service from registered services.
  ///
  Debug getDebug(BuildContext context) => getServices(context).debug;

  /// Find key genertor service from registered services.
  ///
  KeyGen getKeyGen(BuildContext context) => getServices(context).keyGen;

  /// Find router service from registered services.
  ///
  Router getRouter(BuildContext context) {
    return getServices(context).router;
  }

  /// Find scheduler service from registered services.
  ///
  Scheduler getScheduler(BuildContext context) {
    return getServices(context).scheduler;
  }

  /// Find walker service from registered services.
  ///
  Walker getWalker(BuildContext context) => getServices(context).walker;

  /// Find services instance that's enclosing given context.
  ///
  Services getServices(BuildContext context) {
    var services = _services[context.appTargetKey];

    if (null == services) {
      throw "Services are not registered yet.";
    }

    return services;
  }
}
