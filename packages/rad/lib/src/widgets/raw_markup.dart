// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/no_child_widget.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget that helps pushing raw contents to the DOM.
///
/// This widget doesn't clean or sanitize inputs. This behaviour is
/// intentional to allow an application add Javascript into the DOM.
///
/// Example:
///
/// ```dart
/// Span(
///   child: RawMarkup('<table> {...} </table>'),
/// )
/// ```
///
class RawMarkUp extends Widget {
  final String html;

  const RawMarkUp(this.html, {Key? key}) : super(key: key);

  @nonVirtual
  @override
  String get widgetType => 'RawMarkUp';

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  shouldUpdateWidget(covariant RawMarkUp oldWidget) => html != oldWidget.html;

  @override
  shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) => false;

  @override
  createRenderElement(parent) => RawMarkupRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Raw markup render element.
///
class RawMarkupRenderElement extends NoChildRenderElement {
  RawMarkupRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant RawMarkUp widget,
  }) {
    return DomNodePatch(rawContents: widget.html);
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required covariant RawMarkUp newWidget,
  }) {
    return DomNodePatch(rawContents: newWidget.html);
  }
}
