// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Base class for widgets that has exactly one child widget.
///
@internal
abstract class SingleChildWidget extends Widget {
  /// Child widget.
  ///
  final Widget child;

  const SingleChildWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  createRenderElement(parent) => SingleChildRenderElement(this, parent);
}

/// Single child render element.
///
@internal
class SingleChildRenderElement extends RenderElement {
  SingleChildRenderElement(
    SingleChildWidget widget,
    RenderElement parent,
  )   : _widgetChildren = [widget.child],
        super(widget, parent);

  @override
  List<Widget> get widgetChildren => _widgetChildren;
  List<Widget> _widgetChildren;

  @mustCallSuper
  @override
  void afterWidgetRebind({
    required oldWidget,
    required covariant SingleChildWidget newWidget,
    required updateType,
  }) {
    _widgetChildren = [newWidget.child];
  }
}
