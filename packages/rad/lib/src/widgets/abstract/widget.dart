// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';

/// Describes the configuration for an [RenderElement].
///
/// Widgets are the central class hierarchy in the Rad framework. A widget
/// is an immutable description of part of a user interface. Widgets can be
/// inflated into render elements.
///
@immutable
abstract class Widget {
  /// Keys help Rad identify which widgets have changed, are added, or are
  /// removed when a widget has multiple sibling widgets.
  ///
  /// Keys must be unique amongst the [RenderElement]s with the same parent.
  ///
  /// Unlike flutter, keys only make sense in the context of the surrounding
  /// array of widgets. Keys should be given to the widgets inside the array to
  /// give the widgets a stable identity.
  ///
  final Key? key;

  /// Corresponding HTML tag to use to render this widget
  ///
  DomTagType? get correspondingTag;

  /// Events that this widget is listening to in bubbling phase.
  ///
  Map<DomEventType, EventCallback?> get widgetEventListeners {
    return ccImmutableEmptyMapOfEventListeners;
  }

  /// Events that this widget is listening to in capturing phase.
  ///
  Map<DomEventType, EventCallback?> get widgetCaptureEventListeners {
    return ccImmutableEmptyMapOfEventListeners;
  }

  /*
  |--------------------------------------------------------------------------
  | constructor
  |--------------------------------------------------------------------------
  */

  const Widget({this.key});

  /*
  |--------------------------------------------------------------------------
  | widget configuration methods
  |--------------------------------------------------------------------------
  */

  /// Whether to update current widget.
  ///
  ///
  /// Framework calls this method on new widget, when new widget matches with a
  /// old widget,to check whether old widget need to update. This method should
  /// contain the logic to compare new widget with old.
  ///
  ///
  /// Diffing process will always call [shouldUpdateWidget] on child widgets
  /// of current widget even if [shouldUpdateWidget] return false. This means
  /// whatever diffing logic is present in this method, its scope should be
  /// limited to checking just the current widget. If a widget want to
  /// short-circuit diffing process(i.e no [shouldUpdateWidget] on child
  /// widgets) then it can override [shouldUpdateWidgetChildren] method.
  ///
  bool shouldUpdateWidget(Widget oldWidget);

  /// Whether to update current widget's children.
  ///
  /// Framework will always call this method after calling [shouldUpdateWidget]
  /// along with results of call to [shouldUpdateWidget] on current widget.
  ///
  /// If current widget knows in advance whether widgets below it
  /// doesn't need to update then it can override this method and return
  /// false which will short-circuit the diffing process.
  ///
  bool shouldUpdateWidgetChildren(Widget oldWidget, bool shouldUpdateWidget) {
    return true;
  }

  /*
  |--------------------------------------------------------------------------
  | concrete instance
  |--------------------------------------------------------------------------
  */

  /// Create element for current widget.
  ///
  /// Framework will call this method when it inflates current widget for the
  /// first time at specific position in widget tree. Each [RenderElement]
  /// inherits number of properties from its parent, therefore framework will
  /// call this method and pass it a reference to [parent] element of this
  /// widget.
  ///
  RenderElement createRenderElement(RenderElement parent);
}
