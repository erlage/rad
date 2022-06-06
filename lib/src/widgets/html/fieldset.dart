import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The FieldSet widget (HTML's `fieldset` tag).
///
/// Group several controls as well as labels (<label>) within a web form.
///
class FieldSet extends HTMLWidgetBase {
  /// Whether field set is disabled.
  ///
  final bool? disabled;

  const FieldSet({
    this.disabled,
    Key? key,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? id,
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
  String get widgetType => 'FieldSet';

  @override
  DomTagType get correspondingTag => DomTagType.fieldSet;

  @override
  createConfiguration() {
    return _FieldSetConfiguration(
      disabled: disabled,
      globalConfiguration:
          super.createConfiguration() as HTMLWidgetBaseConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _FieldSetConfiguration oldConfiguration) {
    return disabled != oldConfiguration.disabled ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _FieldSetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _FieldSetConfiguration extends WidgetConfiguration {
  final HTMLWidgetBaseConfiguration globalConfiguration;

  final bool? disabled;

  const _FieldSetConfiguration({
    this.disabled,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _FieldSetRenderObject extends MarkUpGlobalRenderObject {
  const _FieldSetRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _FieldSetConfiguration configuration,
  }) {
    var domNodeDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant _FieldSetConfiguration oldConfiguration,
    required covariant _FieldSetConfiguration newConfiguration,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: newConfiguration,
        oldProps: oldConfiguration,
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
  required _FieldSetConfiguration props,
  required _FieldSetConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.disabled && props.disabled!) {
    attributes[Attributes.disabled] = '${props.disabled}';
  } else {
    if (null != oldProps?.disabled) {
      attributes[Attributes.disabled] = null;
    }
  }

  return attributes;
}
