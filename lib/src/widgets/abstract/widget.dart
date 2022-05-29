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
  DomTag get correspondingTag;

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
  | configuration
  |--------------------------------------------------------------------------
  */

  /// Create widget's configuration.
  ///
  WidgetConfiguration createConfiguration() => const WidgetConfiguration();

  /// Whether configuration has changed.
  ///
  bool isConfigurationChanged(WidgetConfiguration oldConfiguration) => false;

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

/// Widget's configuration.
///
/// Widgets are responsible for extending this class if they want to pass around
/// their configuration during builds.
///
class WidgetConfiguration {
  const WidgetConfiguration();
}
