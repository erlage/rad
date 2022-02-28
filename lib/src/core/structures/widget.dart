import 'package:rad/rad.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// Describes the configuration for an [RenderObject].
///
/// Widget is the super class in the Rad framework from where all widgets
/// extends. A widget is an immutable description of user interface.
///
abstract class Widget {
  const Widget();

  DomTag get tag;
  String get type;

  RenderObject builder(BuildContext context);

  void createState(RenderObject renderObject) {}
}
