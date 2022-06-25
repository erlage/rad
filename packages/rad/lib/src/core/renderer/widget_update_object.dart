// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Framework's action.
///
@internal
abstract class WidgetUpdateObject {
  final WidgetUpdateType widgetUpdateType;

  const WidgetUpdateObject(this.widgetUpdateType);
}

@internal
class WidgetUpdateObjectActionAdd extends WidgetUpdateObject {
  /// New widget.
  ///
  final List<Widget> widgets;

  /// Widget position in parent's child list.
  ///
  final int widgetPositionIndex;

  /// Mount index is the index at which this widget should be mounted.
  ///
  final int? mountAtIndex;

  /// Append a widget to the same update object.
  ///
  void appendAnotherWidget(Widget widget) => widgets.add(widget);

  WidgetUpdateObjectActionAdd({
    required this.widgets,
    required this.mountAtIndex,
    required this.widgetPositionIndex,
  }) : super(WidgetUpdateType.add);
}

@internal
class WidgetUpdateObjectActionAddAllWithoutClean extends WidgetUpdateObject {
  /// New widgets.
  ///
  final List<Widget> widgets;

  WidgetUpdateObjectActionAddAllWithoutClean({
    required this.widgets,
  }) : super(WidgetUpdateType.addAllWithoutClean);
}

@internal
class WidgetUpdateObjectActionUpdate extends WidgetUpdateObject {
  /// New widget.
  ///
  final Widget widget;

  /// Widget position in parent's child list.
  ///
  final int widgetPositionIndex;

  /// Existing widget node that should be updated.
  ///
  final RenderElement existingRenderElement;

  /// New mount index.
  ///
  final int? newMountAtIndex;

  WidgetUpdateObjectActionUpdate({
    required this.widget,
    required this.widgetPositionIndex,
    required this.existingRenderElement,
    required this.newMountAtIndex,
  }) : super(WidgetUpdateType.update);
}

@internal
class WidgetUpdateObjectActionDispose extends WidgetUpdateObject {
  /// Existing widget node that should be disposed.
  ///
  final RenderElement existingElement;

  WidgetUpdateObjectActionDispose(
    this.existingElement,
  ) : super(WidgetUpdateType.dispose);
}

@internal
class WidgetUpdateObjectActionDisposeMultiple extends WidgetUpdateObject {
  /// Existing nodes to dispose
  ///
  final Iterable<RenderElement> elementsToDispose;

  WidgetUpdateObjectActionDisposeMultiple(
    this.elementsToDispose,
  ) : super(WidgetUpdateType.disposeMultiple);
}

@internal
class WidgetUpdateObjectActionCleanParent extends WidgetUpdateObject {
  static const _cached = WidgetUpdateObjectActionCleanParent._();

  factory WidgetUpdateObjectActionCleanParent() => _cached;

  const WidgetUpdateObjectActionCleanParent._()
      : super(
          WidgetUpdateType.cleanParent,
        );
}
