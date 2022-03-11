import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

class HorizontalRule extends Widget {
  final String? classAttribute;

  HorizontalRule({
    String? key,
    this.classAttribute,
  }) : super(key);

  @override
  get correspondingTag => DomTag.horizontalRule;

  @override
  get concreteType => "$HorizontalRule";

  @override
  createConfiguration() => _HorizontalRuleConfiguration(classAttribute);

  @override
  isConfigurationChanged(
    covariant _HorizontalRuleConfiguration oldConfiguration,
  ) {
    return classAttribute != oldConfiguration.classAttribute;
  }

  @override
  createRenderObject(context) => _HorizontalRuleRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _HorizontalRuleConfiguration extends WidgetConfiguration {
  final String? classAttribute;

  const _HorizontalRuleConfiguration(this.classAttribute);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _HorizontalRuleRenderObject extends RenderObject {
  const _HorizontalRuleRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _HorizontalRuleConfiguration configuration,
  ) {
    CommonProps.applyClassAttribute(element, configuration.classAttribute);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _HorizontalRuleConfiguration oldConfiguration,
    required covariant _HorizontalRuleConfiguration newConfiguration,
  }) {
    CommonProps.clearClassAttribute(element, oldConfiguration.classAttribute);
    CommonProps.applyClassAttribute(element, newConfiguration.classAttribute);
  }
}
