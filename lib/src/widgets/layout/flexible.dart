import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/flex_item_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/layout/column.dart';
import 'package:rad/src/widgets/layout/expanded.dart';
import 'package:rad/src/widgets/layout/flex.dart';
import 'package:rad/src/widgets/layout/row.dart';

/// A widget that controls how a child of a [Row], [Column], or [Flex] flexes.
///
/// Using a [Flexible] widget gives a child of a [Row], [Column], or [Flex]
/// the flexibility to expand to fill the available space in the main axis
/// (e.g., horizontally for a [Row] or vertically for a [Column]).
///
/// Actually difference betweeok [Expanded] and [Flexible] widget is that [Flexible]
/// widget does not require the child to fill the available space. Unfortunately this
/// behaviour is not implemented yet, and technically, both [Expanded] and [Flexible]
/// widgets are same in Rad.
///
/// See also:
///
///  * [Expanded]
///
class Flexible extends Widget {
  final String? key;

  final int flex;

  final Widget child;

  final String? styles;

  const Flexible({
    this.key,
    this.styles,
    this.flex = 1,
    required this.child,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Flexible).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return FlexibleRenderObject(
      child: child,
      context: context,
      styleProps: StyleProps(styles),
      flexItemProps: FlexItemProps(flex: flex),
    );
  }
}

class FlexibleRenderObject extends RenderObject {
  final Widget child;

  final StyleProps styleProps;

  final FlexItemProps flexItemProps;

  FlexibleRenderObject({
    required this.child,
    required this.styleProps,
    required this.flexItemProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    styleProps.apply(widgetObject.element);

    flexItemProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, covariant FlexibleRenderObject updatedRenderObject) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    flexItemProps.apply(
      widgetObject.element,
      updatedRenderObject.flexItemProps,
    );

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }
}
