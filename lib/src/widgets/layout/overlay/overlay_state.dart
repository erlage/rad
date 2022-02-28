import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/layout/overlay/overlay_entry.dart';

class OverlayState {
  final WidgetObject widgetObject;

  OverlayState(this.widgetObject);

  insert(OverlayEntry overlayEntry) {
    Framework.renderSingleChildWidget(
      widget: overlayEntry,
      context: widgetObject.context,
      append: true,
    );
  }

  insertAll(List<OverlayEntry> entries) {
    Framework.buildMultipleChildWidgets(
      widgets: entries,
      context: widgetObject.context,
      append: true,
    );
  }
}
