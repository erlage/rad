import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/widgets/main/app_widget.dart';

class TradApp extends AppWidget<TradApp> {
  TradApp({
    String? key,
    required Widget child,
    required String targetId,
  }) : super(
          key: key,
          child: child,
          targetId: targetId,
        );
}
