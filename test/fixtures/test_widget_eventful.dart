// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A test widget that implement all event listeners.
///
class RT_EventfulWidget extends Widget {
  final EventCallback? onClick;
  final EventCallback? onInput;
  final EventCallback? onChange;
  final EventCallback? onSubmit;
  final EventCallback? onKeyUp;
  final EventCallback? onKeyDown;
  final EventCallback? onKeyPress;

  final EventCallback? onClickCapture;
  final EventCallback? onInputCapture;
  final EventCallback? onChangeCapture;
  final EventCallback? onSubmitCapture;
  final EventCallback? onKeyUpCapture;
  final EventCallback? onKeyDownCapture;
  final EventCallback? onKeyPressCapture;

  // mouse events

  final EventCallback? onMouseDown;
  final EventCallback? onMouseEnter;
  final EventCallback? onMouseLeave;
  final EventCallback? onMouseMove;
  final EventCallback? onMouseOver;
  final EventCallback? onMouseOut;
  final EventCallback? onMouseUp;

  final EventCallback? onMouseDownCapture;
  final EventCallback? onMouseEnterCapture;
  final EventCallback? onMouseLeaveCapture;
  final EventCallback? onMouseMoveCapture;
  final EventCallback? onMouseOverCapture;
  final EventCallback? onMouseOutCapture;
  final EventCallback? onMouseUpCapture;

  final List<Widget> children;

  RT_EventfulWidget({
    Key? key,
    this.onClick,
    this.onInput,
    this.onChange,
    this.onSubmit,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,

    // mouse events

    this.onMouseDown,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onMouseMove,
    this.onMouseOver,
    this.onMouseOut,
    this.onMouseUp,

    // capture phase

    this.onClickCapture,
    this.onInputCapture,
    this.onChangeCapture,
    this.onSubmitCapture,
    this.onKeyUpCapture,
    this.onKeyDownCapture,
    this.onKeyPressCapture,
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
  get widgetEventListeners => {
        DomEventType.click: onClick,
        DomEventType.input: onInput,
        DomEventType.change: onChange,
        DomEventType.submit: onSubmit,
        DomEventType.keyUp: onKeyUp,
        DomEventType.keyDown: onKeyDown,
        DomEventType.keyPress: onKeyPress,

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
  get widgetCaptureEventListeners => {
        DomEventType.click: onClickCapture,
        DomEventType.input: onInputCapture,
        DomEventType.change: onChangeCapture,
        DomEventType.submit: onSubmitCapture,
        DomEventType.keyUp: onKeyUpCapture,
        DomEventType.keyDown: onKeyDownCapture,
        DomEventType.keyPress: onKeyPressCapture,

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
