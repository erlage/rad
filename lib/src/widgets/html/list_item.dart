import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The ListItem(li) tag.
///
///
class ListItem extends MarkUpTagWithGlobalProps {
  /// Value of list item.
  ///
  final int? value;

  const ListItem({
    this.value,
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
  get concreteType => "$ListItem";

  @override
  get correspondingTag => DomTag.listItem;

  @override
  createConfiguration() {
    return _ListItemConfiguration(
      value: value,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _ListItemConfiguration oldConfiguration) {
    return value != oldConfiguration.value ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _ListItemRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _ListItemConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final int? value;

  const _ListItemConfiguration({
    this.value,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _ListItemRenderObject extends RenderObject {
  const _ListItemRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _ListItemConfiguration configuration,
  ) {
    _ListItemProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _ListItemConfiguration oldConfiguration,
    required covariant _ListItemConfiguration newConfiguration,
  }) {
    _ListItemProps.clear(element, oldConfiguration);
    _ListItemProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _ListItemProps {
  static void apply(HtmlElement element, _ListItemConfiguration props) {
    element as LIElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.value) {
      element.value = props.value!;
    }
  }

  static void clear(HtmlElement element, _ListItemConfiguration props) {
    element as LIElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.value) {
      element.removeAttribute(_Attributes.value);
    }
  }
}

class _Attributes {
  static const value = "value";
}
