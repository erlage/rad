import 'package:rad/rad.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/css/include/normalize.generated.dart';
import 'package:rad/src/css/main.generated.dart';
import 'package:rad/src/css/rad_app.generated.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
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
      parentContext: BuildContext(
        key: targetId,
        parentKey: Constants.bigBang,
        widgetType: Constants.bigBang,
        widgetDomTag: DomTag.div,
      ),
    );
  }

  @override
  builder(context) {
    return AppWidgetRenderObject<T>(
      child: child,
      buildableContext: BuildableContext(
        key: key,
        parentKey: targetId,
      ),
    );
  }
}

class AppWidgetRenderObject<T> extends RenderObject<T> {
  final Widget child;

  final BuildableContext buildableContext;

  AppWidgetRenderObject({
    required this.child,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.div,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    var targetElement = widgetObject.htmlElement.parent;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    targetElement.dataset.addAll({"wtype": "Target"});

    // insert framework's CSS styles

    Framework.insertStyles(GEN_STYLES_NORMALIZE_CSS);
    Framework.insertStyles(GEN_STYLES_MAIN_CSS);

    if (T.toString() == (RadApp).toString()) {
      Framework.insertStyles(GEN_STYLES_RAD_APP_CSS);
    }

    Framework.buildWidget(
      widget: child,
      parentContext: context,
    );
  }
}
