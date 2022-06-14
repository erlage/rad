import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Form widget (HTML's `form` tag).
///
class Form extends HTMLWidgetBase {
  /// Name of the form.
  ///
  final String? name;

  /// The URL that processes the form submission.
  ///
  final String? action;

  /// Comma-separated content types the server accepts.
  ///
  final String? accept;

  /// MIME type of the form submission.
  ///
  final FormEncType? enctype;

  /// The HTTP method to submit the form with.
  ///
  final FormMethodType? method;

  /// Indicates where to display the response after submitting the form.
  ///
  final String? target;

  /// On submit event listener.
  ///
  final EventCallback? onSubmit;

  const Form({
    this.name,
    this.action,
    this.accept,
    this.enctype,
    this.target,
    this.method,
    this.onSubmit,
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
  DomTagType get correspondingTag => DomTagType.form;

  @override
  String get widgetType => 'Form';

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners {
    if (null == onClick && null == onSubmit) {
      return ccImmutableEmptyMapOfEventListeners;
    }

    return {
      DomEventType.click: onClick,
      DomEventType.submit: onSubmit,
    };
  }

  @override
  bool shouldUpdateWidget(covariant Form oldWidget) {
    return name != oldWidget.name ||
        action != oldWidget.action ||
        accept != oldWidget.accept ||
        target != oldWidget.target ||
        enctype != oldWidget.enctype ||
        method != oldWidget.method ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => FormRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Form render element.
///
class FormRenderElement extends HTMLBaseElement {
  FormRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Form widget,
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
    required covariant Form oldWidget,
    required covariant Form newWidget,
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
  required Form widget,
  required Form? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.name) {
    attributes[Attributes.name] = widget.name;
  } else {
    if (null != oldWidget?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != widget.action) {
    attributes[Attributes.action] = widget.action;
  } else {
    if (null != oldWidget?.action) {
      attributes[Attributes.action] = null;
    }
  }

  if (null != widget.accept) {
    attributes[Attributes.accept] = widget.accept;
  } else {
    if (null != oldWidget?.accept) {
      attributes[Attributes.accept] = null;
    }
  }

  if (null != widget.target) {
    attributes[Attributes.target] = widget.target;
  } else {
    if (null != oldWidget?.target) {
      attributes[Attributes.target] = null;
    }
  }

  if (null != widget.method) {
    attributes[Attributes.method] = widget.method!.nativeName;
  } else {
    if (null != oldWidget?.method) {
      attributes[Attributes.method] = null;
    }
  }

  if (null != widget.enctype) {
    attributes[Attributes.enctype] = widget.enctype!.nativeName;
  } else {
    if (null != oldWidget?.enctype) {
      attributes[Attributes.enctype] = null;
    }
  }

  return attributes;
}
