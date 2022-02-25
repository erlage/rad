import '/src/core/structures/widget.dart';
import '/src/widgets/main/app_widget.dart';

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
