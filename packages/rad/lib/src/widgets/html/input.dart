import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Input widget (HTML's `input` tag).
///
class Input extends HTMLWidgetBase {
  /// Type of input tag.
  ///
  final InputType? type;

  /// Name of the input. It's very common to use same name as key
  /// for inputs.
  ///
  final String? name;

  /// Initial value of control.
  ///
  final String? value;

  /// Defines the file types the file input should accept.
  ///
  final String? accept;

  /// Min length of input.
  ///
  final int? minLength;

  /// Max length of input.
  ///
  final int? maxLength;

  /// Match pattern for input.
  ///
  final String? pattern;

  /// Custom placeholder.
  ///
  final String? placeholder;

  /// Allows the user to select more than one file.
  ///
  final bool? multiple;

  /// Whether control is required.
  ///
  final bool? required;

  /// Whether control is disabled.
  ///
  final bool? disabled;

  /// Whether control is read only.
  ///
  final bool? readOnly;

  /// Whether control is checked.
  ///
  final bool? checked;

  /// On input event listener.
  ///
  final EventCallback? onInput;

  /// On change event listener.
  ///
  final EventCallback? onChange;

  /// On key up event listener.
  ///
  final EventCallback? onKeyUp;

  /// On key down event listener.
  ///
  final EventCallback? onKeyDown;

  /// On key press event listener.
  ///
  final EventCallback? onKeyPress;

  const Input({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.placeholder,
    this.multiple,
    this.required,
    this.checked,
    this.readOnly,
    this.disabled,
    this.onInput,
    this.onChange,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,
    Key? key,
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contentEditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
  }) : super(
          key: key,
          id: id,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
        );

  @nonVirtual
  @override
  DomTagType get correspondingTag => DomTagType.input;

  @nonVirtual
  @override
  String get widgetType => 'Input';

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners => {
        DomEventType.click: onClick,
        DomEventType.input: onInput,
        DomEventType.change: onChange,
        DomEventType.keyUp: onKeyUp,
        DomEventType.keyDown: onKeyDown,
        DomEventType.keyPress: onKeyPress,
      };

  @override
  bool shouldUpdateWidget(covariant Input oldWidget) {
    return type != oldWidget.type ||
        name != oldWidget.name ||
        value != oldWidget.value ||
        accept != oldWidget.accept ||
        minLength != oldWidget.minLength ||
        maxLength != oldWidget.maxLength ||
        pattern != oldWidget.pattern ||
        placeholder != oldWidget.placeholder ||
        multiple != oldWidget.multiple ||
        checked != oldWidget.checked ||
        required != oldWidget.required ||
        readOnly != oldWidget.readOnly ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => InputRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Input render element.
///
class InputRenderElement extends HTMLBaseElement {
  InputRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Input widget,
  }) {
    var domNodeDescription = super.render(
      widget: widget,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        widget: widget,
        oldWidget: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant Input oldWidget,
    required covariant Input newWidget,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        widget: newWidget,
        oldWidget: oldWidget,
      ),
    );

    return domNodeDescription;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required Input widget,
  required Input? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.type) {
    attributes[Attributes.type] = widget.type!.nativeName;
  } else {
    if (null != oldWidget?.type) {
      attributes[Attributes.type] = null;
    }
  }

  if (null != widget.name) {
    attributes[Attributes.name] = widget.name;
  } else {
    if (null != oldWidget?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != widget.value) {
    attributes[Attributes.value] = widget.value;
  } else {
    if (null != oldWidget?.value) {
      attributes[Attributes.value] = null;
    }
  }

  if (null != widget.accept) {
    attributes[Attributes.accept] = widget.accept;
  } else {
    if (null != oldWidget?.accept) {
      attributes[Attributes.accept] = null;
    }
  }

  if (null != widget.placeholder) {
    attributes[Attributes.placeholder] = widget.placeholder;
  } else {
    if (null != oldWidget?.placeholder) {
      attributes[Attributes.placeholder] = null;
    }
  }

  if (null != widget.pattern) {
    attributes[Attributes.pattern] = widget.pattern;
  } else {
    if (null != oldWidget?.pattern) {
      attributes[Attributes.pattern] = null;
    }
  }

  if (null != widget.minLength) {
    attributes[Attributes.minLength] = '${widget.minLength}';
  } else {
    if (null != oldWidget?.minLength) {
      attributes[Attributes.minLength] = null;
    }
  }

  if (null != widget.maxLength) {
    attributes[Attributes.maxLength] = '${widget.maxLength}';
  } else {
    if (null != oldWidget?.maxLength) {
      attributes[Attributes.maxLength] = null;
    }
  }

  if (null != widget.multiple && widget.multiple!) {
    attributes[Attributes.multiple] = '${widget.multiple}';
  } else {
    if (null != oldWidget?.multiple) {
      attributes[Attributes.multiple] = null;
    }
  }

  if (null != widget.checked && widget.checked!) {
    attributes[Attributes.checked] = '${widget.checked}';
  } else {
    if (null != oldWidget?.checked) {
      attributes[Attributes.checked] = null;
    }
  }

  if (null != widget.required && widget.required!) {
    attributes[Attributes.required] = '${widget.required}';
  } else {
    if (null != oldWidget?.required) {
      attributes[Attributes.required] = null;
    }
  }

  if (null != widget.readOnly && widget.readOnly!) {
    attributes[Attributes.readOnly] = '${widget.readOnly}';
  } else {
    if (null != oldWidget?.readOnly) {
      attributes[Attributes.readOnly] = null;
    }
  }

  if (null != widget.disabled && widget.disabled!) {
    attributes[Attributes.disabled] = '${widget.disabled}';
  } else {
    if (null != oldWidget?.disabled) {
      attributes[Attributes.disabled] = null;
    }
  }

  return attributes;
}
