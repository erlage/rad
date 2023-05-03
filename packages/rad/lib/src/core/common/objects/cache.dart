// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/renderer/widget_update_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

// objects with cc prefix are cached objects, available globally. caching
// objects is probably the easiest way to introduce bugs so i'm trying to be
// more careful here and not going to cache all objects aggressively.
// once i've more cc objects here, i'll do some benchmarks

/// Immutable empty list of widgets.
///
@internal
const ccImmutableEmptyListOfWidgets = <Widget>[];

/// Immutable empty map of event listeners.
///
@internal
const ccImmutableEmptyMapOfEventListeners = <DomEventType, EventCallback>{};

/// Immutable empty list of widget updates.
///
@internal
const ccImmutableEmptyListOfWidgetUpdates = <WidgetUpdateObject>[];

/// Immutable empty map of raw event listeners.
///
@internal
const ccImmutableEmptyMapOfRawEventListeners = <String, NativeEventCallback>{};

/// Immutable native-dom-event-value to [DomEventType] mappings.
///
@internal
const ccImmutableReverseMapOfDomEventTypes = {
  'click': DomEventType.click,
  'dblclick': DomEventType.doubleClick,
  'change': DomEventType.change,
  'input': DomEventType.input,
  'submit': DomEventType.submit,
  'keyup': DomEventType.keyUp,
  'keydown': DomEventType.keyDown,
  'keypress': DomEventType.keyPress,
  'drag': DomEventType.drag,
  'dragend': DomEventType.dragEnd,
  'dragenter': DomEventType.dragEnter,
  'dragleave': DomEventType.dragLeave,
  'dragover': DomEventType.dragOver,
  'dragstart': DomEventType.dragStart,
  'drop': DomEventType.drop,
  'mousedown': DomEventType.mouseDown,
  'mouseenter': DomEventType.mouseEnter,
  'mouseleave': DomEventType.mouseLeave,
  'mousemove': DomEventType.mouseMove,
  'mouseover': DomEventType.mouseOver,
  'mouseout': DomEventType.mouseOut,
  'mouseup': DomEventType.mouseUp,
};
