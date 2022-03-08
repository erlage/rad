import 'package:rad/rad.dart';

abstract class SingleChildRenderObject extends MultiChildRenderObject {
  final Widget child;

  SingleChildRenderObject(
    this.child,
    BuildContext context,
  ) : super([child], context);
}
