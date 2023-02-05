// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/single_child_widget.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A Simple App Widget that takes as much space as its parents allowed it to.
///
class RadApp extends SingleChildWidget {
  const RadApp({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  bool shouldUpdateWidget(Widget oldWidget) => false;

  @override
  createRenderElement(parent) => RadAppRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Rad app render element.
///
class RadAppRenderElement extends SingleChildRenderElement {
  RadAppRenderElement(
    RadApp widget,
    RenderElement parent,
  ) : super(widget, parent);

  @override
  render({required widget}) => const DomNodePatch(
        attributes: {
          Attributes.className: Constants.classRadApp,
        },
      );
}
