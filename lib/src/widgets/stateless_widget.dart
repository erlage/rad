import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/types.dart';

/// A widget that does not require mutable state.
///
/// A stateless widget is a widget that describes static user interface.
///
/// Stateless widget are useful when the part of the user interface you are
/// describing does not depend on anything other than the configuration
/// information in the object itself and the [BuildContext] in which the widget
/// is inflated. For compositions that can change dynamically, e.g. due to
/// having an internal state, or depending on some system state, consider
/// using a [StatefulWidget].
///
/// See also:
///
///  * [StatefulWidget], A widget that has mutable state.
///
abstract class StatelessWidget extends Widget {
  final String? id;

  const StatelessWidget({this.id});

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method when this widget is inserted into the tree
  /// in a given [BuildContext].
  ///
  /// Avoid adding side effects into this method because Framework can call this
  /// method multiple times to get fresh state of interface.
  ///
  Widget build(BuildContext context);

  @override
  DomTag get tag => DomTag.div;

  @override
  String get initialId => id ?? System.idNotSet;

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
