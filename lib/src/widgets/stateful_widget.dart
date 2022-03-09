import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget that has mutable state.
///
abstract class StatefulWidget extends Widget {
  const StatefulWidget({String? id}) : super(id);

  /// Creates the mutable state for this widget at a given location in the tree.
  ///
  State createState();

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => "$StatefulWidget";

  @override
  createRenderObject(context) => StatefulWidgetRenderObject(context);
}

abstract class State<T> {
  var _isRebuilding = false;

  T get widget => _widget!;
  T? _widget;

  BuildContext get context => _context!;
  BuildContext? _context;

  void bindContext(BuildContext context) {
    _context = context;
    _widget = _context!.widget as T;
  }

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Called when this widget is inserted into the tree.
  ///
  void initState() {}

  /// Describes the part of the user interface represented by this widget.
  ///
  Widget build(BuildContext context);

  void dispose() {}

  /// Notify the framework that the internal state of this widget has changed.
  ///
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

    Framework.updateChildren(
      widgets: [build(context)],
      updateType: UpdateType.setState,
      parentContext: context,
    );

    _isRebuilding = false;
  }

  /// Called whenever the widget configuration changes.
  ///
  void didUpdateWidget(T oldWidget) {}

  /*
  |--------------------------------------------------------------------------
  | delegated functionality handlers
  |--------------------------------------------------------------------------
  */

  void render(WidgetObject widgetObject) {
    Framework.buildChildren(
      widgets: [build(context)],
      parentContext: context,
    );
  }

  void update(
    UpdateType updateType,
    WidgetObject widgetObject,
    StatefulWidgetRenderObject updatedRenderObject,
  ) {
    var oldWidget = _widget!;

    bindContext(updatedRenderObject.context);

    didUpdateWidget(oldWidget);

    Framework.updateChildren(
      updateType: updateType,
      parentContext: context,
      widgets: [build(context)],
    );
  }
}

class StatefulWidgetRenderObject extends RenderObject {
  late final State state;

  StatefulWidgetRenderObject(BuildContext context) : super(context);

  @override
  void beforeMount() {
    state = (context.widget as StatefulWidget).createState()
      ..bindContext(context);
  }

  @override
  void afterMount() => state.initState();

  @override
  void didUpdateWidget(Widget oldWidget) => state.didUpdateWidget(oldWidget);

  @override
  render(widgetObject) => state.render(widgetObject);

  @override
  update(
    updateType,
    widgetObject,
    covariant StatefulWidgetRenderObject updatedRenderObject,
  ) {
    return state.update(updateType, widgetObject, updatedRenderObject);
  }

  @override
  void beforeUnMount() => state.dispose();
}
