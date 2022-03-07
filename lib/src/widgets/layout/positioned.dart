import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/props/internal/position_props.dart';
import 'package:rad/src/core/props/internal/size_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A widget that controls position of it's child. Can be used
/// anywhere but it's usually used inside a [Stack] or [OverlayEntry]
/// widget.
///
class Positioned extends Widget {
  final String? key;

  final String? top;
  final String? bottom;
  final String? left;
  final String? right;
  final String? position;

  final String? size;
  final String? width;
  final String? height;

  final Widget child;

  const Positioned({
    this.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.position,
    this.size,
    this.width,
    this.height,
    required this.child,
  });

  /// Creats a full sized Positioned widget.
  ///
  Positioned.filled({
    this.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.position,
    required this.child,
  })  : size = '0px 0px',
        width = null,
        height = null;

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Positioned).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return PositionedRenderObject(
      child: child,
      context: context,
      sizeProps: SizeProps(size: size, width: width, height: height),
      posProps: PositionProps(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        position: position,
      ),
    );
  }
}

class PositionedRenderObject extends RenderObject {
  final Widget child;

  final SizeProps sizeProps;
  final PositionProps posProps;

  PositionedRenderObject({
    required this.child,
    required this.sizeProps,
    required this.posProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    sizeProps.apply(widgetObject.element);

    posProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  void update(
    updateType,
    widgetObject,
    updatedRenderObject,
  ) {
    updatedRenderObject as PositionedRenderObject;

    sizeProps.apply(widgetObject.element, updatedRenderObject.sizeProps);

    posProps.apply(widgetObject.element, updatedRenderObject.posProps);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      updateType: updateType,
      parentContext: context,
    );
  }
}
