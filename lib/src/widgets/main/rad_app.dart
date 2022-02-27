import 'package:rad/src/core/structures/widget.dart';
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
/// Your app contents will go in the [child] property.
///
/// ```dart
/// RadApp(
///   targetId: "id_of_a_div",
///   home: Text("just a simple page"),
/// )
/// ```
///
class RadApp extends AppWidget<RadApp> {
  RadApp({
    String? key,
    required Widget child,
    required String targetId,
  }) : super(
          key: key,
          child: child,
          targetId: targetId,
        );
}
