import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';

/// Base class for framework's service.
///
abstract class Service with ServicesResolver {
  final RootElement rootElement;

  Service(this.rootElement);

  Services get services => resolveServices(rootElement);

  void startService() {}

  void stopService() {}
}
