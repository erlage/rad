import 'package:rad/rad.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/widget_object.dart';

abstract class MultiChildRenderObject extends RenderObject {
  final List<Widget> children;

  MultiChildRenderObject(this.children, BuildContext context) : super(context);

  void beforeRender(WidgetObject widgetObject) {}

  void beforeUpdate(
    WidgetObject widgetObject,
    MultiChildRenderObject updatedRenderObject,
  ) {}

  @override
  render(widgetObject) {
    beforeRender(widgetObject);

    if (children.isNotEmpty) {
      Framework.buildChildren(
        widgets: children,
        parentContext: context,
      );
    }
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant MultiChildRenderObject updatedRenderObject,
  ) {
    beforeUpdate(widgetObject, updatedRenderObject);

    if (updatedRenderObject.children.isNotEmpty) {
      Framework.updateChildren(
        widgets: updatedRenderObject.children,
        updateType: updateType,
        parentContext: context,
      );
    }
  }
}
