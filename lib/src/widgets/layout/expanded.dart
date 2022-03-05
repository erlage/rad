import 'package:rad/rad.dart';

class Expanded extends Flexible {
  Expanded({
    int flex = 1,
    required Widget child,
  }) : super(
          flex: flex,
          child: child,
        );
}
