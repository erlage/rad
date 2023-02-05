// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/router_render_element.dart';

/// [RouterRenderElement] link object.
///
/// This object holds information that helps carrying out ops which spans
/// across multiple [RouterRenderElement]s in parent/child of a
/// [RouterRenderElement].
///
@internal
class RouterLink {
  /// List of path segments where [RouterRenderElement] is registered.
  ///
  final List<String> segments;

  /// Parent [RouterLink].
  ///
  final RouterLink? parentLink;

  /// Child [RouterLink]s.
  ///
  final _childLinks = <String, RouterLink>{};

  /// Reference to render element of [RouterRenderElement].
  ///
  final RouterRenderElement routerElement;

  RouterLink({
    this.parentLink,
    required this.segments,
    required this.routerElement,
  });

  /// Return child [RouterRenderElement] linked on current route.
  ///
  RouterLink? getChildLinkedOnCurrentRoutePath() {
    return _childLinks[routerElement.getCurrentRoutePath()];
  }

  /// Establish a child link.
  ///
  void setChildLinkOnCurrentRoutePath(RouterLink link) {
    _childLinks[routerElement.getCurrentRoutePath()] = link;
  }

  /// Unlink a [RouterRenderElement] link.
  ///
  void disbandLink() {
    // unlink from parent
    parentLink?._childLinks.removeWhere((key, value) => value == this);
  }
}
