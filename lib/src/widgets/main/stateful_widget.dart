import 'dart:html';

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
/// clock-driven state, or depending on some system state.
///
/// [StatefulWidget] has three lifecycle methods and one state function
/// [setState].
///
/// Framework calls lifecycle methods on particular events,
///
/// 1. [initState] - called before widget build.
/// 2. [build] - called when framework decides to render widget
/// 3. [dispose] - called before framework disposes the widget.
///
/// It's responsibility of concrete implementation of [StatefulWidget]
/// to tell framework when to rebuild the interface. Apart from lifecycle
/// methods, there is a [setState] function which helps with that.
///
/// Please note that [setState] cascade rebuilds i.e it forces every child
/// widget to rebuild itself. Which means if you've any [StatefulWidget]
/// in child tree then it'll be disposed off and rebuilt.
///
///
/// This is a 'click to toggle' example:
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
/// See also:
///
///  * [StatelessWidget], for widgets that always build the same way given a
///    particular configuration.
///
/// # Performance consideration
///
/// A widget rebuild process involves rebuilding all child widgets. This is the
/// easiest way to ensure that all required childs are updated. It might sound
/// bad at first but Browsers are not bad at building webpages. After all that's
/// what they do. Choosing a simple rendering process removes a lot of complexity
/// both from the framework and [StatefulWidget].
///
/// Here's above example implemented in Flutter:
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
/// You can probably see a lot of biolerplate as compares to Rad's example.
/// Don't get me wrong, it's required in Flutter because Flutter has to render
/// widgets pixel by pixel and do the whole process multiple times in a second.
///
abstract class StatefulWidget extends Widget {
  final String? key;

  late final BuildContext context;
  late final StatefulWidgetRenderObject _renderObject;

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
  String get type => (StatefulWidget).toString();

  @override
  DomTag get tag => DomTag.div;

  @override
  buildRenderObject(context) =>
      StatefulWidgetRenderObject(context.mergeKey(key));

  @override
  void createState(RenderObject renderObject) {
    renderObject as StatefulWidgetRenderObject;

    context = renderObject.context;

    _renderObject = renderObject;

    _renderObject.dispose = dispose;

    initState();

    _renderObject.child = build(context);
  }
}

class StatefulWidgetRenderObject extends RenderObject {
  late final Widget child;
  late final VoidCallback dispose;

  StatefulWidgetRenderObject(BuildContext context) : super(context);

  @override
  build(widgetObject) {
    Framework.buildChildren(widgets: [child], parentContext: context);
  }

  @override
  update(widgetObject, updatedRenderObject) {
    Framework.updateChildren(widgets: [child], parentContext: context);
  }

  @override
  void beforeUnMount() {
    dispose();
  }
}
