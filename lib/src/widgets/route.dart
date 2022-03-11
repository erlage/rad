import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

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
    String? key,
    String? path,
    required this.name,
    required this.page,
  })  : path = path ?? name,
        super(key);

  @override
  get concreteType => "$Route";

  @override
  get correspondingTag => DomTag.div;

  @override
  get widgetChildren => [page];

  @override
  createConfiguration() => _RouteConfiguration(name: name, path: path);

  @override
  isConfigurationChanged(covariant _RouteConfiguration oldConfiguration) {
    return path != oldConfiguration.path || name != oldConfiguration.name;
  }

  @override
  createRenderObject(context) => _RouteRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _RouteConfiguration extends WidgetConfiguration {
  final String name;
  final String path;

  const _RouteConfiguration({required this.name, required this.path});
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _RouteRenderObject extends RenderObject {
  const _RouteRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _RouteConfiguration configuration,
  ) {
    CommonProps.applyDataAttributes(element, {
      System.attrRouteName: configuration.name,
      System.attrRoutePath: configuration.path,
    });
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _RouteConfiguration oldConfiguration,
    required covariant _RouteConfiguration newConfiguration,
  }) {
    CommonProps.clearDataAttributes(element, {
      System.attrRouteName: oldConfiguration.name,
      System.attrRoutePath: oldConfiguration.path,
    });

    CommonProps.applyDataAttributes(element, {
      System.attrRouteName: newConfiguration.name,
      System.attrRoutePath: newConfiguration.path,
    });
  }
}
