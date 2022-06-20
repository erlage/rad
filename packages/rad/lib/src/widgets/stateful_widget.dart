import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/tasks/stimulate_listener_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/include/foundation/change_notifier.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateless_widget.dart';

/// A widget that has mutable state.
///
/// A stateful widget is a widget that describes dynamic user interface.
/// Stateful widgets are useful when the part of the user interface you are
/// describing can change dynamically, e.g. due to having an internal
/// state, or depending on some system state.
///
/// ## Performance consideration
///
///   Rad uses a extremely lightweight yet powerful mechanism to build and
///   update DOM. Below are some general tips along with high level
///   understanding of how things works under the hood:
///
///
/// * Use const constructors where possible.
///
///
/// * Push the state to the leaves.
///   Having state at top level of application is acceptable as well but it's
///   worth noting that having less childs to update means updates can be
///   dispatched and processed faster.
///
///
/// * In worst case, framework rebuild widgets from scratch. Complete rebuild
///   involves disposing off current childs and rebuilding new ones with new
///   state. Usually happens when child that framework is looking for is not
///   there anymore because of state change in parent. Rebuilds might be bad if
///   Rad has to render pixel multiple times a second. Luckly in Rad, building
///   and updating interface is a one-step process. Framework handles the
///   description of widgets and building process is carried out by the browser.
///   We can rely on browsers for building big parts of tree when needed.
///   After all that's what they do. By widget description, we mean 'data'
///   that's required to build a widget. This means even if you remove child
///   nodes/or part of DOM tree using browser inspector, calling setState() in a
///   parent widget will bring back everything back in DOM.
///
///
/// * And for mission critical situations, you have [shouldUpdateWidget] at
///   your disposal on every widget. If you know that in some situations your
///   widget doesn’t need to update, you can return false from
///   [shouldUpdateWidget] instead, to skip the whole rendering process.
///   But remember maintaining [shouldUpdateWidget] is hard so it's not
///   something you should be using everywhere.
///
///
/// ## A Stateful widget example: 'click to toggle'
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
///       child: Text(
///         isClicked
///             ? "on! click to turn off."
///             : "click to turn on."
///         ),
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
@immutable
abstract class StatefulWidget extends Widget {
  const StatefulWidget({Key? key}) : super(key: key);

  /// Creates the mutable state for this widget at a given location in the tree.
  ///
  @protected
  State createState();

  /*
  |--------------------------------------------------------------------------
  | widget internals
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @override
  String get widgetType => 'StatefulWidget';

  @nonVirtual
  @override
  DomTagType? get correspondingTag => null;

  @override
  bool shouldUpdateWidget(oldWidget) => true;

  /// Overriding this method on [StatefulWidget] can result in unexpected
  /// behavior as [StatefulWidget] build its childs from its state. If you don't
  /// want the [StatefulWidget] to update its child widgets, override
  /// [shouldUpdateWidget] instead.
  ///
  @nonVirtual
  @override
  bool shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) => false;

  @override
  createRenderElement(parent) => StatefulRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// StatefulWidget's render element.
///
class StatefulRenderElement extends RenderElement {
  /// Associated state of stateful widget.
  ///
  final State state;

  StatefulRenderElement(
    StatefulWidget widget,
    RenderElement parent,
  )   : state = widget.createState(),
        super(widget, parent);

  @override
  List<Widget> get childWidgets => ccImmutableEmptyListOfWidgets;

  @override
  init() {
    state
      ..frameworkBindWidget(widget)
      ..frameworkBindRenderElement(this);
  }

  @override
  void afterMount() {
    state
      ..initState()
      ..didChangeDependencies();

    services.scheduler.addTask(
      WidgetsBuildTask(
        parentRenderElement: this,
        widgets: [state.build(this)],
      ),
    );
  }

  // we build child of stateful widget after mount so that users can call
  // any method from context.* inside build method

  @override
  afterWidgetRebind({
    required updateType,
    required covariant StatefulWidget newWidget,
    required covariant StatefulWidget oldWidget,
  }) {
    state
      ..frameworkRebindWidget(newWidget)
      ..didUpdateWidget(oldWidget);
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required newWidget,
  }) {
    if (UpdateType.dependencyChanged == updateType) {
      state.didChangeDependencies();
    }

    services.scheduler.addTask(
      WidgetsUpdateTask(
        parentRenderElement: this,
        widgets: [state.build(this)],
        updateType: updateType,
      ),
    );

    return null;
  }

  @override
  beforeUnMount() => state.dispose();
}

/*
|--------------------------------------------------------------------------
| state
|--------------------------------------------------------------------------
*/

/// The logic and internal state for a [StatefulWidget].
///
/// [State] has three main lifecycle hooks and one state function
/// [setState].
///
/// Framework calls lifecycle hooks on particular events,
///
///
/// 1. [State.initState] - is called when framework decides to inflate the
/// widget.
/// It's called exactly once during lifetime of this widget.
///
///
/// 2. [State.build] - is called when framework wants to build interface for
/// widget.
/// Whatever interface(widgets) this method return will be built. Note that,
/// Framework can call this method multiple times to stay up-to-date with
/// widget's interface description.
///
///
/// 3. [State.dispose] - is called when framework is about to dispose widget and
/// its state.
///
///
/// Apart from three main hooks, [State] has two additional hooks that
/// implementations can override when needed. These are,
///
///
/// [State.didUpdateWidget] - Called whenever the widget configuration changes.
///
///
/// [State.didChangeDependencies]- Called when a dependency of this [State]
/// object changes.
///
///
/// Apart from lifecycle hooks, there is a [State.setState] function which a
/// widget can use to tell framework to rebuild widget's interface because some
/// internal state of this widget has changed.
///
/// It's responsibility of concrete implementation of [StatefulWidget]
/// to tell framework when to rebuild the interface using [State.setState]
///
abstract class State<T extends StatefulWidget> {
  /*
  |--------------------------------------------------------------------------
  | useful getters
  |--------------------------------------------------------------------------
  */

