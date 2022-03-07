import 'package:rad/rad.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/widget_object.dart';

abstract class SingleChildRenderObject extends RenderObject {
  final Widget child;

  SingleChildRenderObject(this.child, BuildContext context) : super(context);

  void beforeRender(WidgetObject widgetObject) {}

  void beforeUpdate(
    WidgetObject widgetObject,
    SingleChildRenderObject updatedRenderObject,
  ) {}

  @override
  render(widgetObject) {
    beforeRender(widgetObject);

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant SingleChildRenderObject updatedRenderObject,
  ) {
    beforeUpdate(widgetObject, updatedRenderObject);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      updateType: updateType,
      parentContext: context,
    );
  }
}
