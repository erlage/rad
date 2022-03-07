import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/flex_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/layout/align.dart';
import 'package:rad/src/widgets/layout/center.dart';
import 'package:rad/src/widgets/layout/column.dart';
import 'package:rad/src/widgets/layout/row.dart';

/// A widget that displays its children in a one-dimensional array.
///
/// The [Flex] widget allows you to control the axis along which the children are
/// placed (horizontal or vertical). This is referred to as the _main axis_. If
/// you know the main axis in advance, then consider using a [Row] (if it's
/// horizontal) or [Column] (if it's vertical) instead, because that will be less
/// verbose.
///
/// The [Flex] widget does not scroll (and in general it is considered an error
/// to have more children in a [Flex] than will fit in the available room).
///
/// If you only have one child, then rather than using [Flex], [Row], or
/// [Column], consider using [Align] or [Center] to position the child.
///
/// See also:
///
///  * [Row], for a version of this widget that is always horizontal.
///  * [Column], for a version of this widget that is always vertical.
///  * [Expanded]
///  * [Flexible]
///
class Flex extends Widget {
  final String? key;

  final Axis axis;

  final double? gap;

  final FlexWrap? flexWrap;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final String? styles;

  final List<Widget> children;

  const Flex({
    this.key,
    this.gap,
    this.styles,
    this.flexWrap,
    required this.axis,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.children,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Flex).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return FlexRenderObject(
      context: context,
      children: children,
      styleProps: StyleProps(styles),
      flexProps: FlexProps(
        gap: gap,
        axis: axis,
        flexWrap: flexWrap ?? FlexWrap.nowrap,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
      ),
    );
  }
}

class FlexRenderObject extends RenderObject {
  final FlexProps flexProps;

  final StyleProps styleProps;

  final List<Widget> children;

  FlexRenderObject({
    required this.children,
    required this.flexProps,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    styleProps.apply(widgetObject.element);

    flexProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: children,
      parentContext: context,
    );
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant FlexRenderObject updatedRenderObject,
  ) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    flexProps.apply(widgetObject.element, updatedRenderObject.flexProps);

    Framework.updateChildren(
      widgets: updatedRenderObject.children,
      updateType: updateType,
      parentContext: context,
    );
  }
}
