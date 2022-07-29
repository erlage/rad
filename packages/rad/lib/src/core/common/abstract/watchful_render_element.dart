// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';

/// Base class for render elements that are watching their position in the tree.
///
/// Watchful elements differs from other render elements in that framework
/// consider them alive in tree and framework will let them know when it
/// mounts or un-mounts them from tree so that these elements can take
/// appropriate actions.
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
  void init() {}

  /// After mount hook.
  ///
  /// This hook gets called after widget is mounted on the screen, happens
  /// exactly one time during lifetime of an element.
  ///
  void afterMount() {}

  /// After update hook.
  ///
  /// This hook gets called after widget has been re-rendered to the DOM.
  ///
  void afterUpdate() {}

  /// Dispose hook.
  ///
  /// This hook gets called when framework is about to remove widget from
  /// screen, called exactly one time during lifetime of an element.
  ///
  void dispose() {}

  /// After unMount hook.
  ///
  /// This hook gets called after widget has been removed from the screen,
  /// happens exactly one time during lifetime of an element.
  ///
  void afterUnMount() {}

  /*
  |--------------------------------------------------------------------------
  | framework reserved | lifecycle api
  |--------------------------------------------------------------------------
  */

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkInit() {
    init();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAfterMount() {
    assert(!isMounted, 'Widget is already mounted');

    _isMounted = true;

    afterMount();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAfterUpdate() {
    afterUpdate();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkDispose() {
    dispose();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAfterUnMount() {
    assert(isMounted, 'Widget is not mounted yet');

    _isMounted = false;

    afterUnMount();
  }
}
