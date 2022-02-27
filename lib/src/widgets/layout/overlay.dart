import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
import 'package:rad/src/widgets/layout/overlay_entry.dart';

class Overlay extends Widget {
  final String? key;

  final String? style;

  final List<OverlayEntry> initialEntries;

  const Overlay({
    this.key,
    this.style,
    required this.initialEntries,
  });

  @override
  builder(context) {
    return OverlayRenderObject(
      style: style ?? '',
      initialEntries: initialEntries,
      buildableContext: context.mergeKey(key),
    );
  }
}

class OverlayRenderObject extends RenderObject<Overlay> {
  final String style;

  final List<OverlayEntry> initialEntries;

  final BuildableContext buildableContext;

  OverlayRenderObject({
    required this.style,
    required this.initialEntries,
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

    Framework.renderMultipleChildWidgets(
      context: context,
      widgets: initialEntries,
    );
  }
}
