import 'package:meta/meta.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';

/// Describes the configuration for an [RenderObject].
///
@immutable
abstract class Widget {
  final String? _initialKey;

  const Widget(this._initialKey);

  /// key provided in widget constructor(if any)
  ///
  String get initialKey => _initialKey ?? System.contextKeyNotSet;

  /*
  |--------------------------------------------------------------------------
  | widget specific
  |--------------------------------------------------------------------------
  */

  /// widget's actual type
  ///
  String get concreteType;

  /// corresponding HTML tag to use to render this widget
  ///
  DomTag get correspondingTag;

  /// Child widgets if any.
  ///
  List<Widget> get widgetChildren => [];

  /*
  |--------------------------------------------------------------------------
  | configuration
  |--------------------------------------------------------------------------
  */

  /// Create widget's configuration.
  ///
  WidgetConfiguration createConfiguration();

  /// Whether configuration has changed.
  ///
  bool isConfigurationChanged(WidgetConfiguration oldConfiguration);

  /*
  |--------------------------------------------------------------------------
  | render object
  |--------------------------------------------------------------------------
  */

  /// Called when framework needs a [RenderObject] for current widget.
  ///
  RenderObject createRenderObject(BuildContext context);
}

class WidgetConfiguration {
  const WidgetConfiguration();
}
