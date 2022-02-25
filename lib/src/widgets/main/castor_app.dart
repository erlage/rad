import '/src/core/structures/widget.dart';
import '/src/widgets/main/app_widget.dart';

class CastorApp extends AppWidget<CastorApp> {
  CastorApp({
    String? id,
    required Widget child,
    required String targetId,
  }) : super(
          id: id,
          child: child,
          targetId: targetId,
        );
}
