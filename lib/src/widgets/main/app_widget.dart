import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/css/include/normalize.generated.dart';
import 'package:rad/src/css/main.generated.dart';
import 'package:rad/src/css/rad_app.generated.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/main/rad_app.dart';

abstract class AppWidget extends Widget {
  final String? key;

  final Widget child;
  final String targetId;

  AppWidget({
    this.key,
    required this.child,
    required this.targetId,
  }) {
    Framework.init();

    Framework.buildChildren(
      widgets: [this],
      parentContext: BuildContext.bigBang(targetId),
    );
  }

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (AppWidget).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    context.parent;

    return AppWidgetRenderObject(
      child: child,
      context: context,
    );
  }
}

class AppWidgetRenderObject extends RenderObject {
  final Widget child;

  AppWidgetRenderObject({
    required this.child,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    var targetElement = widgetObject.htmlElement.parent;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    targetElement.dataset.addAll({"wtype": "Target"});

    // insert framework's CSS styles

    Framework.addGlobalStyles(GEN_STYLES_NORMALIZE_CSS);
    Framework.addGlobalStyles(GEN_STYLES_MAIN_CSS);

    if (runtimeType is RadApp) {
      Framework.addGlobalStyles(GEN_STYLES_RAD_APP_CSS);
    }

    Framework.buildChildren(widgets: [child], parentContext: context);
  }

  @override
  update(widgetObject, updatedRenderObject) {
    throw "Framework gone wild";
  }
}
