// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_event.dart';

/// A render element show casing lifecycle events.
///
/// This class serves as an example that shows additional functionality
/// (such as lifecycle events) provided by [RenderElement]s. It can be used
/// as-it-is as well.
///
abstract class WatchfulRenderElement extends RenderElement {
  WatchfulRenderElement(super.widget, super.parent);

  /*
  |--------------------------------------------------------------------------
  | mount status of current element
  |--------------------------------------------------------------------------
  */

  /// Whether current render element is mounted on screen.
  ///
  @nonVirtual
  bool get isMounted => _isMounted;
  bool _isMounted = false;

  /// @nodoc
  @nonVirtual
  @override
  void register() {
    addRenderEventListeners({
      RenderEventType.didRender: frameworkDidRender,
      RenderEventType.didUpdate: frameworkDidUpdate,
      RenderEventType.willUnMount: frameworkWillUnMount,
      RenderEventType.didUnMount: frameworkDidUnMount,
    });

    init();
  }

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Init hook.
  ///
  /// This hook gets before rendering widget on the screen, happens exactly one
  /// time during lifetime of an element.
  ///
  @protected
  void init() {}

  /// After mount hook.
  ///
  /// This hook gets called after widget is mounted on the screen, happens
  /// exactly one time during lifetime of an element.
  ///
  @protected
  void afterMount() {}

  /// After update hook.
  ///
  /// This hook gets called after widget has been re-rendered to the DOM.
  ///
  @protected
  void afterUpdate() {}

  /// Dispose hook.
  ///
  /// This hook gets called when framework is about to remove widget from
  /// screen, called exactly one time during lifetime of an element.
  ///
  @protected
  void dispose() {}

  /// After unMount hook.
  ///
  /// This hook gets called after widget has been removed from the screen,
  /// happens exactly one time during lifetime of an element.
  ///
  @protected
  void afterUnMount() {}

  /*
  |--------------------------------------------------------------------------
  | framework reserved | lifecycle api
  |--------------------------------------------------------------------------
  */

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkDidRender(RenderEvent event) {
    assert(!isMounted, 'Widget is already mounted');

    _isMounted = true;

    afterMount();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkDidUpdate(RenderEvent event) {
    afterUpdate();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkWillUnMount(RenderEvent event) {
    dispose();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkDidUnMount(RenderEvent event) {
    assert(isMounted, 'Widget is not mounted yet');

    _isMounted = false;

    afterUnMount();
  }
}
