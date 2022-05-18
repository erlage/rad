import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';

/// Route is a [Navigator] specific widget.
///
/// A [Route] act as a wrapper for your page contents. Along with page,
/// it contains routing specific information that helps [Navigator] manage
/// this widget position in tree.
///
class Route extends Widget {
  /// Name of the Route path.
  ///
  final String path;

  /// Name of the Route.
  ///
  final String name;

  /// Route's contents.
  ///
  final Widget page;

  const Route({
    Key? key,
    String? path,
    required this.name,
    required this.page,
  })  : path = path ?? name,
        super(key: key);

  @nonVirtual
  @override
  get widgetType => '$Route';

  @override
  get correspondingTag => DomTag.division;

  @override
  get widgetChildren => [page];

  @override
  createConfiguration() => RouteConfiguration(name: name, path: path);

  @override
  isConfigurationChanged(covariant RouteConfiguration oldConfiguration) {
    return path != oldConfiguration.path || name != oldConfiguration.name;
  }

  @override
  createRenderObject(context) => RouteRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class RouteConfiguration extends WidgetConfiguration {
  final String name;
  final String path;

  const RouteConfiguration({required this.name, required this.path});
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class RouteRenderObject extends RenderObject {
  const RouteRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant RouteConfiguration configuration,
  }) {
    return ElementDescription(
      dataset: {
        Constants.attrWidgetType: '$Route',
      },
    );
  }

  @override
  update({
    required updateType,
    required oldConfiguration,
    required covariant RouteConfiguration newConfiguration,
  }) {
    return ElementDescription(
      dataset: {
        Constants.attrWidgetType: '$Route',
      },
    );
  }
}
