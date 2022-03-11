import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Progress tag.
///
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
    String? key,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? innerText,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          innerText: innerText,
          children: children,
        );

  @override
  get concreteType => "$Progress";

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

class _ProgressRenderObject extends RenderObject {
  const _ProgressRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _ProgressConfiguration configuration,
  ) {
    _ProgressProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _ProgressConfiguration oldConfiguration,
    required covariant _ProgressConfiguration newConfiguration,
  }) {
    _ProgressProps.clear(element, oldConfiguration);
    _ProgressProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _ProgressProps {
  static void apply(HtmlElement element, _ProgressConfiguration props) {
    element as ProgressElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.value) {
      element.value = props.value!;
    }

    if (null != props.max) {
      element.max = props.max!;
    }
  }

  static void clear(HtmlElement element, _ProgressConfiguration props) {
    element as ProgressElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.value) {
      element.removeAttribute(_Attributes.value);
    }

    if (null != props.max) {
      element.removeAttribute(_Attributes.max);
    }
  }
}

class _Attributes {
  static const value = "value";
  static const max = "max";
}
