import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/widgets/main/app_widget.dart';

class RadApp extends AppWidget<RadApp> {
  RadApp({
    String? key,
    required Widget child,
    required String targetId,
  }) : super(
          key: key,
          child: child,
          targetId: targetId,
        );
}
