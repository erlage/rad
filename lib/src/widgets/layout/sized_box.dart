import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/size_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A box with a specified size.
///
/// Optionally can include a child widget.
///
class SizedBox extends Widget {
  final String? key;

  final Widget? child;

  final String? size;
  final String? width;
  final String? height;

  final String? styles;

  const SizedBox({
    this.key,
    this.styles,
    this.child,
    this.size,
    this.width,
    this.height,
  });

  /// Creates a box that will become as small as its parent allows.
  ///
  SizedBox.shrink({
    this.key,
    this.styles,
  })  : child = null,
        size = '0px 0px',
        width = null,
        height = null;

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (SizedBox).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return SizedBoxRenderObject(
      child: child,
      context: context,
      styleProps: StyleProps(styles),
      sizeProps: SizeProps(size: size, width: width, height: height),
    );
  }
}

class SizedBoxRenderObject extends RenderObject {
  final Widget? child;

  final SizeProps sizeProps;
  final StyleProps styleProps;

  SizedBoxRenderObject({
    required this.child,
    required this.sizeProps,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    sizeProps.apply(widgetObject.element);

    styleProps.apply(widgetObject.element);

    var child = this.child;
    if (null != child) {
      Framework.buildChildren(
        widgets: [child],
        parentContext: context,
      );
    }
  }

  @override
  update(widgetObject, covariant SizedBoxRenderObject updatedRenderObject) {
    sizeProps.apply(widgetObject.element, updatedRenderObject.sizeProps);

    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    var child = updatedRenderObject.child;
    if (null != child) {
      Framework.updateChildren(
        widgets: [child],
        parentContext: context,
      );
    }
  }
}