  T? _widget;

  /// The current configuration.
  ///
  /// A [State] object's configuration is the corresponding [StatefulWidget]
  /// instance. This property is initialized by the framework before calling
  /// [initState]. If the parent updates this location in the tree to a new
  /// widget with the same [runtimeType] and key as the current
  /// configuration, the framework will update this property to refer to the new
  /// widget and then call [didUpdateWidget], passing the old configuration as
  /// an argument.
  ///
  T get widget {
    if (null == _widget) {
      throw Exception(
        'State.widget instance cannot be accessed in state constructor. Please '
        'use initState hook to initialize the state that depends on widget or '
        'consider canceling any active work during "dispose" or using the '
        '"mounted" getter to determine if the State is still active.',
      );
    }

    return _widget!;
  }

  /// Render element.
  ///
  StatefulRenderElement? _element;

  /// The location in the tree where this widget builds.
  ///
  /// The framework associates [State] objects with a [BuildContext] after
  /// creating them with [StatefulWidget.createState] and before calling
  /// [initState]. The association is permanent: the [State] object will never
  /// change its [BuildContext]. However, the [BuildContext] itself can be moved
  /// around the tree.
  ///
  /// After calling [dispose], the framework severs the [State] object's.
  ///
  /// connection with the [BuildContext].
  ///
  BuildContext get context {
    if (null == _element) {
      throw Exception(
        'State.context instance cannot be accessed in a state constructor. '
        'Please use initState hook to initialize the state that depends on '
        'context or consider canceling any active work during "dispose". You '
        'can also use "mounted" getter to determine if context is available.',
      );
    }

    return _element!;
  }

  /// Whether this [State] object is currently in a tree.
  ///
  /// After creating a [State] object and before calling [initState], the
  /// framework "mounts" the [State] object by associating it with a
  /// [BuildContext]. The [State] object remains mounted until the framework
  /// calls [dispose], after which time the framework will never ask the [State]
  /// object to [build] again.
  ///
  /// It is an error to call [setState] unless [mounted] is true.
  ///
  bool get mounted => null != _element;

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Called when this widget is inserted into the tree.
  ///
  /// Override this method to perform initialization that depends on the
  /// location at which this object was inserted into the tree (i.e., [context])
  /// or on the widget used to configure this object (i.e., [widget]).
  ///
  /// If a [State]'s [build] method depends on an object that can itself
  /// change state, for example a [ChangeNotifier] or [Stream], or some
  /// other object to which one can subscribe to receive notifications, then
  /// be sure to subscribe and unsubscribe properly in [initState],
  /// [didUpdateWidget], and [dispose]:
  ///
  ///  * In [initState], subscribe to the object.
  ///  * In [didUpdateWidget] unsubscribe from the old object and subscribe
  ///    to the new one if the updated widget configuration requires
  ///    replacing the object.
  ///  * In [dispose], unsubscribe from the object.
  ///
  @protected
  void initState() {}

  /// Describes the part of the user interface represented by this widget.
  ///
  @protected
  Widget build(BuildContext context);

  @protected
  void dispose() {}

  /// Called whenever the widget configuration changes.
  ///
  /// If the parent widget rebuilds and request that this location in the tree
  /// update to display a new widget with the same [runtimeType], the framework
  /// will update the [widget] property of this [State] object to refer to the
  /// new widget and then call this method with the previous widget as an
  /// argument.
  ///
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which
  /// means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which
  /// means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  @protected
  void didUpdateWidget(T oldWidget) {}

  /// Called when a dependency of this [State] object changes.
  ///
  /// For example, if the previous call to [build] referenced an
  /// [InheritedWidget] that later changed, the framework would call this
  /// method to notify this object about the change. This method is also
  /// called immediately after [initState].
  ///
  /// The framework always calls [build] after calling [didChangeDependencies],
  /// which means any calls to [setState] in [didChangeDependencies] are
  /// redundant.
  ///
  @protected
  void didChangeDependencies() {}

  /*
  |--------------------------------------------------------------------------
  | methods
  |--------------------------------------------------------------------------
  */

  /// Notify the framework that the internal state of this widget has changed.
  ///
  @nonVirtual
  @protected
  void setState(VoidCallback? callable) {
    var element = _element!;
    var scheduler = element.services.scheduler;

    scheduler.addTask(
      StimulateListenerTask(
        beforeTaskCallback: () {
          if (null != callable) {
            callable();
          }
        },
        afterTaskCallback: () {
          // this is wrapped in a another task to defer the call to build().
          scheduler.addTask(
            WidgetsUpdateTask(
              parentRenderElement: element,
              updateType: UpdateType.setState,
              widgets: [build(element)],
            ),
          );
        },
      ),
    );
  }

  /*
  |--------------------------------------------------------------------------
  | for internal use
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @protected
  void frameworkBindRenderElement(StatefulRenderElement element) {
    if (null != _element) {
      throw Exception(Constants.coreError);
    }

    _element = element;
  }

  @nonVirtual
  @protected
  void frameworkBindWidget(Widget widget) {
    if (null != _widget) {
      throw Exception(Constants.coreError);
    }

    _widget = widget as T;
  }

  @nonVirtual
  @protected
  void frameworkRebindWidget(Widget newWidget) {
    _widget = newWidget as T;
  }

  @nonVirtual
  @protected
  void frameworkDispose() {
    dispose();
  }
}
