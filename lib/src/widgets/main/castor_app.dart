import 'package:castor/src/core/structures/widget.dart';
import 'package:castor/src/widgets/main/app_widget.dart';

class CastorApp extends AppWidget<CastorApp> {
  CastorApp({
    String? key,
    required Widget child,
    required String targetId,
  }) : super(
          key: key,
          child: child,
          targetId: targetId,
        );
}
