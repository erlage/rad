import 'package:rad/src/core/common/objects/options/debug_options.dart';
import 'package:rad/src/core/common/objects/options/router_options.dart';

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

class KeyGenOptions {
  const KeyGenOptions();

  static const defaultMode = KeyGenOptions();
}

class WalkerOptions {
  const WalkerOptions();

  static const defaultMode = WalkerOptions();
}

class EventsOptions {
  const EventsOptions();

  static const defaultMode = EventsOptions();
}

class SchedulerOptions {
  const SchedulerOptions();

  static const defaultMode = SchedulerOptions();
}
