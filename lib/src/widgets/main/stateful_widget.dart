import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';

/// A widget that has mutable state.
///
/// A stateful widget is a widget that describes dynamic user interface.
/// Stateful widgets are useful when the part of the user interface you are
/// describing can change dynamically, e.g. due to having an internal
/// state, or depending on some system state.
///
/// [StatefulWidget] has three lifecycle hooks and one state function
/// [setState].
///
/// Framework calls lifecycle hooks on particular events,
///
/// 1. [initState] - called when framework inlates the widget for the first time.
/// 2. [build] - called when framework decides to build widget and can be called multiple times.
/// 3. [dispose] - called before framework disposes off the widget.
///
/// It's responsibility of concrete implementation of [StatefulWidget]
/// to tell framework when to rebuild the interface. Apart from lifecycle
/// methods, there is a [setState] function which can be used for that.
///
/// ## Performance consideration
///
/// * A widget rebuild process involves cascading a update call to all child widgets.
///   Child widgets then can cascade update to their childs and so on.
///
///
/// * Having state at top-level of your application won't hurt you much(in most cases)
///   but It's always better to have a your State at leaf nodes. Having less childs means,
///   updates can be dispatched and processed faster.
///
///
/// * Update process is optimized for performance. Widget updates do not cause a
///   complete rebuild of widget, instead widgets will update their parts that might be
///   affected by its parent'state change.
///
///
/// * Widgets that has internal state such as [StatefulWidget] and [Overlay] won't
///   listen to state changes in their parents. This means [setState] in a parent widget
///   will not affect any [StatefulWidget] that's in subtree(a child). A stateful child
///   also stops propagation of update call further down the tree because it's not required
///   at this point.
///
///
/// * There are cases where child widgets has to rebuild themselves from scratch. Complete
///   rebuild involves disposing off current childs and rebuilding new ones with new state.
///   Usually happens when child that framework is looking for is not there anymore because
///   of state change in parent.
///   Rebuilds might be bad if Rad has to render pixel multiple times a second. Luckly in Rad
///   framework, building and updating interface is a one-step process. Framework handles the
///   description of widgets(which is always available) and browser handles the building process
///   because browsers are not bad at building pages. After all that's what they do.
///
///
/// ## A Stateful widget example: 'click to toggle'
///
/// ```dart
/// class ClickTest extends StatefulWidget {
///   bool isClicked = false;
///
///   @override
///   Widget build(BuildContext context) {
///     return GestureDetector(
///       onTap: handleTap,
///       child: Text(isClicked ? "on! click to turn off." : "click to turn on."),
///     );
///   }
///
///   handleTap() {
///     setState(() {
///       isClicked = !isClicked;
///     });
///   }
/// }
/// ```
///
/// ## Same 'click to toggle' example using Flutter:
///
/// ```
/// class ClickToggle extends StatefulWidget {
///
///   @override
///   _ClickToggleState createState() => _ClickToggleState();
/// }
///
/// class _ClickToggleState extends State<ClickToggle> {
///   bool isClicked = false;
///
///   @override
///   Widget build(BuildContext context) {
///     return GestureDetector(
///       onTap: _handleTap,
///       child: Text(isClicked ? "on! click to turn off." : "click to turn on."),
///     );
///   }
///
///   _handleTap() {
///     setState(() {
///       isClicked = !isClicked;
///     });
///   }
/// }
/// ```
///
/// See also:
///
///  * [StatelessWidget], for widgets that always build the same way given a
///    particular configuration.
///
abstract class StatefulWidget extends Widget {
  final String? key;

  late final BuildContext context;

  var _isRebuilding = false;

  StatefulWidget({this.key});

  /// Called when this widget is inserted into the tree.
  ///
  /// The framework will call this method exactly once.
  ///
  /// Override this method to perform initialization that depends on the
  /// location at which this object was inserted into the tree (i.e., [context])
  ///
  void initState() {}

  /// Describes the part of the user interface represented by this widget.
  ///
  /// The framework calls this method in a number of different situations. For
  /// example:
  ///
  ///  * After calling [initState].
  ///  * After receiving a call to [setState] in current widget or in parents.
  ///
  /// this method should not have any side effects beyond building a widget.
  ///
  Widget build(BuildContext context);

  /// Notify the framework that the internal state of this widget has changed.
  ///
  /// The provided callback is immediately called synchronously. It must not
  /// return a future (the callback should not be `async`), since then it would be
  /// unclear when the state was actually being set.
  ///
  /// Calling [setState] notifies the framework that the internal state of this
  /// widget has changed in a way that might impact the user interface in this
  /// subtree, which causes the framework to rebuild this widget.
  ///
  void setState(VoidCallback? callable) {
    if (_isRebuilding) {
      throw "setState() called while widget was building. Usually happens when you call setState() in build()";
    }

    _isRebuilding = true;

    if (null != callable) {
      callable();
    }

    Framework.updateChildren(widgets: [build(context)], parentContext: context);

    _isRebuilding = false;
  }

  void dispose() {}

  @override
  DomTag get tag => DomTag.div;

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  String get type => (StatefulWidget).toString();

  @override
  onContextCreate(BuildContext context) {
    this.context = context;

    initState();
  }

  @override
  buildRenderObject(context) {
    return StatefulWidgetRenderObject(
      context: context,
      child: build(context),
    );
  }

  @override
  onRenderObjectCreate(renderObject) {
    renderObject as StatefulWidgetRenderObject;

    renderObject.dispose = dispose;
  }
}

class StatefulWidgetRenderObject extends RenderObject {
  final Widget child;
  late final VoidCallback dispose;

  StatefulWidgetRenderObject({
    required this.child,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    Framework.buildChildren(widgets: [child], parentContext: context);
  }

  @override
  update(widgetObject, updatedRenderObject) {
    //
    // Widgets that has internal state such as StatefulWidget and Overylay
    // don't listen to changes in outer objects.
    //
    // Only way to change state of a StatefulWidget is to dispose it off
    // and create a new one or if widget itself calls a setState()
    //
  }

  @override
  void beforeUnMount() {
    dispose();
  }
}
