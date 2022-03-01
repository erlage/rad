import 'package:rad/src/core/constants.dart';
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
/// having an internal state, or depending on some system state, consider
/// using a [StatefulWidget].
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
  /// Avoid adding side effects into this method because Framework can call this
  /// method multiple times to get fresh state of interface.
  ///
  Widget build(BuildContext context);

  @override
  DomTag get tag => DomTag.div;

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  String get type => (StatelessWidget).toString();

  @override
  buildRenderObject(context) {
    return StatelessWidgetRenderObject(
      context: context,
      props: StatelessWidgetProps(build(context)),
    );
  }
}

class StatelessWidgetProps {
  final Widget child;

  StatelessWidgetProps(this.child);
}

class StatelessWidgetRenderObject extends RenderObject {
  StatelessWidgetProps props;

  StatelessWidgetRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    Framework.buildChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as StatelessWidgetRenderObject;

    switchProps(updatedRenderObject.props);

    Framework.updateChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  void switchProps(StatelessWidgetProps props) {
    this.props = props;
  }
}
