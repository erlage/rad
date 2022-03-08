import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';
import 'package:rad/src/widgets/abstract/tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/html/global_tag_props.dart';
import 'package:rad/src/widgets/props/html/iframe_tag_props.dart';
import 'package:rad/src/widgets/props/size_props.dart';

/// The IFrame tag.
///
class IFrame extends TagWithGlobalProps {
  /// src of Iframe.
  ///
  final String? src;

  /// A targetable name for the embedded browsing context.
  ///
  final String? name;

  /// Specifies a feature policy for the <iframe>.
  ///
  final String? allow;

  /// This attribute is considered a legacy attribute.
  ///
  final bool? allowFullscreen;

  /// Set to true if a cross-origin <iframe> should be
  /// allowed to invoke the Payment Request API.
  ///
  final bool? allowPaymentRequest;

  // size props

  final String? width;
  final String? height;
  final String? size;
  final String? margin;
  final String? padding;

  const IFrame({
    this.src,
    this.name,
    this.allow,
    this.allowFullscreen,
    this.allowPaymentRequest,
    this.width,
    this.height,
    this.size,
    this.margin,
    this.padding,
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
  String get initialId => id ?? System.idNotSet;

  @override
  String get type => "$IFrame";

  @override
  DomTag get tag => DomTag.iFrame;

  @override
  createRenderObject(context) {
    return IFrameRenderObject(
      context: context,
      children: children,
      globalTagProps: globalTagProps(),
      sizeProps: SizeProps(
        width: width,
        height: height,
        size: size,
        padding: padding,
        margin: margin,
      ),
      iFrameTagProps: IFrameTagProps(
        src: src,
        name: name,
        allow: allow,
        allowFullscreen: allowFullscreen,
        allowPaymentRequest: allowPaymentRequest,
      ),
    );
  }
}

class IFrameRenderObject extends MultiChildRenderObject {
  GlobalTagProps globalTagProps;

  IFrameTagProps iFrameTagProps;

  SizeProps sizeProps;

  IFrameRenderObject({
    List<Widget>? children,
    required this.sizeProps,
    required this.globalTagProps,
    required this.iFrameTagProps,
    required BuildContext context,
  }) : super(
          children: children ?? [],
          context: context,
        );

  @override
  beforeRender(widgetObject) {
    globalTagProps.apply(widgetObject.element);

    sizeProps.apply(widgetObject.element);

    iFrameTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant IFrameRenderObject updatedRenderObject,
  ) {
    globalTagProps.apply(
      widgetObject.element,
      updatedRenderObject.globalTagProps,
    );

    sizeProps.apply(
      widgetObject.element,
      updatedRenderObject.sizeProps,
    );

    iFrameTagProps.apply(
      widgetObject.element,
      updatedRenderObject.iFrameTagProps,
    );
  }
}
