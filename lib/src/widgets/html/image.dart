import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';
import 'package:rad/src/widgets/abstract/tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/html/global_tag_props.dart';
import 'package:rad/src/widgets/props/html/image_tag_props.dart';
import 'package:rad/src/widgets/props/size_props.dart';

/// The Image tag.
///
class Image extends TagWithGlobalProps {
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
  String get type => "$Image";

  @override
  DomTag get tag => DomTag.image;

  @override
  createRenderObject(context) {
    return ImageRenderObject(
      context: context,
      children: children,
      globalTagProps: globalTagProps(),
      sizeProps: SizeProps(width: width, height: height, size: size),
      imageTagProps: ImageTagProps(src: src, alt: alt),
    );
  }
}

class ImageRenderObject extends MultiChildRenderObject {
  GlobalTagProps globalTagProps;

  ImageTagProps imageTagProps;

  SizeProps sizeProps;

  ImageRenderObject({
    List<Widget>? children,
    required this.sizeProps,
    required this.globalTagProps,
    required this.imageTagProps,
    required BuildContext context,
  }) : super(
          children: children ?? [],
          context: context,
        );

  @override
  beforeRender(widgetObject) {
    globalTagProps.apply(widgetObject.element);

    sizeProps.apply(widgetObject.element);

    imageTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant ImageRenderObject updatedRenderObject,
  ) {
    globalTagProps.apply(
      widgetObject.element,
      updatedRenderObject.globalTagProps,
    );

    sizeProps.apply(
      widgetObject.element,
      updatedRenderObject.sizeProps,
    );

    imageTagProps.apply(
      widgetObject.element,
      updatedRenderObject.imageTagProps,
    );
  }
}
