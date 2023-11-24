// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/scope_event.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/interface/scope/abstract.dart';
import 'package:rad/src/core/interface/scope/dispatcher.dart' as scope_unit;
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget for creating render scope.
///
@immutable
@internal
class RenderScope extends Widget {
  /// Widget builder.
  ///
  final Widget Function() builder;

  /// Create hook scope.
  ///
  const RenderScope(this.builder, {Key? key}) : super(key: key);

  /*
  |--------------------------------------------------------------------------
  | widget internals
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @override
  DomTagType? get correspondingTag => null;

  @override
  bool shouldUpdateWidget(oldWidget) => true;

  @override
  createRenderElement(parent) => RenderScopeRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// RenderScope render element.
///
@internal
class RenderScopeRenderElement extends RenderElement
    with ServicesResolver
    implements Scope {
  /// Create render scope element.
  ///
  RenderScopeRenderElement(super.widget, super.parent);

  @override
  BuildContext get context => this;

  /// @nodoc
  @override
  List<Widget> get widgetChildren {
    return scope_unit.runScopedTask(this, () {
      if (_isInitialBuild) {
        _dispatchEvent(ScopeEventType.willBuildScope);
      } else {
        _dispatchEvent(ScopeEventType.willRebuildScope);
      }

      _isInBuildingPhase = true;
      var widgetChildren = [(widget as RenderScope).builder()];
      _isInBuildingPhase = false;

      if (_isInitialBuild) {
        _dispatchEvent(ScopeEventType.didBuildScope);
        _isInitialBuild = false;
      } else {
        _dispatchEvent(ScopeEventType.didRebuildScope);
      }

      if (_isRebuildRequestPending) {
        Future.delayed(Duration.zero, () => performRebuild());
      }

      return widgetChildren;
    });
  }

  @override
  void addScopeEventListener(
    ScopeEventType eventType,
    ScopeEventCallback listener,
  ) {
    var listenersForType = _listeners[eventType];

    if (null == listenersForType) {
      _listeners[eventType] = [listener];
    } else {
      listenersForType.add(listener);
    }
  }

  @nonVirtual
  @override
  void performRebuild() {
    if (_isInBuildingPhase) {
      _isRebuildRequestPending = true;

      return;
    }

    _services.scheduler.addTask(
      WidgetsUpdateDependentTask(dependentRenderElement: this),
    );

    _isRebuildRequestPending = false;
  }

  /// @nodoc
  @protected
  @override
  void register() {
    addRenderEventListeners({
      RenderEventType.didRender: (_) => _dispatchEvent(
            ScopeEventType.didRenderScope,
          ),
      RenderEventType.didUpdate: (_) => _dispatchEvent(
            ScopeEventType.didUpdateScope,
          ),
      RenderEventType.willUnMount: (_) => _dispatchEvent(
            ScopeEventType.willUnMountScope,
          ),
      RenderEventType.didUnMount: (_) => _dispatchEvent(
            ScopeEventType.didUnMountScope,
          ),
    });
  }

  // ----------------------------------------------------------------------
  //  Internals
  // ----------------------------------------------------------------------

  /// Whether in initial build state.
  ///
  var _isInitialBuild = true;

  /// Is in building/rebuilding phase.
  ///
  var _isInBuildingPhase = false;

  /// Whether a rebuild request is pending.
  ///
  var _isRebuildRequestPending = false;

  /// Render scope event listeners.
  ///
  final _listeners = <ScopeEventType, List<ScopeEventCallback>>{};

  /// Services instance.
  ///
  Services get _services => resolveServices(this);

  void _dispatchEvent(ScopeEventType eventType) {
    var listenersForType = _listeners[eventType];
    if (null != listenersForType) {
      var event = ScopeEvent(eventType);

      for (final listener in listenersForType) {
        listener(event);
      }
    }
  }
}
