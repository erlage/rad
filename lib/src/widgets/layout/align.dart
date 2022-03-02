import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/props/alignment.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';

/// A widget that aligns its child within itself.
///
/// This widget will be as big as possible.
///
/// See also:
///
///  * [Alignment], widget's alignment
///
class Align extends Widget {
  final String? key;

  final Widget child;

  final Alignment alignment;

  const Align({
    this.key,
    required this.child,
    required this.alignment,
  });

  /// Create a Align widget that places its child at center.
  ///
  /// It can be used in-place of Flutter's Center widget.
  ///
  /// It's a shorthand for:
  ///
  /// ```dart
  /// Align(
  ///   alignment: Alignment.center,
  ///   child: SomeChildWidget(),
  /// );
  /// ```
  ///
  const Align.center({
    this.key,
    required this.child,
  }) : alignment = Alignment.center;

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Align).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return AlignRenderObject(
      child: child,
      context: context,
      alignment: alignment,
    );
  }
}

class AlignRenderObject extends RenderObject {
  final Widget child;
  final Alignment alignment;

  AlignRenderObject({
    required this.child,
    required this.alignment,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
      elementCallback: (element) => alignment.apply(element),
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as AlignRenderObject;

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
      elementCallback: (element) => alignment.apply(
        element,
        updatedRenderObject.alignment,
      ),
    );
  }
}
