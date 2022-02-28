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
  DomTag get tag => DomTag.div;

  @override
  String get type => (Container).toString();

  @override
  String? get initialKey => key;

  @override
  buildRenderObject(context) {
    return ContainerRenderObject(
      child: child,
      context: context.mergeKey(key),
      props: ContainerProps(
        width: width,
        height: height,
        styles: null != style ? style!.split(" ") : [],
        sizingUnit: sizingUnit ?? MeasuringUnit.pixel,
      ),
    );
  }
}

class ContainerProps {
  int? width;
  int? height;
  List<String> styles;
  MeasuringUnit sizingUnit;

  ContainerProps({
    this.width,
    this.height,
    required this.styles,
    required this.sizingUnit,
  });
}

class ContainerRenderObject extends RenderObject {
  final Widget child;

  ContainerProps props;

  ContainerRenderObject({
    required this.props,
    required this.child,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    applyProps(widgetObject, this);

    Framework.buildChildren(widgets: [child], parentContext: context);
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as ContainerRenderObject;

    clearProps(widgetObject);

    props = updatedRenderObject.props;

    applyProps(widgetObject, updatedRenderObject);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }

  void applyProps(
    WidgetObject widgetObject,
    ContainerRenderObject renderObject,
  ) {
    var sizeUnit = Utils.mapMeasuringUnit(props.sizingUnit);

    if (null != props.width) {
      widgetObject.htmlElement.style.width = "${props.width}$sizeUnit";
    }

    if (null != props.height) {
      widgetObject.htmlElement.style.height = "${props.height}$sizeUnit";
    }

    if (props.styles.isNotEmpty) {
      widgetObject.htmlElement.classes.addAll(props.styles);
    }
  }

  void clearProps(
    WidgetObject widgetObject,
  ) {
    if (null == props.width) {
      widgetObject.htmlElement.style.width = '';
    }

    if (null == props.height) {
      widgetObject.htmlElement.style.height = '';
    }

    if (props.styles.isNotEmpty) {
      widgetObject.htmlElement.classes.removeAll(props.styles);
    }
  }
}
