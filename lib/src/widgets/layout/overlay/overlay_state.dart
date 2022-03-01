import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/layout/overlay/overlay_entry.dart';

class OverlayState {
  final WidgetObject widgetObject;

  OverlayState(this.widgetObject);

  insert(OverlayEntry overlayEntry) {
    Framework.buildChildren(
      flagCleanParentContents: false,
      widgets: [overlayEntry],
      parentContext: widgetObject.context,
    );
  }

  insertAll(List<OverlayEntry> entries) {
    Framework.buildChildren(
      flagCleanParentContents: false,
      widgets: entries,
      parentContext: widgetObject.context,
    );
  }
}
