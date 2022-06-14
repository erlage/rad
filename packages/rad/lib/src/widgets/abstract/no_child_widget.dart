import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Base class for widgets that has no child widgets.
///
abstract class NoChildWidget extends Widget {
  const NoChildWidget({super.key});

  @override
  shouldWidgetChildrenUpdate(oldWidget, shouldWidgetUpdate) => false;

  @override
  createRenderElement(parent) => NoChildRenderElement(this, parent);
}

/// No child render element.
///
class NoChildRenderElement extends RenderElement {
  NoChildRenderElement(super.widget, super.parent);

  @override
  List<Widget> get childWidgets => ccImmutableEmptyListOfWidgets;
}
