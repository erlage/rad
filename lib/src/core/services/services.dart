import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/debug/debug_service.dart';
import 'package:rad/src/core/services/keygen/key_gen_service.dart';
import 'package:rad/src/core/services/router/router_service.dart';
import 'package:rad/src/core/services/scheduler/scheduler_service.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/services/walker/walker_service.dart';

/// Services object.
///
class Services {
  final AppOptions appOptions;

  final Service _debug;
  final Service _walker;
  final Service _router;
  final Service _keyGen;
  final Service _scheduler;

  DebugService get debug => _debug as DebugService;
  WalkerService get walker => _walker as WalkerService;
  RouterService get router => _router as RouterService;
  KeyGenService get keyGen => _keyGen as KeyGenService;
  SchedulerService get scheduler => _scheduler as SchedulerService;

  Services(this.appOptions)
      : _debug = DebugService(
          appOptions.rootContext,
          appOptions.debugOptions,
        ),
        _keyGen = KeyGenService(
          appOptions.rootContext,
          appOptions.keyGenOptions,
        ),
        _walker = WalkerService(
          appOptions.rootContext,
          appOptions.walkerOptions,
        ),
        _router = RouterService(
          appOptions.rootContext,
          appOptions.routerOptions,
        ),
        _scheduler = SchedulerService(
          appOptions.rootContext,
          appOptions.schedulerOptions,
        );

  void startServices() {
    ServicesRegistry.instance.registerServices(appOptions.rootContext, this);

    _debug.startService();
    _keyGen.startService();
    _walker.startService();
    _router.startService();
    _scheduler.startService();
  }

  void stopServices() {
    _debug.stopService();
    _keyGen.stopService();
    _walker.stopService();
    _router.stopService();
    _scheduler.stopService();

    ServicesRegistry.instance.unRegisterServices(appOptions.rootContext);
  }
}
