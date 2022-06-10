import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';

/// Describes the configuration for an [RenderObject].
///
@immutable
abstract class Widget {
  final Key initialKey;

  /*
  |--------------------------------------------------------------------------
  | widget specific getters
  |--------------------------------------------------------------------------
  */

  /// Type of widget.
  ///
  /// A widget implementation should override it, only when it's not overridden
  /// by superclass.
  ///
  String get widgetType;

  /// Corresponding HTML tag to use to render this widget
  ///
  DomTagType? get correspondingTag;

  /// Child widgets if any.
  ///
  List<Widget> get widgetChildren => const [];

  /// Events that this widget is listening to.
  ///
  Map<DomEventType, EventCallback?> get widgetEventListeners => const {};

  /// Events that this widget is listening to in capturing phase.
  ///
  Map<DomEventType, EventCallback?> get widgetCaptureEventListeners => const {};

  /*
  |--------------------------------------------------------------------------
  | constructor
  |--------------------------------------------------------------------------
  */

  const Widget({Key? key}) : initialKey = key ?? Constants.contextKeyNotSet;

  /*
  |--------------------------------------------------------------------------
  | widget configuration methods
  |--------------------------------------------------------------------------
  */

  /// Whether to update current widget.
  ///
  ///
  /// Framework calls this method on new widget, when new widget matches with a
  /// old widget,to check whether old widget need to update. This method should
  /// contain the logic to compare new widget with old.
  ///
  ///
  /// Diffing proccess will always call [shouldWidgetUpdate] on child widgets
  /// of current widget even if [shouldWidgetUpdate] return false. This means
  /// whatever diffing logic is present in this method, its scope should be
  /// limited to checking just the current widget. If a widget want to
  /// short-circuit diffing proccess(i.e no [shouldWidgetUpdate] on child
  /// widgets) then it can override [shouldWidgetChildrenUpdate] method.
  ///
  bool shouldWidgetUpdate(Widget oldWidget);

  /// Whether to update current widget's children.
  ///
  /// Framwork will always call this method after calling [shouldWidgetUpdate]
  /// along with results of call to [shouldWidgetUpdate] on current widget.
  ///
  /// If current widget knows in advance whether widgets below it
  /// doesn't need to update then it can override this method and return
  /// false which will short-circuit the diffing proccess.
  ///
  bool shouldWidgetChildrenUpdate(Widget oldWidget, bool shouldWidgetUpdate) {
    return true;
  }

  /*
  |--------------------------------------------------------------------------
  | render object
  |--------------------------------------------------------------------------
  */

  /// Called when framework needs a [RenderObject] for current widget.
  ///
  RenderObject createRenderObject(BuildContext context) {
    return RenderObject(context);
  }
}
