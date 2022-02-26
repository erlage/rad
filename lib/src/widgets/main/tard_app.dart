import 'package:tard/src/core/structures/widget.dart';
import 'package:tard/src/widgets/main/app_widget.dart';

class TardApp extends AppWidget<TardApp> {
  TardApp({
    String? key,
    required Widget child,
    required String targetId,
  }) : super(
          key: key,
          child: child,
          targetId: targetId,
        );
}
