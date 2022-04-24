import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_registry.dart';

/// A mixin with a services resolver getter.
///
mixin ServicesResolver {
  Services? _services;

  Services resolveServices(BuildContext context) {
    return _services ??= ServicesRegistry.instance.getServices(context);
  }
}
