import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/framework.dart';
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

  final String? styles;

  final Widget child;

  const Container({
    this.key,
    this.styles,
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
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return ContainerRenderObject(
      context: context,
      props: ContainerProps(
        child: child,
        width: width,
        height: height,
        styles: null != styles ? styles!.split(" ") : [],
        sizingUnit: sizingUnit ?? MeasuringUnit.pixel,
      ),
    );
  }
}

class ContainerProps {
  final int? width;
  final int? height;
  final List<String> styles;
  final MeasuringUnit sizingUnit;
  final Widget child;

  ContainerProps({
    this.width,
    this.height,
    required this.styles,
    required this.sizingUnit,
    required this.child,
  });
}

class ContainerRenderObject extends RenderObject {
  ContainerProps props;

  ContainerRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    applyProps(widgetObject.htmlElement);

    Framework.buildChildren(widgets: [props.child], parentContext: context);
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as ContainerRenderObject;

    clearProps(widgetObject.htmlElement);

    switchProps(updatedRenderObject.props);

    applyProps(widgetObject.htmlElement);

    Framework.updateChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  void switchProps(ContainerProps props) {
    this.props = props;
  }

  void applyProps(HtmlElement htmlElement) {
    var sizeUnit = Utils.mapMeasuringUnit(props.sizingUnit);

    if (null != props.width) {
      htmlElement.style.width = "${props.width}$sizeUnit";
    }

    if (null != props.height) {
      htmlElement.style.height = "${props.height}$sizeUnit";
    }

    if (props.styles.isNotEmpty) {
      htmlElement.classes.addAll(props.styles);
    }
  }

  void clearProps(HtmlElement htmlElement) {
    if (props.styles.isNotEmpty) {
      htmlElement.classes.removeAll(props.styles);
    }
  }
}
