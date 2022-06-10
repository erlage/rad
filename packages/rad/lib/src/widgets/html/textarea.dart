import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The TextArea widget (HTML's `textarea` tag).
///
/// This HTML dom node represents a multi-line plain-text editing control,
/// useful when you want to allow users to enter a sizeable amount of free-form
/// text, for example a comment on a review or feedback form.
///
class TextArea extends HTMLWidgetBase {
  final String? name;

  final String? placeholder;

  final int? rows;
  final int? cols;
  final int? minLength;
  final int? maxLength;

  final bool? required;
  final bool? readOnly;
  final bool? disabled;

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

  const TextArea({
    this.name,
    this.placeholder,
    this.rows,
    this.cols,
    this.minLength,
    this.maxLength,
    this.required,
    this.readOnly,
    this.disabled,
    this.onChange,
    this.onInput,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
        );

  @nonVirtual
  @override
  String get widgetType => 'TextArea';

  @override
  DomTagType get correspondingTag => DomTagType.textArea;

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
  bool shouldWidgetUpdate(covariant TextArea oldWidget) {
    return name != oldWidget.name ||
        placeholder != oldWidget.placeholder ||
        rows != oldWidget.rows ||
        cols != oldWidget.cols ||
        minLength != oldWidget.minLength ||
        maxLength != oldWidget.maxLength ||
        required != oldWidget.required ||
        readOnly != oldWidget.readOnly ||
        disabled != oldWidget.disabled ||
        super.shouldWidgetUpdate(oldWidget);
  }

  @override
  createRenderObject(context) => _TextAreaRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TextAreaRenderObject extends MarkUpGlobalRenderObject {
  const _TextAreaRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant TextArea widget,
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
    required covariant TextArea oldWidget,
    required covariant TextArea newWidget,
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
  required TextArea widget,
  required TextArea? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.name) {
    attributes[Attributes.name] = widget.name;
  } else {
    if (null != oldWidget?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != widget.placeholder) {
    attributes[Attributes.placeholder] = widget.placeholder;
  } else {
    if (null != oldWidget?.placeholder) {
      attributes[Attributes.placeholder] = null;
    }
  }

  if (null != widget.rows) {
    attributes[Attributes.rows] = '${widget.rows}';
  } else {
    if (null != oldWidget?.rows) {
      attributes[Attributes.rows] = null;
    }
  }

  if (null != widget.cols) {
    attributes[Attributes.cols] = '${widget.cols}';
  } else {
    if (null != oldWidget?.cols) {
      attributes[Attributes.cols] = null;
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
