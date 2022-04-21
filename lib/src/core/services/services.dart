import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/services/debug/debug.dart';
import 'package:rad/src/core/services/keygen/key_gen.dart';
import 'package:rad/src/core/services/router/router.dart';
import 'package:rad/src/core/services/scheduler/scheduler.dart';
import 'package:rad/src/core/services/walker/walker.dart';
import 'package:rad/src/core/services/services_registry.dart';

/// Services available.
///
class Services {
  final Debug debug;
  final Walker walker;
  final Router router;
  final Scheduler scheduler;
  final KeyGen keyGen;

  Services(BuildContext rootContext)
      : debug = Debug(),
        keyGen = KeyGen(rootContext),
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
