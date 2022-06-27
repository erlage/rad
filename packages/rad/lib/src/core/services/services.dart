// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/debug/debug_service.dart';
import 'package:rad/src/core/services/events/events_service.dart';
import 'package:rad/src/core/services/router/router_service.dart';
import 'package:rad/src/core/services/scheduler/scheduler_service.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/services/walker/walker_service.dart';

/// Services object.
///
@internal
class Services {
  /// App options.
  ///
  final AppOptions appOptions;

  /// Root element.
  ///
  final RootRenderElement rootElement;

  final Service _debug;
  final Service _walker;
  final Service _events;
  final Service _router;
  final Service _scheduler;

  DebugService get debug => _debug as DebugService;
  WalkerService get walker => _walker as WalkerService;
  EventsService get events => _events as EventsService;
  RouterService get router => _router as RouterService;
  SchedulerService get scheduler => _scheduler as SchedulerService;

  Services({
    required this.appOptions,
    required this.rootElement,
  })  : _debug = DebugService(rootElement, appOptions.debugOptions),
        _walker = WalkerService(rootElement, appOptions.walkerOptions),
        _events = EventsService(rootElement, appOptions.eventsOptions),
        _router = RouterService(rootElement, appOptions.routerOptions),
        _scheduler = SchedulerService(rootElement, appOptions.schedulerOptions);

  void startServices() {
    ServicesRegistry.instance.registerServices(rootElement, this);

    _debug.startService();
    _walker.startService();
    _events.startService();
    _router.startService();
    _scheduler.startService();
  }

  void stopServices() {
    _debug.stopService();
    _walker.stopService();
    _events.stopService();
    _router.stopService();
    _scheduler.stopService();

    ServicesRegistry.instance.unRegisterServices(rootElement);
  }
}
