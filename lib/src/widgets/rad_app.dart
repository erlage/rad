import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A Simple App Widget that takes as much space as its parents allowed it to.
///
class RadApp extends Widget {
  final Widget child;

  const RadApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  get widgetChildren => [child];

  @override
  get widgetType => '$RadApp';

  @override
  get correspondingTag => DomTag.division;

  @override
  createConfiguration() => const WidgetConfiguration();

  @override
  isConfigurationChanged(oldConfiguration) => false;

  @override
  createRenderObject(context) => AppWidgetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class AppWidgetRenderObject extends RenderObject {
  const AppWidgetRenderObject(BuildContext context) : super(context);

  @override
  render({
    required configuration,
  }) {
    return ElementDescription(
      dataset: {
        Constants.attrWidgetType: '$RadApp',
      },
    );
  }
}
