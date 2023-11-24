// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Root render element.
///
/// Root render elements are different from normal render elements in that
/// there can be only one root render element in a single app instance and
/// second they don't have a corresponding widget associated with them.
///
class RootRenderElement extends RenderElement {
  RootRenderElement({
    required String appTargetId,
    required Element appTargetDomNode,
  }) : super.frameworkBigBang(
          appTargetId: appTargetId,
          appTargetDomNode: appTargetDomNode,
        );

  @override
  List<Widget> get widgetChildren => throw Exception('Access invalid');
}
