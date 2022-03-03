import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/widgets/main/navigator/navigator_state.dart';
import 'package:rad/src/widgets/main/navigator/route.dart';

class Navigator extends Widget {
  final String? key;

  final List<Route> routes;

  const Navigator({this.key, required this.routes});

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Navigator).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  onContextCreate(context) => Router.register(context);

  @override
  createRenderObject(context) => NavigatorRenderObject(context);

  @override
  onRenderObjectCreate(renderObject) {
    //
    // If we create state in RenderObject then state will be created
    // multiple times because framework can create RenderObject anytime
    // it wants a up-to-date interface. Creating state here is more
    // appropriate for performance reasons as this hook gets called
    // only when first RenderObject of this widget is created.
    //

    renderObject as NavigatorRenderObject;

    renderObject.state = NavigatorState();
  }
}

class NavigatorRenderObject extends RenderObject {
  /// State of navigator.
  ///
  late final NavigatorState state;

  NavigatorRenderObject(BuildContext context) : super(context);

  // delegate everything to state object.

  @override
  render(widgetObject) => state.render(widgetObject);

  @override
  void beforeUnMount() => state.dispose();
}
