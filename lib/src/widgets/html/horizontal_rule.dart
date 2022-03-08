import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/style_props.dart';

class HorizontalRule extends Widget {
  final String? key;

  final String? classes;

  HorizontalRule({
    this.key,
    this.classes,
  });

  @override
  DomTag get tag => DomTag.horizontalRule;

  @override
  String get type => "$HorizontalRule";

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return HorizontalRuleRenderObject(
      styleProps: StyleProps(classes),
      context: context,
    );
  }
}

class HorizontalRuleRenderObject extends RenderObject {
  StyleProps styleProps;

  HorizontalRuleRenderObject({
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  void render(WidgetObject widgetObject) {
    styleProps.apply(widgetObject.element);
  }

  @override
  void update(
    updateType,
    widgetObject,
    covariant HorizontalRuleRenderObject updatedRenderObject,
  ) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);
  }
}
