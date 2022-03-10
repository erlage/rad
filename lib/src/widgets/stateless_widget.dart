import 'package:meta/meta.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';

/// A widget that does not require mutable state.
///
@immutable
abstract class StatelessWidget extends Widget {
  const StatelessWidget({String? id}) : super(id);

  /// Describes the part of the user interface represented by this widget.
  ///
  @protected
  Widget build(BuildContext context);

  /*
  |--------------------------------------------------------------------------
  | widget internals
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @override
  get concreteType => "$StatelessWidget";

  @nonVirtual
  @override
  get correspondingTag => DomTag.div;

  @nonVirtual
  @override
  createConfiguration() => _StatelessWidgetConfiguration(build);

  @nonVirtual
  @override
  isConfigurationChanged(oldConfiguration) => true;

  @nonVirtual
  @override
  createRenderObject(context) => _StatelessWidgetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _StatelessWidgetConfiguration extends WidgetConfiguration {
  final WidgetBuilderCallback widgetBuilder;

  const _StatelessWidgetConfiguration(this.widgetBuilder);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _StatelessWidgetRenderObject extends RenderObject {
  const _StatelessWidgetRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _StatelessWidgetConfiguration configuration,
  ) {
    Framework.buildChildren(
      widgets: [configuration.widgetBuilder(context)],
      parentContext: context,
    );
  }

  @override
  void update({
    required element,
    required updateType,
    required oldConfiguration,
    required covariant _StatelessWidgetConfiguration newConfiguration,
  }) {
    Framework.updateChildren(
      updateType: updateType,
      widgets: [newConfiguration.widgetBuilder(context)],
      parentContext: context,
    );
  }
}
