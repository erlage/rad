import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Progress widget (HTML's `progress` tag).
///
class Progress extends MarkUpTagWithGlobalProps {
  /// This attribute specifies how much of the task that has
  /// been completed.
  ///
  final num? value;

  /// This attribute describes how much work the task indicated
  /// by the progress element requires.
  ///
  final num? max;

  const Progress({
    this.value,
    this.max,
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
    String? onClick,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClickEventListener,
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
          onClick: onClick,
          innerText: innerText,
          child: child,
          children: children,
          onClickEventListener: onClickEventListener,
        );

  @nonVirtual
  @override
  get widgetType => '$Progress';

  @override
  get correspondingTag => DomTag.progress;

  @override
  createConfiguration() {
    return _ProgressConfiguration(
      value: value,
      max: max,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _ProgressConfiguration oldConfiguration) {
    return value != oldConfiguration.value ||
        max != oldConfiguration.max ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _ProgressRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _ProgressConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final num? value;
  final num? max;

  const _ProgressConfiguration({
    this.value,
    this.max,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _ProgressRenderObject extends MarkUpGlobalRenderObject {
  const _ProgressRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _ProgressConfiguration configuration,
  }) {
    var elementDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return elementDescription;
  }

  @override
  update({
    required updateType,
    required covariant _ProgressConfiguration oldConfiguration,
    required covariant _ProgressConfiguration newConfiguration,
  }) {
    var elementDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _prepareAttributes(
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

Map<String, String?> _prepareAttributes({
  required _ProgressConfiguration props,
  required _ProgressConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.max) {
    attributes[Attributes.max] = '${props.max}';
  } else {
    if (null != oldProps?.max) {
      attributes[Attributes.max] = null;
    }
  }

  if (null != props.value) {
    attributes[Attributes.value] = '${props.value}';
  } else {
    if (null != oldProps?.value) {
      attributes[Attributes.value] = null;
    }
  }

  return attributes;
}
