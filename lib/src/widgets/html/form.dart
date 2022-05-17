import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';

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

  const Form({
    this.name,
    this.action,
    this.accept,
    this.enctype,
    this.target,
    this.method,
    Key? key,
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? onClick,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onSubmitEventListener,
    EventCallback? onClickEventListener,
  }) : super(
          key: key,
          id: id,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          onClick: onClick,
          innerText: innerText,
          child: child,
          children: children,
          onSubmitEventListener: onSubmitEventListener,
          onClickEventListener: onClickEventListener,
        );

  @nonVirtual
  @override
  get correspondingTag => DomTag.form;

  @override
  get widgetType => "$Form";

  @override
  createConfiguration() {
    return _FormConfiguration(
      name: name,
      value: action,
      accept: accept,
      enctype: enctype,
      method: method,
      target: target,
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

  const _FormConfiguration({
    this.name,
    this.value,
    this.accept,
    this.target,
    this.method,
    this.enctype,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _FormRenderObject extends MarkUpGlobalRenderObject {
  _FormRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _FormConfiguration configuration,
  }) {
    var elementDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _FormProps.prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return elementDescription;
  }

  @override
  update({
    required updateType,
    required covariant _FormConfiguration oldConfiguration,
    required covariant _FormConfiguration newConfiguration,
  }) {
    var elementDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _FormProps.prepareAttributes(
        props: newConfiguration,
        oldProps: oldConfiguration,
      ),
    );

    return elementDescription;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _FormProps {
  static Map<String, String?> prepareAttributes({
    required _FormConfiguration props,
    required _FormConfiguration? oldProps,
  }) {
    var attributes = <String, String?>{};

    if (null != props.name) {
      attributes[Attributes.name] = props.name!;
    } else {
      if (null != oldProps?.name) {
        attributes[Attributes.name] = null;
      }
    }

    if (null != props.accept) {
      attributes[Attributes.accept] = props.accept!;
    } else {
      if (null != oldProps?.accept) {
        attributes[Attributes.accept] = null;
      }
    }

    if (null != props.target) {
      attributes[Attributes.target] = props.target!;
    } else {
      if (null != oldProps?.target) {
        attributes[Attributes.target] = null;
      }
    }

    if (null != props.method) {
      attributes[Attributes.method] = fnMapFormMethod(props.method!);
    } else {
      if (null != oldProps?.method) {
        attributes[Attributes.method] = null;
      }
    }

    if (null != props.enctype) {
      attributes[Attributes.enctype] = fnMapFormEncType(props.enctype!);
    } else {
      if (null != oldProps?.enctype) {
        attributes[Attributes.enctype] = null;
      }
    }

    return attributes;
  }
}
