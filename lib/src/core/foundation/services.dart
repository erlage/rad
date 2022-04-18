import 'package:rad/src/core/foundation/router/router.dart';
import 'package:rad/src/core/foundation/scheduler/scheduler.dart';
import 'package:rad/src/core/foundation/walker/walker.dart';

/// Services available.
///
class Services {
  final walker = Walker();
  final router = Router();
  final scheduler = Scheduler();
}
