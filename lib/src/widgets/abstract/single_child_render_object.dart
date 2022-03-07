import 'package:rad/rad.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';

abstract class SingleChildRenderObject extends MultiChildRenderObject {
  final Widget child;

  SingleChildRenderObject(
    this.child,
    BuildContext context,
  ) : super([child], context);
}
