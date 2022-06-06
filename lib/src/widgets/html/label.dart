import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Label widget (HTML's `label` tag).
///
class Label extends HTMLWidgetBase {
  /// The value of the [forAttribute] attribute must be a single key for a
  /// labelable form-related dom node in the same document as the <label> dom
  /// node
  ///
  final String? forAttribute;

  const Label({
    Key? key,
    String? id,
    this.forAttribute,
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
  String get widgetType => 'Label';

  @override
  DomTagType get correspondingTag => DomTagType.label;

  @override
  createConfiguration() {
    return _LabelConfiguration(
      forAttribute: forAttribute,
      globalConfiguration:
          super.createConfiguration() as HTMLWidgetBaseConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _LabelConfiguration oldConfiguration) {
    return forAttribute != oldConfiguration.forAttribute ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _LabelRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _LabelConfiguration extends WidgetConfiguration {
  final HTMLWidgetBaseConfiguration globalConfiguration;

  final String? forAttribute;

  const _LabelConfiguration({
    this.forAttribute,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _LabelRenderObject extends MarkUpGlobalRenderObject {
  const _LabelRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _LabelConfiguration configuration,
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
    required covariant _LabelConfiguration oldConfiguration,
    required covariant _LabelConfiguration newConfiguration,
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
  required _LabelConfiguration props,
  required _LabelConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.forAttribute) {
    attributes[Attributes.forAttribute] = props.forAttribute;
  } else {
    if (null != oldProps?.forAttribute) {
      attributes[Attributes.forAttribute] = null;
    }
  }

  return attributes;
}
