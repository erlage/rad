import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/services/utils.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/common/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Form widget (HTML's `form` tag).
///
class Form extends MarkUpTagWithGlobalProps {
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
  final FormMethod? method;

  /// Indicates where to display the response after submitting the form.
  ///
  final String? target;

  /// On form submit.
  ///
  /// Use event.preventDefault() to prevent default action.
  ///
  final EventCallback? onSubmitEventListener;

  const Form({
    this.name,
    this.action,
    this.accept,
    this.enctype,
    this.target,
    this.method,
    this.onSubmitEventListener,
    String? key,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? onClick,
    EventCallback? onClickEventListener,
    String? innerText,
    Widget? child,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          onClick: onClick,
          onClickEventListener: onClickEventListener,
          child: child,
          children: children,
        );

  @nonVirtual
  @override
  get correspondingTag => DomTag.form;

  @override
  get concreteType => "$Form";

  @override
  createConfiguration() {
    return _FormConfiguration(
      name: name,
      value: action,
      accept: accept,
      enctype: enctype,
      method: method,
      onSubmitEventListener: onSubmitEventListener,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as _FormConfiguration;

    return name != oldConfiguration.name ||
        action != oldConfiguration.value ||
        accept != oldConfiguration.accept ||
        target != oldConfiguration.target ||
        enctype != oldConfiguration.enctype ||
        method != oldConfiguration.method ||
        onSubmitEventListener.runtimeType !=
            oldConfiguration.onSubmitEventListener.runtimeType ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _FormRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _FormConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? name;
  final String? value;
  final String? accept;
  final String? target;
  final FormEncType? enctype;
  final FormMethod? method;
  final EventCallback? onSubmitEventListener;

  const _FormConfiguration({
    this.name,
    this.value,
    this.accept,
    this.target,
    this.method,
    this.enctype,
    this.onSubmitEventListener,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _FormRenderObject extends RenderObject {
  const _FormRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _FormConfiguration configuration,
  ) {
    _FormProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _FormConfiguration oldConfiguration,
    required covariant _FormConfiguration newConfiguration,
  }) {
    _FormProps.clear(element, oldConfiguration);
    _FormProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _FormProps {
  static void apply(HtmlElement element, _FormConfiguration props) {
    element as FormElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.name) {
      element.name = props.name;
    }

    if (null != props.accept) {
      element.acceptCharset = props.accept;
    }

    if (null != props.target) {
      element.target = props.target;
    }

    if (null != props.method) {
      element.method = Utils.mapFormMethod(props.method!);
    }

    if (null != props.enctype) {
      element.enctype = Utils.mapFormEncType(props.enctype!);
    }

    if (null != props.onSubmitEventListener) {
      element.addEventListener(
        Utils.mapDomEventType(DomEventType.submit),
        props.onSubmitEventListener,
      );
    }
  }

  static void clear(HtmlElement element, _FormConfiguration props) {
    element as FormElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.name) {
      element.removeAttribute(_Attributes.name);
    }

    if (null != props.target) {
      element.removeAttribute(_Attributes.target);
    }

    if (null != props.accept) {
      element.removeAttribute(_Attributes.accept);
    }

    if (null != props.method) {
      element.removeAttribute(_Attributes.method);
    }

    if (null != props.enctype) {
      element.removeAttribute(_Attributes.enctype);
    }

    if (null != props.onSubmitEventListener) {
      element.removeEventListener(
        Utils.mapDomEventType(DomEventType.submit),
        props.onSubmitEventListener,
      );
    }
  }
}

class _Attributes {
  static const name = "name";
  static const accept = "accept";
  static const method = "method";
  static const enctype = "enctype";
  static const target = "target";
}
