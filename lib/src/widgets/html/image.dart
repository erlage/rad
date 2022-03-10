import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// The Image tag.
///
class Image extends MarkUpTagWithGlobalProps {
  /// Image src.
  ///
  final String? src;

  /// Alt text for image.
  ///
  final String? alt;

  // size props

  final String? width;
  final String? height;
  final String? size;

  const Image({
    this.src,
    this.alt,
    this.width,
    this.height,
    this.size,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    List<Widget>? children,
  }) : super(
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          children: children,
        );

  @override
  String get concreteType => "$Image";

  @override
  DomTag get correspondingTag => DomTag.image;

  @override
  createConfiguration() {
    return _ImageConfiguration(
      src: src,
      alt: alt,
      width: width,
      height: height,
      size: size,
      globalPropsConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _ImageConfiguration oldConfiguration) {
    return src != oldConfiguration.src ||
        alt != oldConfiguration.alt ||
        width != oldConfiguration.width ||
        height != oldConfiguration.height ||
        size != oldConfiguration.size ||
        super.isChanged(oldConfiguration.globalPropsConfiguration);
  }

  @override
  createRenderObject(context) => _ImageRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _ImageConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalPropsConfiguration;

  final String? src;

  final String? alt;

  final String? width;

  final String? height;

  final String? size;

  const _ImageConfiguration({
    this.src,
    this.alt,
    this.width,
    this.height,
    this.size,
    required this.globalPropsConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _ImageRenderObject extends RenderObject {
  const _ImageRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _ImageConfiguration configuration,
  ) {
    _ImageProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _ImageConfiguration oldConfiguration,
    required covariant _ImageConfiguration newConfiguration,
  }) {
    _ImageProps.clear(element, oldConfiguration);
    _ImageProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _ImageProps {
  static void apply(HtmlElement element, _ImageConfiguration props) {
    element as ImageElement;

    MarkUpGlobalProps.apply(element, props.globalPropsConfiguration);

    CommonProps.applySizeProps(
      element,
      width: props.width,
      height: props.height,
      size: props.size,
    );

    if (null != props.src) {
      element.src = props.src;
    }

    if (null != props.alt) {
      element.alt = props.alt!;
    }
  }

  static void clear(HtmlElement element, _ImageConfiguration props) {
    element as ImageElement;

    MarkUpGlobalProps.clear(element, props.globalPropsConfiguration);

    CommonProps.clearSizeProps(
      element,
      width: props.width,
      height: props.height,
      size: props.size,
    );

    if (null != props.src) {
      element.src = "";
    }

    if (null != props.alt) {
      element.alt = "";
    }
  }
}
