import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/debug/debug.dart';
import 'package:rad/src/core/services/router/router.dart';
import 'package:rad/src/core/services/walker/walker.dart';
import 'package:rad/src/core/services/keygen/key_gen.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/services/scheduler/scheduler.dart';

/// Services object.
///
class Services {
  final AppOptions appOptions;

  final Service _debug;
  final Service _walker;
  final Service _router;
  final Service _keyGen;
  final Service _scheduler;

  Debug get debug => _debug as Debug;
  Walker get walker => _walker as Walker;
  Router get router => _router as Router;
  KeyGen get keyGen => _keyGen as KeyGen;
  Scheduler get scheduler => _scheduler as Scheduler;

  Services(this.appOptions)
      : _debug = Debug(
          appOptions.rootContext,
          appOptions.debugOptions,
        ),
        _keyGen = KeyGen(
          appOptions.rootContext,
          appOptions.keyGenOptions,
        ),
        _walker = Walker(
          appOptions.rootContext,
          appOptions.walkerOptions,
        ),
        _router = Router(
          appOptions.rootContext,
          appOptions.routerOptions,
        ),
        _scheduler = Scheduler(
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
