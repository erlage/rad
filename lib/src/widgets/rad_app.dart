import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The App Widget.
///
/// This widget is a bridge between DOM and framework. It mounts itself to a pre-exisiting DOM
/// element and act as a root widget in your app.
///
/// If your app is installed in a sub directory/path on a domain, for example,
/// if your app is situated at `x.com/y_folder/index.html` then set `routingPath`
/// to `/y_folder`:
///
/// ```dart
/// RadApp(
///   ...
///   routingPath: '/y_folder',
///   ...
/// )
/// ```
///
/// Note, if your app is situated on main domain(`x.com`)/or on a subdomain(`y.x.com`), then
/// you don't need to change `routingPath`.
///
class RadApp extends Widget {
  final Widget child;

  const RadApp({
    required this.child,
    String? key,
    String routingPath = "",
  }) : super(key: key);

  @override
  get widgetChildren => [child];

  @override
  get concreteType => "$RadApp";

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
}
