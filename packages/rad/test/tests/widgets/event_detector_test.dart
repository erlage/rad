// ignore_for_file: prefer_function_declarations_over_variables

import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Event detector has a very little logic to test because it uses the 
  | core's events to setup event listeners. below test are mere for testing
  | whether widget constructor is setting correct data for core to pick up
  |--------------------------------------------------------------------------
  */

  group('EventDetector tests:', () {
    test('should set empty list', () {
      var widget = EventDetector(
        child: Text('hello world'),
      );

      var nonNullEventListeners = widget.widgetEventListeners.values.toList()
        ..removeWhere((domNode) => null == domNode);

      var nonNullCaptureEventListeners =
          widget.widgetCaptureEventListeners.values.toList()
            ..removeWhere((domNode) => null == domNode);

      expect(nonNullEventListeners.isEmpty, equals(true));
      expect(nonNullCaptureEventListeners.isEmpty, equals(true));
    });

    test('should set one', () {
      var widget = EventDetector(
        onChange: (_) {},
        child: Text('hello world'),
      );

      var nonNullEventListeners = widget.widgetEventListeners.values.toList()
        ..removeWhere((domNode) => null == domNode);

      expect(nonNullEventListeners.length, equals(1));
    });

    test('should set one(capturing phase)', () {
      var widget = EventDetector(
        onChangeCapture: (_) {},
        child: Text('hello world'),
      );

      var nonNullCaptureEventListeners =
          widget.widgetCaptureEventListeners.values.toList()
            ..removeWhere((domNode) => null == domNode);

      expect(nonNullCaptureEventListeners.length, equals(1));
    });

    test('should set both', () {
      var widget = EventDetector(
        onInput: (_) {},
        onInputCapture: (_) {},
        child: Text('hello world'),
      );

      var nonNullEventListeners = widget.widgetEventListeners.values.toList()
        ..removeWhere((domNode) => null == domNode);

      var nonNullCaptureEventListeners =
          widget.widgetCaptureEventListeners.values.toList()
            ..removeWhere((domNode) => null == domNode);

      expect(nonNullEventListeners.length, equals(1));
      expect(nonNullCaptureEventListeners.length, equals(1));
    });

    test('should set all', () {
      var eventListenerForClick = (event) {};
      var eventListenerForDoubleClick = (event) {};
      var eventListenerForChange = (event) {};
      var eventListenerForInput = (event) {};
      var eventListenerForSubmit = (event) {};
      var eventListenerForKeyUp = (event) {};
      var eventListenerForKeyDown = (event) {};
      var eventListenerForKeyPress = (event) {};
      var eventListenerForDrag = (event) {};
      var eventListenerForDragEnd = (event) {};
      var eventListenerForDragEnter = (event) {};
      var eventListenerForDragLeave = (event) {};
      var eventListenerForDragOver = (event) {};
      var eventListenerForDragStart = (event) {};
      var eventListenerForDrop = (event) {};
      var eventListenerForMouseDown = (event) {};
      var eventListenerForMouseEnter = (event) {};
      var eventListenerForMouseLeave = (event) {};
      var eventListenerForMouseMove = (event) {};
      var eventListenerForMouseOver = (event) {};
      var eventListenerForMouseOut = (event) {};
      var eventListenerForMouseUp = (event) {};

      var widget = EventDetector(
        onClick: eventListenerForClick,
        onDoubleClick: eventListenerForDoubleClick,
        onChange: eventListenerForChange,
        onInput: eventListenerForInput,
        onSubmit: eventListenerForSubmit,
        onKeyUp: eventListenerForKeyUp,
        onKeyDown: eventListenerForKeyDown,
        onKeyPress: eventListenerForKeyPress,
        onDrag: eventListenerForDrag,
        onDragEnd: eventListenerForDragEnd,
        onDragEnter: eventListenerForDragEnter,
        onDragLeave: eventListenerForDragLeave,
        onDragOver: eventListenerForDragOver,
        onDragStart: eventListenerForDragStart,
        onDrop: eventListenerForDrop,
        onMouseDown: eventListenerForMouseDown,
        onMouseEnter: eventListenerForMouseEnter,
        onMouseLeave: eventListenerForMouseLeave,
        onMouseMove: eventListenerForMouseMove,
        onMouseOver: eventListenerForMouseOver,
        onMouseOut: eventListenerForMouseOut,
        onMouseUp: eventListenerForMouseUp,
        child: Text('hello world'),
      );

      expect(
        widget.widgetEventListeners[DomEventType.click],
        equals(eventListenerForClick),
      );

      expect(
        widget.widgetEventListeners[DomEventType.doubleClick],
        equals(eventListenerForDoubleClick),
      );

      expect(
        widget.widgetEventListeners[DomEventType.change],
        equals(eventListenerForChange),
      );

      expect(
        widget.widgetEventListeners[DomEventType.input],
        equals(eventListenerForInput),
      );

      expect(
        widget.widgetEventListeners[DomEventType.submit],
        equals(eventListenerForSubmit),
      );

      expect(
        widget.widgetEventListeners[DomEventType.keyUp],
        equals(eventListenerForKeyUp),
      );

      expect(
        widget.widgetEventListeners[DomEventType.keyDown],
        equals(eventListenerForKeyDown),
      );

      expect(
        widget.widgetEventListeners[DomEventType.keyPress],
        equals(eventListenerForKeyPress),
      );

      expect(
        widget.widgetEventListeners[DomEventType.drag],
        equals(eventListenerForDrag),
      );

      expect(
        widget.widgetEventListeners[DomEventType.dragEnd],
        equals(eventListenerForDragEnd),
      );

      expect(
        widget.widgetEventListeners[DomEventType.dragEnter],
        equals(eventListenerForDragEnter),
      );

      expect(
        widget.widgetEventListeners[DomEventType.dragLeave],
        equals(eventListenerForDragLeave),
      );

      expect(
        widget.widgetEventListeners[DomEventType.dragOver],
        equals(eventListenerForDragOver),
      );

      expect(
        widget.widgetEventListeners[DomEventType.dragStart],
        equals(eventListenerForDragStart),
      );

      expect(
        widget.widgetEventListeners[DomEventType.drop],
        equals(eventListenerForDrop),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseDown],
        equals(eventListenerForMouseDown),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseEnter],
        equals(eventListenerForMouseEnter),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseLeave],
        equals(eventListenerForMouseLeave),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseMove],
        equals(eventListenerForMouseMove),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseOver],
        equals(eventListenerForMouseOver),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseOut],
        equals(eventListenerForMouseOut),
      );

      expect(
        widget.widgetEventListeners[DomEventType.mouseUp],
        equals(eventListenerForMouseUp),
      );

      var nonNullEventListeners = widget.widgetEventListeners.values.toList()
        ..removeWhere((domNode) => null == domNode);

      var nonNullCaptureEventListeners =
          widget.widgetCaptureEventListeners.values.toList()
            ..removeWhere((domNode) => null == domNode);

      expect(nonNullCaptureEventListeners.length, equals(0));
      expect(nonNullEventListeners.length, equals(22));
    });

    test('should set all (capturing phase)', () {
      var eventListenerForClick = (event) {};
      var eventListenerForDoubleClick = (event) {};
      var eventListenerForChange = (event) {};
      var eventListenerForInput = (event) {};
      var eventListenerForSubmit = (event) {};
      var eventListenerForKeyUp = (event) {};
      var eventListenerForKeyDown = (event) {};
      var eventListenerForKeyPress = (event) {};
      var eventListenerForDrag = (event) {};
      var eventListenerForDragEnd = (event) {};
      var eventListenerForDragEnter = (event) {};
      var eventListenerForDragLeave = (event) {};
      var eventListenerForDragOver = (event) {};
      var eventListenerForDragStart = (event) {};
      var eventListenerForDrop = (event) {};
      var eventListenerForMouseDown = (event) {};
      var eventListenerForMouseEnter = (event) {};
      var eventListenerForMouseLeave = (event) {};
      var eventListenerForMouseMove = (event) {};
      var eventListenerForMouseOver = (event) {};
      var eventListenerForMouseOut = (event) {};
      var eventListenerForMouseUp = (event) {};

      var widget = EventDetector(
        onClickCapture: eventListenerForClick,
        onDoubleClickCapture: eventListenerForDoubleClick,
        onChangeCapture: eventListenerForChange,
        onInputCapture: eventListenerForInput,
        onSubmitCapture: eventListenerForSubmit,
        onKeyUpCapture: eventListenerForKeyUp,
        onKeyDownCapture: eventListenerForKeyDown,
        onKeyPressCapture: eventListenerForKeyPress,
        onDragCapture: eventListenerForDrag,
        onDragEndCapture: eventListenerForDragEnd,
        onDragEnterCapture: eventListenerForDragEnter,
        onDragLeaveCapture: eventListenerForDragLeave,
        onDragOverCapture: eventListenerForDragOver,
        onDragStartCapture: eventListenerForDragStart,
        onDropCapture: eventListenerForDrop,
        onMouseDownCapture: eventListenerForMouseDown,
        onMouseEnterCapture: eventListenerForMouseEnter,
        onMouseLeaveCapture: eventListenerForMouseLeave,
        onMouseMoveCapture: eventListenerForMouseMove,
        onMouseOverCapture: eventListenerForMouseOver,
        onMouseOutCapture: eventListenerForMouseOut,
        onMouseUpCapture: eventListenerForMouseUp,
        child: Text('hello world'),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.click],
        equals(eventListenerForClick),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.doubleClick],
        equals(eventListenerForDoubleClick),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.change],
        equals(eventListenerForChange),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.input],
        equals(eventListenerForInput),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.submit],
        equals(eventListenerForSubmit),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.keyUp],
        equals(eventListenerForKeyUp),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.keyDown],
        equals(eventListenerForKeyDown),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.keyPress],
        equals(eventListenerForKeyPress),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.drag],
        equals(eventListenerForDrag),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.dragEnd],
        equals(eventListenerForDragEnd),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.dragEnter],
        equals(eventListenerForDragEnter),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.dragLeave],
        equals(eventListenerForDragLeave),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.dragOver],
        equals(eventListenerForDragOver),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.dragStart],
        equals(eventListenerForDragStart),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.drop],
        equals(eventListenerForDrop),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.mouseDown],
        equals(eventListenerForMouseDown),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.mouseEnter],
        equals(eventListenerForMouseEnter),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.mouseLeave],
        equals(eventListenerForMouseLeave),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.mouseMove],
        equals(eventListenerForMouseMove),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.mouseOver],
        equals(eventListenerForMouseOver),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.mouseOut],
        equals(eventListenerForMouseOut),
      );

      expect(
        widget.widgetCaptureEventListeners[DomEventType.mouseUp],
        equals(eventListenerForMouseUp),
      );

      var nonNullEventListeners = widget.widgetEventListeners.values.toList()
        ..removeWhere((domNode) => null == domNode);

      var nonNullCaptureEventListeners =
          widget.widgetCaptureEventListeners.values.toList()
            ..removeWhere((domNode) => null == domNode);

      expect(nonNullEventListeners.length, equals(0));
      expect(nonNullCaptureEventListeners.length, equals(22));
    });
  });
}
