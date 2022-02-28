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

  final Widget child;
  final String? style;

  final int? width;
  final int? height;
  final MeasuringUnit? sizingUnit;

  @override
  String get type => (Container).toString();

  @override
  DomTag get tag => DomTag.div;

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

    applyProps(widgetObject, updatedRenderObject);

    Framework.updateWidget(
      widget: child,
      parentContext: context,
    );
  }

  void applyProps(
    WidgetObject widgetObj,
    ContainerRenderObject renderObj,
  ) {
    var sizingUnit = Utils.mapMeasuringUnit(renderObj.sizingUnit);

    if (null != width) {
      widgetObj.htmlElement.style.width =
          renderObj.width.toString() + sizingUnit;
    }
    if (null != height) {
      widgetObj.htmlElement.style.height =
          renderObj.height.toString() + sizingUnit;
    }

    if (renderObj.styles.isNotEmpty) {
      widgetObj.htmlElement.classes.addAll(renderObj.styles);
    }
  }
}
