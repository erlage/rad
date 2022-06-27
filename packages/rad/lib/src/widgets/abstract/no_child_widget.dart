// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Base class for widgets that has no child widgets.
///
@internal
abstract class NoChildWidget extends Widget {
  const NoChildWidget({super.key});

  @override
  shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) => false;

  @override
  createRenderElement(parent) => NoChildRenderElement(this, parent);
}

/// No child render element.
///
@internal
class NoChildRenderElement extends RenderElement {
  NoChildRenderElement(super.widget, super.parent);

  @override
  List<Widget> get widgetChildren => ccImmutableEmptyListOfWidgets;
}
