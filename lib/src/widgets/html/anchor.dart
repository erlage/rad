import 'package:rad/rad.dart';
import 'package:rad/src/widgets/abstract/tag_with_global_props.dart';
import 'package:rad/src/widgets/props/html/anchor_tag_props.dart';
import 'package:rad/src/widgets/props/html/global_tag_props.dart';

/// HTML Anchor tag.
///
class Anchor extends TagWithGlobalProps {
  /// The URL that the hyperlink points to.
  ///
  final String? href;

  /// The relationship of the linked URL as space-separated link types.
  ///
  final String? rel;

  /// Where to display the linked URL.
  ///
  final String? target;

  /// Prompts the user to save the linked URL instead of navigating to it.
  /// Can be used with or without a value.
  ///
  final String? download;

  const Anchor({
    String? id,
    this.href,
    this.rel,
    this.target,
    this.download,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? classAttribute,
    Map<String, String>? dataset,
    List<Widget>? children,
  }) : super(
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          classAttribute: classAttribute,
          dataAttributes: dataset,
          children: children,
        );

  @override
  String get initialId => id ?? System.idNotSet;

  @override
  String get type => "$Anchor";

  @override
  DomTag get tag => DomTag.anchor;

  @override
  createRenderObject(context) {
    return AnchorRenderObject(
      context: context,
      children: children,
      globalTagProps: globalTagProps(),
      anchorTagProps: AnchorTagProps(
        href: href,
        rel: rel,
        target: target,
        download: download,
      ),
    );
  }
}

class AnchorRenderObject extends MultiChildRenderObject {
  GlobalTagProps globalTagProps;
  AnchorTagProps anchorTagProps;

  AnchorRenderObject({
    List<Widget>? children,
    required this.anchorTagProps,
    required this.globalTagProps,
    required BuildContext context,
  }) : super(
          context: context,
          children: children ?? [],
        );

  @override
  beforeRender(widgetObject) {
    globalTagProps.apply(widgetObject.element);
    anchorTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant AnchorRenderObject updatedRenderObject,
  ) {
    globalTagProps.apply(
      widgetObject.element,
      updatedRenderObject.globalTagProps,
    );

    anchorTagProps.apply(
      widgetObject.element,
      updatedRenderObject.anchorTagProps,
    );
  }
}
