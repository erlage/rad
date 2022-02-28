import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/buildable_context.dart';

/// Describes the configuration for an [RenderObject].
///
/// Widget is the super class in the Rad framework from where all widgets
/// extends. A widget is an immutable description of user interface.
///
abstract class Widget {
  const Widget();

  RenderObject builder(BuildableContext context);

  void createState(RenderObject renderObject) {}
}
