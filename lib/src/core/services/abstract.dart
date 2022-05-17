import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';

/// Base class for framework's service.
///
abstract class Service with ServicesResolver {
  final BuildContext rootContext;

  Service(this.rootContext);

  Services get services => resolveServices(rootContext);

  void startService() {}

  void stopService() {}
}
