import 'package:trad/css/main.gen.dart';
import 'package:trad/css/trad_app.gen.dart';
import 'package:trad/css/include/normalize.gen.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/classes/framework.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/widgets/main/trad_app.dart';

abstract class AppWidget<T> implements Widget {
  final String? key;

  final Widget child;
  final String targetId;

  AppWidget({
    this.key,
    required this.child,
    required this.targetId,
  }) {
    Framework.init();

    Framework.buildFromRenderObject(
      AppWidgetRenderObject<T>(
        child: child,
        buildableContext: BuildableContext(
          key: key,
          parentKey: targetId,
        ),
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

    Framework.insertStyles(GEN_STYLES_NORMALIZE_CSS + " " + GEN_STYLES_MAIN_CSS);

    if (T.toString() == (TradApp).toString()) {
      Framework.insertStyles(GEN_STYLES_TRAD_APP_CSS);
    }

    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }
}
