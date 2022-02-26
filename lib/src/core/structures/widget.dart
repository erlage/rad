import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/render_object.dart';

abstract class Widget {
  const Widget();

  RenderObject builder(BuildableContext context);
}
