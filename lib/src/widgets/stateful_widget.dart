import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateless_widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// A widget that has mutable state.
///
////// A stateful widget is a widget that describes dynamic user interface.
/// Stateful widgets are useful when the part of the user interface you are
/// describing can change dynamically, e.g. due to having an internal
/// state, or depending on some system state.
///
/// ## Performance consideration
///
/// * In worst case, a widget rebuild process involves cascading a update call to all child
///   widgets. Child widgets then can cascade update to their childs and so on. This case
///   usually doesn't happen but it's worth mentioning. Update process is optimized for
///   performance in worst case. A widget update do not cause a complete widget's rebuild.
///   Every widget will update it's DOM interface only if  its description has changed.
///
///
/// * Normally, having state at top-level of your application won't hurt performance.
///   But it's always better to have a your State at leaf nodes. Having less childs means,
///   updates can be dispatched and processed faster.
///
///
/// * Use const constructors where possible. Framework is capable of short-circuiting rebuild
///   process when it encounters a constant.
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
@immutable
abstract class StatefulWidget extends Widget {
  const StatefulWidget({String? key}) : super(key: key);

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
  get concreteType => "$StatefulWidget";

  @nonVirtual
  @override
  get correspondingTag => DomTag.division;

  @nonVirtual
  @override
  createConfiguration() => const WidgetConfiguration();

  @nonVirtual
  @override
  isConfigurationChanged(oldConfiguration) => true;

  @nonVirtual
  @override
  createRenderObject(context) => StatefulWidgetRenderObject(
        context: context,
        state: createState(),
      );
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class StatefulWidgetRenderObject extends RenderObject {
  final State state;

  const StatefulWidgetRenderObject({
    required this.state,
    required BuildContext context,
  }) : super(context);

  @override
  render(element, configuration) {
    CommonProps.applyDataAttributes(element, {
      System.attrStateType: "${state.runtimeType}",
    });

    state
      ..frameworkBindContext(context)
      ..frameworkBindElement(element)
      ..frameworkBindUpdateProcedure(updateProcedure)
      ..initState()
      ..didChangeDependencies();

    scheduler.addTask(
      WidgetsBuildTask(
        parentContext: context,
        widgets: [state.build(context)],
      ),
    );
  }

  @override
  afterWidgetRebind(updateType, covariant StatefulWidget oldWidget) {
    // widget rebinding rebinds widget instance in renderObject.context

    state
      ..frameworkUpdateContextBinding(context)
      ..didUpdateWidget(oldWidget);
  }

  @override
  update({
    required element,
    required updateType,
    required oldConfiguration,
    required newConfiguration,
  }) {
    if (UpdateType.dependencyChanged == updateType) {
      state.didChangeDependencies();
    }

    updateProcedure(updateType);
  }

  void updateProcedure(UpdateType updateType) {
    scheduler.addTask(
      WidgetsUpdateTask(
        parentContext: context,
        updateType: updateType,
        widgets: [state.build(context)],
      ),
    );
  }

  @override
  beforeUnMount() => state.frameworkDispose();
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
/// 1. [State.initState] - is called when framework decides to inflate the widget.
/// It's called exactly once during lifetime of this widget.
///
///
/// 2. [State.build] - is called when framework wants to build interface for widget.
/// Whatever interface(widgets) this method return will be built. Note that,
/// Framework can call this method multiple times to stay up-to-date with
/// widget's interface description.
///
///
/// 3. [State.dispose] - is called when framework is about to dispose widget and its
/// state.
///
/// Apart from three main hooks, [State] has two additional hooks that implementations
/// can override when needed. These are,
///
/// [State.didUpdateWidget] - Called whenever the widget configuration changes.
///
/// [State.didChangeDependencies]- Called when a dependency of this [State] object changes.
///
/// Apart from lifecycle hooks, there is a [State.setState] function which a widget
/// can use to tell framework to rebuild widget's interface because some
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
  T get widget => _widget!;

  HtmlElement? _element;
  HtmlElement get element => _element!;

  BuildContext? _context;
  BuildContext get context => _context!;

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Called when this widget is inserted into the tree.
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
  /// which means any calls to [setState] in [didChangeDependencies] are redundant.
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
    if (Debug.widgetLogs) {
      print("setState: $context");
    }

    if (_isRebuilding) {
      if (Debug.developmentMode) {
        print(
          "setState() called while widget was building. Usually happens when you call setState() in build()",
        );
      }

      return;
    }

    _isRebuilding = true;

    if (null != callable) {
      callable();
    }

    _updateProcedure!(UpdateType.setState);

    _isRebuilding = false;
  }

  /*
  |--------------------------------------------------------------------------
  | for internal use
  |--------------------------------------------------------------------------
  */

  Function(UpdateType type)? _updateProcedure;

  var _isRebuilding = false;

  /// Whether widget of current state object is rebuilding.
  ///
  bool get isRebuilding => _isRebuilding;

  @nonVirtual
  @protected
  void frameworkBindContext(BuildContext context) {
    frameworkUpdateContextBinding(context);
  }

  @nonVirtual
  @protected
  void frameworkUpdateContextBinding(BuildContext context) {
    _context = context;

    _widget = _context!.widget as T;
  }

  @nonVirtual
  @protected
  void frameworkBindElement(HtmlElement element) {
    _element = element;
  }

  @nonVirtual
  @protected
  void frameworkBindUpdateProcedure(Function(UpdateType type) updateProcedure) {
    _updateProcedure = updateProcedure;
  }

  @nonVirtual
  @protected
  void frameworkDispose() {
    dispose();
  }
}
