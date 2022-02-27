import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/buildable_context.dart';

class OverlayEntry extends Widget {
  final String? key;

  final Widget child;
  final String? style;

  const OverlayEntry({
    this.key,
    this.style,
    required this.child,
  });

  @override
  builder(context) {
    return OverlayEntryRenderObject(
      child: child,
      style: style ?? '',
      buildableContext: context.mergeKey(key),
    );
  }
}

class OverlayEntryRenderObject extends RenderObject<OverlayEntry> {
  final Widget child;
  final String style;

  final BuildableContext buildableContext;

  OverlayEntryRenderObject({
    required this.child,
    required this.style,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.div,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className = style;
    }

    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }
}
