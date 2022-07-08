// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/services/debug/debug_service.dart';
import 'package:rad/src/core/services/events/events_service.dart';
import 'package:rad/src/core/services/router/router_service.dart';
import 'package:rad/src/core/services/scheduler/scheduler_service.dart';
import 'package:rad/src/core/services/services.dart';

/// Services Registry.
///
@internal
class ServicesRegistry {
  ServicesRegistry._();
  static ServicesRegistry? _instance;
  static ServicesRegistry get instance => _instance ??= ServicesRegistry._();

  final _services = <String, Services>{};

  void registerServices(BuildContext context, Services services) {
    assert(
      !_services.containsKey(context.appTargetId),
      'Services are already registered with the context.',
    );

    _services[context.appTargetId] = services;
  }

  void unRegisterServices(BuildContext context) {
    _services.remove(context.appTargetId);
  }

  /// Get services object assocaited with app instance to which [context]
  /// belongs.
  ///
  Services getServices(BuildContext context) {
    assert(
      _services.containsKey(context.appTargetId),
      'Services not registered with the context yet.',
    );

    return _services[context.appTargetId]!;
  }

  /// Get debug service associated with app instance to which [context]
  /// belongs.
  ///
  DebugService getDebug(BuildContext context) {
    return getServices(context).debug;
  }

  /// Get router service associated with app instance to which [context]
  /// belongs.
  ///
  RouterService getRouter(BuildContext context) {
    return getServices(context).router;
  }

  /// Get events service associated with app instance to which [context]
  /// belongs.
  ///
  EventsService getEvents(BuildContext context) {
    return getServices(context).events;
  }

  /// Get scheduler service associated with app instance to which [context]
  /// belongs.
  ///
  SchedulerService getScheduler(BuildContext context) {
    return getServices(context).scheduler;
  }
}
