import 'package:rad/rad.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_attributes.dart';
import 'package:rad/src/widgets/props/html/anchor_props.dart';
import 'package:rad/src/widgets/props/html/markup_tag_props.dart';

/// HTML Anchor tag.
///
class Anchor extends MarkUpTagWithGlobalAttributes {
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
    String? key,
    this.href,
    this.rel,
    this.target,
    this.download,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? classes,
    Map<String, String>? dataset,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          classes: classes,
          dataset: dataset,
          children: children,
        );

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  String get type => "$Anchor";

  @override
  DomTag get tag => DomTag.anchor;

  @override
  createRenderObject(context) {
    return AnchorRenderObject(
      context: context,
      children: children,
      markUpTagProps: props(),
      anchorTagProps: AnchorProps(
        href: href,
        rel: rel,
        target: target,
        download: download,
      ),
    );
  }
}

class AnchorRenderObject extends MultiChildRenderObject {
  MarkUpTagProps markUpTagProps;
  AnchorProps anchorTagProps;

  AnchorRenderObject({
    List<Widget>? children,
    required this.anchorTagProps,
    required this.markUpTagProps,
    required BuildContext context,
  }) : super(
          context: context,
          children: children ?? [],
        );

  @override
  beforeRender(widgetObject) {
    markUpTagProps.apply(widgetObject.element);
    anchorTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant AnchorRenderObject updatedRenderObject,
  ) {
    markUpTagProps.apply(
      widgetObject.element,
      updatedRenderObject.markUpTagProps,
    );

    anchorTagProps.apply(
      widgetObject.element,
      updatedRenderObject.anchorTagProps,
    );
  }
}
