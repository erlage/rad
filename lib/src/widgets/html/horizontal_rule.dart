import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/class_attribute_prop.dart';

class HorizontalRule extends Widget {
  final String? classAttribute;

  HorizontalRule({
    String? id,
    this.classAttribute,
  }) : super(id);

  @override
  DomTag get tag => DomTag.horizontalRule;

  @override
  String get type => "$HorizontalRule";

  @override
  RenderObject createRenderObject(BuildContext context) {
    return HorizontalRuleRenderObject(
      styleProps: ClassAttributeProp(classAttribute),
      context: context,
    );
  }
}

class HorizontalRuleRenderObject extends RenderObject {
  ClassAttributeProp styleProps;

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
