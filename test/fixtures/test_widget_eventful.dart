// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A test widget that implement all event listeners.
///
class RT_EventfulWidget extends Widget {
  final EventCallback? onClick;
  final EventCallback? onClickCapture;
  final EventCallback? onInput;
  final EventCallback? onInputCapture;
  final EventCallback? onChange;
  final EventCallback? onChangeCapture;
  final EventCallback? onSubmit;
  final EventCallback? onSubmitCapture;
  final EventCallback? onKeyUp;
  final EventCallback? onKeyUpCapture;
  final EventCallback? onKeyDown;
  final EventCallback? onKeyDownCapture;
  final EventCallback? onKeyPress;
  final EventCallback? onKeyPressCapture;

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

    // capture phase

    this.onClickCapture,
    this.onInputCapture,
    this.onChangeCapture,
    this.onSubmitCapture,
    this.onKeyUpCapture,
    this.onKeyDownCapture,
    this.onKeyPressCapture,
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
      };

  @override
  String get widgetType => '$RT_EventfulWidget';

  @override
  DomTag get correspondingTag => DomTag.division;
}
