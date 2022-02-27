import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
import 'package:rad/src/core/utils.dart';

class Container extends Widget {
  final String? key;

  final Widget child;
  final String? style;

  final int? width;
  final int? height;
  final MeasuringUnit? sizingUnit;

  const Container({
    this.key,
    this.style,
    this.width,
    this.height,
    this.sizingUnit,
    required this.child,
  });

  @override
  builder(context) {
    return ContainerRenderObject(
      child: child,
      style: style ?? '',
      width: width,
      height: height,
      sizingUnit: sizingUnit ?? MeasuringUnit.pixel,
      buildableContext: context.mergeKey(key),
    );
  }
}

class ContainerRenderObject extends RenderObject<Container> {
  final Widget child;
  final String style;

  final int? width;
  final int? height;
  final MeasuringUnit sizingUnit;

  final BuildableContext buildableContext;

  ContainerRenderObject({
    required this.child,
    required this.style,
    this.width,
    this.height,
    required this.sizingUnit,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.div,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    var sizingUnit = Utils.mapMeasuringUnit(this.sizingUnit);

    if (null != width) {
      widgetObject.htmlElement.style.width = width.toString() + sizingUnit;
    }
    if (null != height) {
      widgetObject.htmlElement.style.height = height.toString() + sizingUnit;
    }

    if (style.isNotEmpty) {
      widgetObject.htmlElement.className += " $style";
    }

    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }
}
