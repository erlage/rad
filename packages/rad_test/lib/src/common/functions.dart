// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad_test/src/imports.dart';

/// Check whether dom node is visible on screen.
///
bool fnIsDomNodeVisible(Element node) {
  // from SO thread(https://stackoverflow.com/a/41698614)

  var style = node.getComputedStyle();

  var opacity = int.tryParse(style.opacity) ?? 1;

  if (style.display == 'none') return false;
  if (style.visibility != 'visible') return false;
  if (opacity < 0.1) return false;

  if (node.offsetWidth +
          node.offsetHeight +
          node.getBoundingClientRect().height +
          node.getBoundingClientRect().width ==
      0) {
    return false;
  }

  var nodeCenterX = node.getBoundingClientRect().left + node.offsetWidth / 2;
  var nodeCenterY = node.getBoundingClientRect().top + node.offsetHeight / 2;

  var dX = document.documentElement?.clientWidth ?? window.innerWidth;
  var dY = document.documentElement?.clientHeight ?? window.innerHeight;

  if (nodeCenterX < 0) return false;
  if (null != dX && nodeCenterX > dX) return false;

  if (nodeCenterY < 0) return false;
  if (null != dY && nodeCenterY > dY) return false;

  var pointContainer = document.elementFromPoint(
    nodeCenterX.toInt(),
    nodeCenterY.toInt(),
  );

  if (pointContainer == node) return true;

  while (null != pointContainer) {
    if (pointContainer == node) return true;

    pointContainer = pointContainer.parent;
  }

  return false;
}

bool fnIsWidgetTextEditable(Widget widget) {
  if (widget is TextArea) {
    return true;
  }

  if (widget is Input) {
    if (widget.type == InputType.file) return false;
    if (widget.type == InputType.radio) return false;
    if (widget.type == InputType.submit) return false;
    if (widget.type == InputType.checkbox) return false;

    return true;
  }

  return false;
}

void fnEnterTextOnWidgetObject({
  required String textToEnter,
  required RenderElement renderElement,
}) {
  var widget = renderElement.widget;
  var domNode = renderElement.domNode;

  if (null == domNode) return;

  if (widget is Input) {
    domNode as InputElement;

    domNode
      ..focus()
      ..value = textToEnter;
  }

  if (widget is TextArea) {
    domNode as TextAreaElement;

    domNode
      ..focus()
      ..value = textToEnter;
  }
}
