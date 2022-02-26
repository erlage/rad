import 'package:trad/src/core/objects/render_object.dart';
import 'package:trad/src/core/structures/buildable_context.dart';

abstract class Widget {
  const Widget();

  RenderObject builder(BuildableContext context);
}
