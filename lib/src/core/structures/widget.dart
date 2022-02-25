import 'package:castor/src/core/structures/build_context.dart';
import 'package:castor/src/core/structures/render_object.dart';

abstract class Widget {
  RenderObject builder(BuildableContext context);
}
