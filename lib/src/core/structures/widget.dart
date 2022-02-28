import 'package:rad/rad.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// Describes the configuration for an [RenderObject].
///
/// Widget is the super class in the Rad framework from which all widgets
/// extends. A widget is an immutable description of user interface.
///
abstract class Widget {
  const Widget();

  DomTag get tag;
  String get type;

  /// Return widget's [RenderObject].
  ///
  /// It can be called multiple times to get [RenderObject] containing
  /// fresh state.
  ///
  RenderObject builder(BuildContext context);

  /// Create internal state of widget.
  ///
  /// Framework calls this method when it inflates a widget for
  /// the first time. This method get's called exactly once in entire
  /// lifetime of a widget.
  ///
  void createState(RenderObject renderObject) {}
}
