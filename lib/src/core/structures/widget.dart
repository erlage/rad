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
  String get initialKey;

  /// Called when context for this widget is created.
  ///
  void onContextCreate(BuildContext context) {}

  /// Called when framework needs a [RenderObject] for current widget.
  ///
  /// It can be called multiple times to get fresh [RenderObject].
  ///
  RenderObject buildRenderObject(BuildContext context);

  /// Called when first render object is created.
  ///
  /// Framework can request a fresh copy of [RenderObject] any time it
  /// wants. But framwork will fire this function only when first [RenderObject]
  /// of this widget is created. For subsequent [RenderObject]s this won't
  /// get fired. Which means it can be used to initialize widget state that
  /// depends on initial [RenderObject] such as in [StatefulWidget].
  ///
  /// If you want to initialize something that depends on [BuildContext], you
  /// can do that using [onContextCreate] hook.
  ///
  void onRenderObjectCreate(RenderObject renderObject) {}
}
