import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/types.dart';

/// A widget that does not require mutable state.
///
abstract class StatelessWidget extends Widget {
  const StatelessWidget({String? id}) : super(id);

  /// Describes the part of the user interface represented by this widget.
  ///
  Widget build(BuildContext context);

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => "$StatelessWidget";

  @override
  createRenderObject(context) {
    return StatelessWidgetRenderObject(
      context: context,
      widgetBuilder: build,
    );
  }
}

class StatelessWidgetRenderObject extends RenderObject {
  final WidgetBuilderCallback widgetBuilder;

  StatelessWidgetRenderObject({
    required this.widgetBuilder,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    var widget = widgetBuilder(context);

    Framework.buildChildren(
      widgets: [widget],
      parentContext: context,
    );
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant StatelessWidgetRenderObject updatedRenderObject,
  ) {
    var widget = updatedRenderObject.widgetBuilder(updatedRenderObject.context);

    Framework.updateChildren(
      widgets: [widget],
      updateType: updateType,
      parentContext: context,
    );
  }
}
