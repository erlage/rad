// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/widgets/navigator.dart';
import 'package:rad/src/widgets/route.dart';

/// Navigator link object.
///
/// This object holds information that helps carrying out ops which spans
/// accross multiple navigators in parent/child of a navigator.
///
@internal
class NavigatorLink {
  /// List of routes that Navigator is managing.
  ///
  final List<Route> routes;

  /// List of path segments where Navigator is registered.
  ///
  final List<String> segments;

  /// Parent navigator link.
  ///
  final NavigatorLink? parentLink;

  /// Child navigators links.
  ///
  final _childLinks = <String, NavigatorLink>{};

  /// Reference to render element of Navigator.
  ///
  final NavigatorRenderElement navigator;

  NavigatorLink({
    this.parentLink,
    required this.routes,
    required this.segments,
    required this.navigator,
  });

  /// Return child navigator linked on current route.
  ///
  NavigatorLink? get childLinkedOnCurrentRoute =>
      _childLinks[navigator.state.currentRouteName];

  /// Establish a child link.
  ///
  void establishChildLink(NavigatorLink link) {
    _childLinks[navigator.state.currentRouteName] = link;
  }

  /// Unlink a navigator link.
  ///
  void disband() {
    // unlink from parent
    parentLink?._childLinks.removeWhere((key, value) => value == this);
  }
}
