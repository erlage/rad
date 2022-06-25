// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/single_child_widget.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget for detecting dom events on a widget or part of tree.
///
/// Event detector can be used to register event listeners in capturing as well
/// as in bubbling phase.
///
class EventDetector extends SingleChildWidget {
  /// On input event listener.
  ///
  final EventCallback? onInput;

  /// On change event listener.
  ///
  final EventCallback? onChange;

  /// On submit event listener.
  ///
  final EventCallback? onSubmit;

  /// On click event listener.
  ///
  final EventCallback? onClick;

  /// On double click event listener.
  ///
  final EventCallback? onDoubleClick;

  /// On key up event listener.
  ///
  final EventCallback? onKeyUp;

  /// On key down event listener.
  ///
  final EventCallback? onKeyDown;

  /// On key press event listener.
  ///
  final EventCallback? onKeyPress;

  // -------------------------------------------------------------
  // Drag events
  // -------------------------------------------------------------

  /// On Drag event listener.
  ///
  final EventCallback? onDrag;

  /// On DragEnd event listener.
  ///
  final EventCallback? onDragEnd;

  /// On DragEnter event listener.
  ///
  final EventCallback? onDragEnter;

  /// On DragLeave event listener.
  ///
  final EventCallback? onDragLeave;

  /// On DragOver event listener.
  ///
  final EventCallback? onDragOver;

  /// On DragStart event listener.
  ///
  final EventCallback? onDragStart;

  /// On Drop event listener.
  ///
  final EventCallback? onDrop;

  // -------------------------------------------------------------
  // Mouse events
  // -------------------------------------------------------------

  /// On mouse down event listener.
  ///
  final EventCallback? onMouseDown;

  /// On mouse enter event listener.
  ///
  final EventCallback? onMouseEnter;

  /// On mouse leave event listener.
  ///
  final EventCallback? onMouseLeave;

  /// On mouse move event listener.
  ///
  final EventCallback? onMouseMove;

  /// On mouse over event listener.
  ///
  final EventCallback? onMouseOver;

  /// On mouse out event listener.
  ///
  final EventCallback? onMouseOut;

  /// On mouse up event listener.
  ///
  final EventCallback? onMouseUp;

  // =============================================================
  // All events in capture mode
  // =============================================================

  /// On input event listener in capture phase.
  ///
  final EventCallback? onInputCapture;

  /// On change event listener in capture phase.
  ///
  final EventCallback? onChangeCapture;

  /// On submit event listener in capture phase.
  ///
  final EventCallback? onSubmitCapture;

  /// On click event listener in capture phase.
  ///
  final EventCallback? onClickCapture;

  /// On double click event listener in capture phase.
  ///
  final EventCallback? onDoubleClickCapture;

  /// On key up event listener in capture phase.
  ///
  final EventCallback? onKeyUpCapture;

  /// On key down event listener in capture phase.
  ///
  final EventCallback? onKeyDownCapture;

  /// On key press event listener in capture phase.
  ///
  final EventCallback? onKeyPressCapture;

  /// On Drag event listener in capture phase.
  ///
  final EventCallback? onDragCapture;

  /// On DragEnd event listener in capture phase.
  ///
  final EventCallback? onDragEndCapture;

  /// On DragEnter event listener in capture phase.
  ///
  final EventCallback? onDragEnterCapture;

  /// On DragLeave event listener in capture phase.
  ///
  final EventCallback? onDragLeaveCapture;

  /// On DragOver event listener in capture phase.
  ///
  final EventCallback? onDragOverCapture;

  /// On DragStart event listener in capture phase.
  ///
  final EventCallback? onDragStartCapture;

  /// On Drop event listener in capture phase.
  ///
  final EventCallback? onDropCapture;

  /// On mouse down event listener in capture phase.
  ///
  final EventCallback? onMouseDownCapture;

  /// On mouse enter event listener in capture phase.
  ///
  final EventCallback? onMouseEnterCapture;

  /// On mouse leave event listener in capture phase.
  ///
  final EventCallback? onMouseLeaveCapture;

  /// On mouse move event listener in capture phase.
  ///
  final EventCallback? onMouseMoveCapture;

  /// On mouse over event listener in capture phase.
  ///
  final EventCallback? onMouseOverCapture;

