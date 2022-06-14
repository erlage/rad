import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/debug/debug_service.dart';
import 'package:rad/src/core/services/events/events_service.dart';
import 'package:rad/src/core/services/keygen/key_gen_service.dart';
import 'package:rad/src/core/services/router/router_service.dart';
import 'package:rad/src/core/services/scheduler/scheduler_service.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/services/walker/walker_service.dart';

/// Services object.
///
class Services {
  /// App options.
  ///
  final AppOptions appOptions;

  /// Root element.
  ///
  final RootElement rootElement;

  final Service _debug;
  final Service _walker;
  final Service _events;
  final Service _router;
  final Service _keyGen;
  final Service _scheduler;

  DebugService get debug => _debug as DebugService;
  WalkerService get walker => _walker as WalkerService;
  EventsService get events => _events as EventsService;
  RouterService get router => _router as RouterService;
  KeyGenService get keyGen => _keyGen as KeyGenService;
  SchedulerService get scheduler => _scheduler as SchedulerService;

  Services({
    required this.appOptions,
    required this.rootElement,
  })  : _debug = DebugService(rootElement, appOptions.debugOptions),
        _keyGen = KeyGenService(rootElement, appOptions.keyGenOptions),
        _walker = WalkerService(rootElement, appOptions.walkerOptions),
        _events = EventsService(rootElement, appOptions.eventsOptions),
        _router = RouterService(rootElement, appOptions.routerOptions),
        _scheduler = SchedulerService(rootElement, appOptions.schedulerOptions);

  void startServices() {
    ServicesRegistry.instance.registerServices(rootElement, this);

    _debug.startService();
    _keyGen.startService();
    _walker.startService();
    _events.startService();
    _router.startService();
    _scheduler.startService();
  }

  void stopServices() {
    _debug.stopService();
    _keyGen.stopService();
    _walker.stopService();
    _events.stopService();
    _router.stopService();
    _scheduler.stopService();

    ServicesRegistry.instance.unRegisterServices(rootElement);
  }
}
