import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/debug_options.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/css/rad_app.generated.dart';
import 'package:rad/src/widgets/main/app_widget.dart';

/// an application widget.
///
/// [RadApp] is a convenience widget that wraps your app and builds itself upon
/// a [AppWidget]. [AppWidget] handles the initial mount of your app. For
/// successful mounting you've to provide a [targetId] to [RadApp] which it
/// then passes to [AppWidget].
///
/// [targetId] - refers to a container element, it could be a div tag or a body
/// tag in your HTML page but note that it must be present in your HTML page
/// before app mount initiate.
///
/// setting [debugMode] to true will print useful logs in Browser console.
///
/// Your app contents will go in the [child] property.
///
/// ```dart
/// RadApp(
///   targetId: "id_of_a_div",
///   child: Text("just a simple page"),
/// )
/// ```
///
class RadApp extends AppWidget {
  RadApp({
    String? key,
    required Widget child,
    required String targetId,
    String routingPath = '',
    DebugOptions? debugOptions,
  }) : super(
            key: key,
            child: child,
            targetId: targetId,
            debugOptions: debugOptions,
            routingPath: routingPath,
            onInit: () {
              Framework.addGlobalStyles(GEN_STYLES_RAD_APP_CSS, "RadApp");
            });
}
