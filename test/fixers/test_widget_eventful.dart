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
  get widgetType => '$RT_EventfulWidget';

  @override
  get correspondingTag => DomTag.division;
}
