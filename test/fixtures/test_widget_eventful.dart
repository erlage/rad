// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A test widget that implement all event listeners.
///
class RT_EventfulWidget extends Widget {
  final EventCallback? onInput;

  final EventCallback? onChange;

  final EventCallback? onSubmit;

  final EventCallback? onClick;

  final EventCallback? onDoubleClick;

  final EventCallback? onKeyUp;

  final EventCallback? onKeyDown;

  final EventCallback? onKeyPress;

  // -------------------------------------------------------------
  // Drag events
  // -------------------------------------------------------------

  final EventCallback? onDrag;

  final EventCallback? onDragEnd;

  final EventCallback? onDragEnter;

  final EventCallback? onDragLeave;

  final EventCallback? onDragOver;

  final EventCallback? onDragStart;

  final EventCallback? onDrop;

  // -------------------------------------------------------------
  // Mouse events
  // -------------------------------------------------------------

  final EventCallback? onMouseDown;

  final EventCallback? onMouseEnter;

  final EventCallback? onMouseLeave;

  final EventCallback? onMouseMove;

  final EventCallback? onMouseOver;

  final EventCallback? onMouseOut;

  final EventCallback? onMouseUp;

  // =============================================================
  // All events in capture mode
  // =============================================================

  final EventCallback? onInputCapture;

  final EventCallback? onChangeCapture;

  final EventCallback? onSubmitCapture;

  final EventCallback? onClickCapture;

  final EventCallback? onDoubleClickCapture;

  final EventCallback? onKeyUpCapture;

  final EventCallback? onKeyDownCapture;

  final EventCallback? onKeyPressCapture;

  final EventCallback? onDragCapture;

  final EventCallback? onDragEndCapture;

  final EventCallback? onDragEnterCapture;

  final EventCallback? onDragLeaveCapture;

  final EventCallback? onDragOverCapture;

  final EventCallback? onDragStartCapture;

  final EventCallback? onDropCapture;

  final EventCallback? onMouseDownCapture;

  final EventCallback? onMouseEnterCapture;

  final EventCallback? onMouseLeaveCapture;

  final EventCallback? onMouseMoveCapture;

  final EventCallback? onMouseOverCapture;

  final EventCallback? onMouseOutCapture;

  final EventCallback? onMouseUpCapture;

  final List<Widget> children;

  const RT_EventfulWidget({
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
    this.children = const [],
  }) : super(key: key);

  @override
  get widgetChildren => children;

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
  String get widgetType => '$RT_EventfulWidget';

  @override
  DomTag get correspondingTag => DomTag.division;
}
