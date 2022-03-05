import 'package:rad/rad.dart';

class Row extends Flex {
  Row({
    String? key,
    double? gap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    required List<Widget> children,
  }) : super(
          key: key,
          gap: gap,
          axis: Axis.horizontal,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
}
