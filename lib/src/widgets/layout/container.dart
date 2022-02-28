import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/utils.dart';

/// A widget to contain a widget in itself.
///
/// This widget will be as big as possible if [width]
/// and/or [height] factors are not.
///
class Container extends Widget {
  final String? key;

  final int? width;
  final int? height;
  final MeasuringUnit? sizingUnit;

  final String? style;

  final Widget child;

  const Container({
    this.key,
    this.style,
    this.width,
    this.height,
    this.sizingUnit,
    required this.child,
  });

  @override
  String get type => (Container).toString();

  @override
  DomTag get tag => DomTag.div;

  @override
  builder(context) {
    return ContainerRenderObject(
      child: child,
      width: width,
      height: height,
      styles: null != style ? style!.split(" ") : [],
      sizingUnit: sizingUnit ?? MeasuringUnit.pixel,
      context: context.mergeKey(key),
    );
  }
}

class ContainerRenderObject extends RenderObject {
  final Widget child;
  final List<String> styles;

  final int? width;
  final int? height;
  final MeasuringUnit sizingUnit;

  ContainerRenderObject({
    this.width,
    this.height,
    required this.child,
    required this.styles,
    required this.sizingUnit,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    applyProps(widgetObject, this);

    Framework.buildWidget(
      widget: child,
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as ContainerRenderObject;

    clearProps(widgetObject, this);

    applyProps(widgetObject, updatedRenderObject);

    Framework.updateWidget(
      widget: child,
      parentContext: context,
    );
  }

  void applyProps(
    WidgetObject widgetObject,
    ContainerRenderObject renderObject,
  ) {
    var sizeUnit = Utils.mapMeasuringUnit(renderObject.sizingUnit);

    if (null != width) {
      widgetObject.htmlElement.style.width = "${renderObject.width}$sizeUnit";
    }
    if (null != height) {
      widgetObject.htmlElement.style.height = "${renderObject.height}$sizeUnit";
    }

    if (renderObject.styles.isNotEmpty) {
      widgetObject.htmlElement.classes.addAll(renderObject.styles);
    }
  }

  void clearProps(
    WidgetObject widgetObject,
    ContainerRenderObject renderObject,
  ) {
    if (null != renderObject.width) {
      widgetObject.htmlElement.style.width = '';
    }

    if (null != renderObject.height) {
      widgetObject.htmlElement.style.height = '';
    }

    if (renderObject.styles.isNotEmpty) {
      widgetObject.htmlElement.classes.removeAll(renderObject.styles);
    }
  }
}
