import 'dart:html';
import 'package:meta/meta.dart';
import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// A widget that has mutable state.
///
@immutable
abstract class StatefulWidget extends Widget {
  const StatefulWidget({String? id}) : super(id);

  /// Creates the mutable state for this widget at a given location in the tree.
  ///
  @protected
  State createState(); // ignore: no_logic_in_create_state

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
  get correspondingTag => DomTag.div;

  @nonVirtual
  @override
  createConfiguration() => WidgetConfiguration();

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

  StatefulWidgetRenderObject({
    required this.state,
    required BuildContext context,
  }) : super(context);

  void updateHook(UpdateType updateType) {
    Framework.updateChildren(
      updateType: updateType,
      widgets: [state.build(context)],
      parentContext: context,
    );
  }

  @override
  render(element, configuration) {
    CommonProps.applyDataAttributes(element, {
      System.attrStateType: "${state.runtimeType}",
    });

    state
      ..frameworkBindContext(context)
      ..frameworkBindElement(element)
      ..frameworkBindUpdateHook(updateHook)
      ..initState();

    Framework.buildChildren(
      widgets: [state.build(context)],
      parentContext: context,
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
    if (state.frameworkIsBuildEnabled) {
      updateHook(updateType);
    }
  }

  @override
  beforeUnMount() => state.dispose();
}

/*
|--------------------------------------------------------------------------
| state
|--------------------------------------------------------------------------
*/
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
  @protected
  void didUpdateWidget(T oldWidget) {}

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

    _updateHook!(UpdateType.setState);

    _isRebuilding = false;
  }

  /*
  |--------------------------------------------------------------------------
  | for internal use
  |--------------------------------------------------------------------------
  */

  /// Whether build method is disabled.
  ///
  /// Used by internal framework widgets that uses Stateful widget but render
  /// widgets through Framework.x-api
  ///
  bool get frameworkIsBuildEnabled => true;

  Function(UpdateType type)? _updateHook;

  var _isRebuilding = false;

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
  void frameworkBindUpdateHook(Function(UpdateType type) updateHook) {
    _updateHook = updateHook;
  }
}
