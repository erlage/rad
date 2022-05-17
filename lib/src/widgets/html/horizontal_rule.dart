import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/utils/common_props.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';

/// The HorizontalRule widget (HTML's `hr` tag).
///
class HorizontalRule extends Widget {
  final String? classAttribute;

  const HorizontalRule({
    Key? key,
    this.classAttribute,
  }) : super(key: key);

  @nonVirtual
  @override
  get widgetType => "$HorizontalRule";

  @override
  get correspondingTag => DomTag.horizontalRule;

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
  render({
    required covariant _HorizontalRuleConfiguration configuration,
  }) {
    return ElementDescription(
      classes: CommonProps.prepareClasses(
        classAttribute: configuration.classAttribute,
        oldClassAttribute: null,
      ),
    );
  }

  @override
  update({
    required updateType,
    required covariant _HorizontalRuleConfiguration oldConfiguration,
    required covariant _HorizontalRuleConfiguration newConfiguration,
  }) {
    return ElementDescription(
      classes: CommonProps.prepareClasses(
        classAttribute: newConfiguration.classAttribute,
        oldClassAttribute: oldConfiguration.classAttribute,
      ),
    );
  }
}
