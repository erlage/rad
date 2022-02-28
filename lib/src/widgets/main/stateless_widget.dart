import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/build_context.dart';

/// A widget that does not require mutable state.
///
/// A stateless widget is a widget that describes static user interface.
///
/// Stateless widget are useful when the part of the user interface you are
/// describing does not depend on anything other than the configuration
/// information in the object itself and the [BuildContext] in which the widget
/// is inflated. For compositions that can change dynamically, e.g. due to
/// having an internal clock-driven state, or depending on some system state,
/// consider using [StatefulWidget].
///
/// See also:
///
///  * [StatefulWidget], A widget that has mutable state.
///
abstract class StatelessWidget extends Widget {
  final String? key;

  const StatelessWidget({this.key});

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method when this widget is inserted into the tree
  /// in a given [BuildContext].
  ///
  Widget build(BuildContext context);

  @override
  String get type => (StatelessWidget).toString();

  @override
  DomTag get tag => DomTag.div;

  @override
  builder(context) {
    var renderObject = StatelessWidgetRenderObject(context.mergeKey(key));

    renderObject.child = build(renderObject.context);

    return renderObject;
  }
}

class StatelessWidgetRenderObject extends RenderObject {
  late final Widget child;

  StatelessWidgetRenderObject(BuildContext context) : super(context);

  @override
  build(widgetObject) {
    Framework.buildChildren(widgets: [child], parentContext: context);
  }

  @override
  update(widgetObject, updatedRenderObject) {
    Framework.updateChildren(widgets: [child], parentContext: context);
  }
}
