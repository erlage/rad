import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/types.dart';

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
/// 1. [initState] - is called when framework decides to inflate the widget.
/// It's called exactly once during lifetime of this widget.
///
///
/// 2. [build] - is called when framework wants to build interface for widget.
/// Whatever interface(widgets) this method return will be built. Note that,
/// Framework can call this method multiple times to stay up-to-date with
/// widget's interface description.
///
///
/// 3. [dispose] - is called when framework is about to dispose widget and its
/// state.
///
/// Apart from lifecycle hooks, there is a [setState] function which a widget
/// can use to tell framework to rebuild widget's interface because some
/// internal state of this widget has changed.
///
/// It's responsibility of concrete implementation of [StatefulWidget]
/// to tell framework when to rebuild the interface using [setState]
///
/// There's one special hook that get's called when [setState] happens in parent tree
/// or when Framework wants a update to widget its interface because something has changed
/// in parent tree.
/// By default [StatefulWidget] will ignore update calls. This can be controlled by overriding
/// [rebuildOnUpdate] hook.
/// This hook helps a when you've a StatefulWidget in a Navigator's page, and you want to
/// rebuild that widget when user comes back from a different page. Returning true from
/// [rebuildOnUpdate] hook will make sure that end user isn't looking at a stalled interface.
///
/// ## Performance consideration
///
/// * A widget rebuild process involves cascading a update call to all child widgets.
///   Child widgets then can cascade update to their childs and so on.
///
///
/// * Update process is optimized for performance. A widget update do not cause a
///   complete widget's rebuild. Every widget will update it's DOM interface only if its
///   description has changed.
///
///
/// * Having state at top-level of your application won't hurt performance(in most cases)
///   but it's always better to have a your State at leaf nodes. Having less childs means,
///   updates can be dispatched and processed faster.
///
///
/// * Widgets that has internal state such as [StatefulWidget] doesn't listen to all update
///   or all state changes in their parents(except for few exceptions such as Navigator open).
///   This in general, means that [setState] in a parent widget will not affect any
///   [StatefulWidget] that's in subtree(a child). A stateful child also stops propagation
///   of update call further down the tree because it's not required at this point. This
///   behaviour can be changed by overiding [rebuildOnUpdate] method.
///
///
/// * There are cases where child widgets has to rebuild themselves from scratch. Complete
///   rebuild involves disposing off current childs and rebuilding new ones with new state.
///   Usually happens when child that framework is looking for is not there anymore because
///   of state change in parent.
///   Rebuilds might be bad if Rad has to render pixel multiple times a second. Luckly in Rad
///   framework, building and updating interface is a one-step process. Framework handles the
///   description of widgets and building process is carried out by the browser. We can rely
///   on browsers for building big parts of tree when needed. After all that's what they do.
///   By widget description, we mean 'data' that's required to build a widget. This means even
///   if you remove child nodes/or part of DOM tree using browser inspector, calling setState()
///   in a parent widget will bring back everything back in DOM.
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
  final String? id;

  late final BuildContext context;

  var _isRebuilding = false;

  /// Whether to rebuild widget when a state change happens in parent tree.
  /// or when Framework calls for update.
  ///
  /// By default [StatefulWidget] ignore all updates except from Navigator.
  /// This can be turned on by overriding [rebuildOnUpdate] method.
  ///
  /// Rebuilding won't lead to state loose instead Framework will calls
  /// [build] method to get up-to-date interface and rebuild parts of interface
  /// that are required.
  ///
  bool rebuildOnUpdate(UpdateType updateType) {
    return UpdateType.navigatorOpen == updateType;
  }

  StatefulWidget({this.id});

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

    Framework.updateChildren(
      widgets: [build(context)],
      updateType: UpdateType.setState,
      parentContext: context,
    );

    _isRebuilding = false;
  }

  void dispose() {}

  @override
  DomTag get tag => DomTag.div;

  @override
  String get initialId => id ?? System.idNotSet;

  @override
  String get type => "$StatefulWidget";

  @override
  onContextCreate(BuildContext context) {
    this.context = context;
  }

  @override
  createRenderObject(context) {
    return StatefulWidgetRenderObject(
      context: context,
      widgetBuilder: build,
    );
  }

  @override
  onRenderObjectCreate(covariant StatefulWidgetRenderObject renderObject) {
    renderObject.dispose = dispose;
    renderObject.initState = initState;
    renderObject.rebuildOnUpdate = rebuildOnUpdate;
  }
}

class StatefulWidgetRenderObject extends RenderObject {
  final WidgetBuilderCallback widgetBuilder;
  late final VoidCallback initState;
  late final VoidCallback dispose;
  late final UpdateTypeCallback rebuildOnUpdate;

  StatefulWidgetRenderObject({
    required this.widgetBuilder,
    required BuildContext context,
  }) : super(context);

  @override
  void afterMount() => initState();

  @override
  render(widgetObject) {
    var widget = widgetBuilder(context);

    Framework.buildChildren(widgets: [widget], parentContext: context);
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant StatefulWidgetRenderObject updatedRenderObject,
  ) {
    if (rebuildOnUpdate(updateType)) {
      var widget = widgetBuilder(context);

      Framework.updateChildren(
        widgets: [widget],
        updateType: updateType,
        parentContext: context,
      );
    }
  }

  @override
  void beforeUnMount() => dispose();
}
