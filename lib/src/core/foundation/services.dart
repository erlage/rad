import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/debug/debug.dart';
import 'package:rad/src/core/foundation/router/router.dart';
import 'package:rad/src/core/foundation/scheduler/scheduler.dart';
import 'package:rad/src/core/foundation/walker/walker.dart';
import 'package:rad/src/core/utilities/services_registry.dart';

/// Services available.
///
class Services {
  final Debug debug;
  final Walker walker;
  final Router router;
  final Scheduler scheduler;

  Services(BuildContext rootContext)
      : debug = Debug(),
        walker = Walker(rootContext),
        router = Router(rootContext),
        scheduler = Scheduler();
}

/// A mixing that include services resolver.
///
mixin ServicesResolver {
  Services? _services;

  Services resolveServices(BuildContext context) {
    return _services ??= ServicesRegistry.instance.getServices(context);
  }
}
