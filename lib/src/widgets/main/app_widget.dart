import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/css/include/normalize.generated.dart';
import 'package:rad/src/css/main.generated.dart';
import 'package:rad/src/css/rad_app.generated.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/main/rad_app.dart';

abstract class AppWidget<T> extends Widget {
  final String? key;

  final Widget child;
  final String targetId;

  AppWidget({
    this.key,
    required this.child,
    required this.targetId,
  }) {
    Framework.init();

    Framework.buildWidget(
      widget: this,
      parentContext: BuildContext.bigBang(targetId),
    );
  }

  @override
  builder(context) {
    return AppWidgetRenderObject<T>(
      child: child,
      context: context.mergeKey(key),
    );
  }
}

class AppWidgetRenderObject<T> extends RenderObject {
  final Widget child;

  AppWidgetRenderObject({
    required this.child,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    var targetElement = widgetObject.htmlElement.parent;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    targetElement.dataset.addAll({"wtype": "Target"});

    // insert framework's CSS styles

    Framework.addGlobalStyles(GEN_STYLES_NORMALIZE_CSS);
    Framework.addGlobalStyles(GEN_STYLES_MAIN_CSS);

    if (T.toString() == (RadApp).toString()) {
      Framework.addGlobalStyles(GEN_STYLES_RAD_APP_CSS);
    }

    Framework.buildWidget(
      widget: child,
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    throw "Framework gone wild";
  }
}