  /// On mouse out event listener in capture phase.
  ///
  final EventCallback? onMouseOutCapture;

  /// On mouse up event listener in capture phase.
  ///
  final EventCallback? onMouseUpCapture;

  const EventDetector({
    Key? key,
    this.onClick,
    this.onDoubleClick,
    this.onInput,
    this.onChange,
    this.onSubmit,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,

    // drag events

    this.onDrag,
    this.onDragEnd,
    this.onDragEnter,
    this.onDragLeave,
    this.onDragOver,
    this.onDragStart,
    this.onDrop,

    // mouse events

    this.onMouseDown,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onMouseMove,
    this.onMouseOver,
    this.onMouseOut,
    this.onMouseUp,

    // ---------------------------------------------
    // all above callbacks but in capture phase
    // ---------------------------------------------

    this.onClickCapture,
    this.onDoubleClickCapture,
    this.onInputCapture,
    this.onChangeCapture,
    this.onSubmitCapture,
    this.onKeyUpCapture,
    this.onKeyDownCapture,
    this.onKeyPressCapture,

    // drag events

    this.onDragCapture,
    this.onDragEndCapture,
    this.onDragEnterCapture,
    this.onDragLeaveCapture,
    this.onDragOverCapture,
    this.onDragStartCapture,
    this.onDropCapture,

    // mouse events

    this.onMouseDownCapture,
    this.onMouseEnterCapture,
    this.onMouseLeaveCapture,
    this.onMouseMoveCapture,
    this.onMouseOverCapture,
    this.onMouseOutCapture,
    this.onMouseUpCapture,

    // child widget

    required Widget child,
  }) : super(key: key, child: child);

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners => {
        DomEventType.click: onClick,
        DomEventType.doubleClick: onDoubleClick,
        DomEventType.input: onInput,
        DomEventType.change: onChange,
        DomEventType.submit: onSubmit,
        DomEventType.keyUp: onKeyUp,
        DomEventType.keyDown: onKeyDown,
        DomEventType.keyPress: onKeyPress,

        // drag events

        DomEventType.drag: onDrag,
        DomEventType.dragEnd: onDragEnd,
        DomEventType.dragEnter: onDragEnter,
        DomEventType.dragLeave: onDragLeave,
        DomEventType.dragOver: onDragOver,
        DomEventType.dragStart: onDragStart,
        DomEventType.drop: onDrop,

        // mouse events

        DomEventType.mouseDown: onMouseDown,
        DomEventType.mouseEnter: onMouseEnter,
        DomEventType.mouseLeave: onMouseLeave,
        DomEventType.mouseMove: onMouseMove,
        DomEventType.mouseOver: onMouseOver,
        DomEventType.mouseOut: onMouseOut,
        DomEventType.mouseUp: onMouseUp,
      };

  @override
  Map<DomEventType, EventCallback?> get widgetCaptureEventListeners => {
        DomEventType.click: onClickCapture,
        DomEventType.doubleClick: onDoubleClickCapture,
        DomEventType.input: onInputCapture,
        DomEventType.change: onChangeCapture,
        DomEventType.submit: onSubmitCapture,
        DomEventType.keyUp: onKeyUpCapture,
        DomEventType.keyDown: onKeyDownCapture,
        DomEventType.keyPress: onKeyPressCapture,

        // drag events

        DomEventType.drag: onDragCapture,
        DomEventType.dragEnd: onDragEndCapture,
        DomEventType.dragEnter: onDragEnterCapture,
        DomEventType.dragLeave: onDragLeaveCapture,
        DomEventType.dragOver: onDragOverCapture,
        DomEventType.dragStart: onDragStartCapture,
        DomEventType.drop: onDropCapture,

        // mouse events

        DomEventType.mouseDown: onMouseDownCapture,
        DomEventType.mouseEnter: onMouseEnterCapture,
        DomEventType.mouseLeave: onMouseLeaveCapture,
        DomEventType.mouseMove: onMouseMoveCapture,
        DomEventType.mouseOver: onMouseOverCapture,
        DomEventType.mouseOut: onMouseOutCapture,
        DomEventType.mouseUp: onMouseUpCapture,
      };

  @override
  String get widgetType => 'EventDetector';

  @override
  DomTagType? get correspondingTag => null;

  @override
  bool shouldUpdateWidget(oldWidget) => false;
}
