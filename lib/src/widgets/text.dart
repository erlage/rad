import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// A run of text with a single style.
///
class Text extends Widget {
  final String text;
  final String? classAttribute;

  const Text(
    this.text, {
    String? key,
    this.classAttribute,
  }) : super(key: key);

  @override
  get concreteType => "$Text";

  @override
  get correspondingTag => DomTag.span;

  @override
  createConfiguration() => _TextConfiguration(text, classAttribute);

  @override
  isConfigurationChanged(covariant _TextConfiguration oldConfiguration) {
    return text != oldConfiguration.text ||
        classAttribute != oldConfiguration.classAttribute;
  }

  @override
  createRenderObject(context) => _TextRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _TextConfiguration extends WidgetConfiguration {
  final String text;
  final String? classAttribute;

  const _TextConfiguration(this.text, this.classAttribute);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TextRenderObject extends RenderObject {
  const _TextRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _TextConfiguration configuration,
  ) {
    CommonProps.applyClassAttribute(element, configuration.classAttribute);

    element.innerText = configuration.text;
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _TextConfiguration oldConfiguration,
    required covariant _TextConfiguration newConfiguration,
  }) {
    CommonProps.clearClassAttribute(element, oldConfiguration.classAttribute);
    CommonProps.applyClassAttribute(element, newConfiguration.classAttribute);

    element.innerText = newConfiguration.text;
  }
}
