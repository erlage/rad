// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/ds/reverse_set.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/extensions.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/services/scheduler/tasks/aggregate_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
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
  /// Child widget.
  ///
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

  @nonVirtual
  @override
  DomTagType? get correspondingTag => null;

  @override
  shouldUpdateWidget(oldWidget) => true;

  @nonVirtual
  @override
  createRenderElement(parent) => InheritedRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Inherited widget's render element.
///
@internal
class InheritedRenderElement extends RenderElement {
  /// List of dependents.
  ///
  final _dependents = ReverseSet<RenderElement>();

  InheritedRenderElement(super.widget, super.parent);

  @override
  List<Widget> get widgetChildren => [(widget as InheritedWidget).child];

  @override
  void register() {
    addRenderEventListeners({
      RenderEventType.didUpdate: _didUpdateHandler,
    });
  }

  var _previousUpdateShouldNotify = false;
  void _didUpdateHandler(_) {
    _dependents.removeWhere((e) => e.frameworkIsDetached);

    if (_previousUpdateShouldNotify) {
      var widgetUpdateDependentTasks = <WidgetsUpdateDependentTask>[];
      for (final dependent in _dependents.toIterable()) {
        widgetUpdateDependentTasks.add(
          WidgetsUpdateDependentTask(dependentRenderElement: dependent),
        );
      }

      var frameworkInstance = frameworkServices.framework;
      var task = AggregateTask(tasksToProcess: widgetUpdateDependentTasks);
      frameworkInstance.processTask(task);
    }
  }

  void addDependent(BuildContext dependentContext) {
    dependentContext as RenderElement;
    _dependents.add(dependentContext);
  }

  @override
  update({
    required updateType,
    required covariant InheritedWidget oldWidget,
    required covariant InheritedWidget newWidget,
  }) {
    _previousUpdateShouldNotify = newWidget.updateShouldNotify(oldWidget);
    return null;
  }
}
