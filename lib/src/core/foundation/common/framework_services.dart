import 'package:rad/src/core/foundation/scheduler/scheduler.dart';
import 'package:rad/src/core/foundation/walker/walker.dart';

/// Services offered by the framework.
///
class FrameworkServices {
  final Walker walker;
  final Scheduler scheduler;

  FrameworkServices()
      : walker = Walker(),
        scheduler = Scheduler();
}
