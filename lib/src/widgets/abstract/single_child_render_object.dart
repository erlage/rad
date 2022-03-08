import 'package:rad/rad.dart';
import 'package:rad/src/core/types.dart';

abstract class SingleChildRenderObject extends MultiChildRenderObject {
  final Widget child;

  SingleChildRenderObject({
    required this.child,
    required BuildContext context,
    ElementCallback? elementCallback,
  }) : super(
          context: context,
          children: [child],
          elementCallback: elementCallback,
        );
}
