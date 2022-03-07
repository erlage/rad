import 'dart:html';

import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/widgets/layout/overlay/overlay.dart';
import 'package:rad/src/widgets/layout/overlay/overlay_entry.dart';

class OverlayState {
  late final Overlay widget;
  late final HtmlElement element;
  late final BuildContext context;
  late final OverlayRenderObject renderObject;

  /*
  |--------------------------------------------------------------------------
  | api
  |--------------------------------------------------------------------------
  */

  insert(OverlayEntry overlayEntry) {
    Framework.buildChildren(
      flagCleanParentContents: false,
      widgets: [overlayEntry],
      parentContext: context,
    );
  }

  insertAll(List<OverlayEntry> entries) {
    Framework.buildChildren(
      flagCleanParentContents: false,
      widgets: entries,
      parentContext: context,
    );
  }

  /*
  |--------------------------------------------------------------------------
  | delegated functionality handlers
  |--------------------------------------------------------------------------
  */

  void render(WidgetObject widgetObject) {
    _initState(widgetObject);

    var styleProps = StyleProps(widget.styles);

    styleProps.apply(element);

    Framework.buildChildren(
      widgets: widget.initialEntries,
      parentContext: context,
    );
  }

  void update(
    UpdateType updateType,
    WidgetObject widgetObject,
    RenderObject updatedRenderObject,
  ) {
    Framework.manageChildren(
      parentContext: context,
      updateTypeWhenNecessary: updateType,
      widgetActionCallback: (_) => [WidgetAction.updateWidget],
    );
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  void _initState(WidgetObject widgetObject) {
    element = widgetObject.element;
    context = widgetObject.context;
    widget = widgetObject.widget as Overlay;
    renderObject = widgetObject.renderObject as OverlayRenderObject;
  }
}
