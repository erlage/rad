import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Base class for widgets that efficiently propagate information down the tree.
///
/// To obtain the nearest instance of a particular type of inherited widget from
/// a build context, use [BuildContext.dependOnInheritedWidgetOfExactType].
///
/// Inherited widgets, when referenced in this way, will cause the consumer to
/// rebuild when the inherited widget itself changes state.
///
@immutable
abstract class InheritedWidget extends Widget {
  final Widget child;

  const InheritedWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// Whether the framework should notify widgets that inherit from this widget.
  ///
  /// When this widget is rebuilt, sometimes we need to rebuild the widgets that
  /// inherit from this widget but sometimes we do not. For example, if the data
  /// held by this widget is the same as the data held by `oldWidget`, then we
  /// do not need to rebuild the widgets that inherited the data held by
  /// `oldWidget`.
  ///
  /// The framework distinguishes these cases by calling this function with the
  /// widget that previously occupied this location in the tree as an argument.
  /// The given widget is guaranteed to have the same [runtimeType] as this
  /// object.
  ///
  @protected
  bool updateShouldNotify(covariant InheritedWidget oldWidget);

  /*
  |--------------------------------------------------------------------------
  | widget internals
  |--------------------------------------------------------------------------
  */

  @override
  List<Widget> get widgetChildren => [child];

  @nonVirtual
  @override
  String get widgetType => 'InheritedWidget';

  @nonVirtual
  @override
  DomTagType? get correspondingTag => null;

  @nonVirtual
  @override
  createConfiguration() => _InheritedWidgetConfiguration(this);

  @nonVirtual
  @override
  isConfigurationChanged(oldConfiguration) => true;

  @nonVirtual
  @override
  createRenderObject(context) => InheritedWidgetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _InheritedWidgetConfiguration extends WidgetConfiguration {
  final InheritedWidget widget;

  const _InheritedWidgetConfiguration(this.widget);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class InheritedWidgetRenderObject extends RenderObject {
  final dependents = <String, BuildContext>{};

  InheritedWidgetRenderObject(BuildContext context) : super(context);

  void addDependent(BuildContext dependentContext) {
    var dependentKeyValue = dependentContext.key.value;

    if (!dependents.containsKey(dependentKeyValue)) {
      dependents[dependentKeyValue] = dependentContext;
    }
  }

  @override
  update({
    required updateType,
    required covariant _InheritedWidgetConfiguration oldConfiguration,
    required covariant _InheritedWidgetConfiguration newConfiguration,
  }) {
    var updateShouldNotify = newConfiguration.widget.updateShouldNotify(
      oldConfiguration.widget,
    );

    if (updateShouldNotify) {
      var schedulerService = ServicesRegistry.instance.getScheduler(context);

      dependents.forEach((widgetKey, widgetContext) {
        schedulerService.addTask(
          WidgetsUpdateDependentTask(
            widgetContext: widgetContext,
          ),
        );
      });
    }

    // inherited widget's dom node's description never changes.
    return null;
  }
}
