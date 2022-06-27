// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/options/debug_options.dart';
import 'package:rad/src/core/common/objects/options/router_options.dart';

@internal
class AppOptions {
  final DebugOptions debugOptions;
  final RouterOptions routerOptions;
  final KeyGenOptions keyGenOptions;
  final WalkerOptions walkerOptions;
  final EventsOptions eventsOptions;
  final SchedulerOptions schedulerOptions;

  const AppOptions({
    required this.debugOptions,
    required this.routerOptions,
  })  : walkerOptions = WalkerOptions.defaultMode,
        eventsOptions = EventsOptions.defaultMode,
        keyGenOptions = KeyGenOptions.defaultMode,
        schedulerOptions = SchedulerOptions.defaultMode;
}

// options that has no configurable parts, so they are kinda disabled for now.

@internal
class KeyGenOptions {
  const KeyGenOptions();

  static const defaultMode = KeyGenOptions();
}

@internal
class WalkerOptions {
  const WalkerOptions();

  static const defaultMode = WalkerOptions();
}

@internal
class EventsOptions {
  const EventsOptions();

  static const defaultMode = EventsOptions();
}

@internal
class SchedulerOptions {
  const SchedulerOptions();

  static const defaultMode = SchedulerOptions();
}
