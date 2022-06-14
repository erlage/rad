// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A test widget that implement all event listeners.
///
class RT_EventfulWidget extends EventDetector {
  final List<Widget> children;

  RT_EventfulWidget({
    Key? key,

    // basic

    EventCallback? onClick,
    EventCallback? onDoubleClick,
    EventCallback? onInput,
    EventCallback? onChange,
    EventCallback? onSubmit,
    EventCallback? onKeyUp,
    EventCallback? onKeyDown,
    EventCallback? onKeyPress,

    // drag events

    EventCallback? onDrag,
    EventCallback? onDragEnd,
    EventCallback? onDragEnter,
    EventCallback? onDragLeave,
    EventCallback? onDragOver,
    EventCallback? onDragStart,
    EventCallback? onDrop,

    // mouse events

    EventCallback? onMouseDown,
    EventCallback? onMouseEnter,
    EventCallback? onMouseLeave,
    EventCallback? onMouseMove,
    EventCallback? onMouseOver,
    EventCallback? onMouseOut,
    EventCallback? onMouseUp,

    // ---------------------------------------------
    // all above callbacks but in capture phase
    // ---------------------------------------------

    EventCallback? onClickCapture,
    EventCallback? onDoubleClickCapture,
    EventCallback? onInputCapture,
    EventCallback? onChangeCapture,
    EventCallback? onSubmitCapture,
    EventCallback? onKeyUpCapture,
    EventCallback? onKeyDownCapture,
    EventCallback? onKeyPressCapture,

    // drag events

    EventCallback? onDragCapture,
    EventCallback? onDragEndCapture,
    EventCallback? onDragEnterCapture,
    EventCallback? onDragLeaveCapture,
    EventCallback? onDragOverCapture,
    EventCallback? onDragStartCapture,
    EventCallback? onDropCapture,

    // mouse events

    EventCallback? onMouseDownCapture,
    EventCallback? onMouseEnterCapture,
    EventCallback? onMouseLeaveCapture,
    EventCallback? onMouseMoveCapture,
    EventCallback? onMouseOverCapture,
    EventCallback? onMouseOutCapture,
    EventCallback? onMouseUpCapture,
    this.children = const [],
  }) : super(
          key: key,
          child: Division(children: children),
          onClick: onClick,
          onDoubleClick: onDoubleClick,
          onInput: onInput,
          onChange: onChange,
          onSubmit: onSubmit,
          onKeyUp: onKeyUp,
          onKeyDown: onKeyDown,
          onKeyPress: onKeyPress,
          onDrag: onDrag,
          onDragEnd: onDragEnd,
          onDragEnter: onDragEnter,
          onDragLeave: onDragLeave,
          onDragOver: onDragOver,
          onDragStart: onDragStart,
          onDrop: onDrop,
          onMouseDown: onMouseDown,
          onMouseEnter: onMouseEnter,
          onMouseLeave: onMouseLeave,
          onMouseMove: onMouseMove,
          onMouseOver: onMouseOver,
          onMouseOut: onMouseOut,
          onMouseUp: onMouseUp,
          onClickCapture: onClickCapture,
          onDoubleClickCapture: onDoubleClickCapture,
          onInputCapture: onInputCapture,
          onChangeCapture: onChangeCapture,
          onSubmitCapture: onSubmitCapture,
          onKeyUpCapture: onKeyUpCapture,
          onKeyDownCapture: onKeyDownCapture,
          onKeyPressCapture: onKeyPressCapture,
          onDragCapture: onDragCapture,
          onDragEndCapture: onDragEndCapture,
          onDragEnterCapture: onDragEnterCapture,
          onDragLeaveCapture: onDragLeaveCapture,
          onDragOverCapture: onDragOverCapture,
          onDragStartCapture: onDragStartCapture,
          onDropCapture: onDropCapture,
          onMouseDownCapture: onMouseDownCapture,
          onMouseEnterCapture: onMouseEnterCapture,
          onMouseLeaveCapture: onMouseLeaveCapture,
          onMouseMoveCapture: onMouseMoveCapture,
          onMouseOverCapture: onMouseOverCapture,
          onMouseOutCapture: onMouseOutCapture,
          onMouseUpCapture: onMouseUpCapture,
        );

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
  DomTagType get correspondingTag => DomTagType.division;
}
