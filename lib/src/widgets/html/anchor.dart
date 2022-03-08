import 'package:rad/rad.dart';
import 'package:rad/src/widgets/props/anchor_tag_props.dart';

/// HTML Anchor tag.
///
class Anchor extends Widget {
  /// The key attribute specifies a unique id for an HTML
  /// element (the value must be unique within the HTML document).
  ///
  final String? key;

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

  /// The classes attribute specifies one or more class names for an element.
  ///
  final String? classes;

  /// The data-* attributes is used to store custom data
  /// private to the page or application.
  ///
  final Map<String, String>? dataset;

  /// Children tags.
  ///
  final List<Widget>? children;

  const Anchor({
    this.key,
    this.href,
    this.rel,
    this.target,
    this.download,
    this.classes,
    this.dataset,
    this.children,
  });

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  String get type => "$Anchor";

  @override
  DomTag get tag => DomTag.anchor;

  @override
  createRenderObject(context) {
    return AnchorTagRenderObject(
      context: context,
      children: children,
      anchorTagProps: AnchorTagProps(
        href: href,
        rel: rel,
        target: target,
        download: download,
        classes: classes,
        dataset: dataset,
      ),
    );
  }
}

class AnchorTagRenderObject extends MultiChildRenderObject {
  AnchorTagProps anchorTagProps;

  AnchorTagRenderObject({
    List<Widget>? children,
    required this.anchorTagProps,
    required BuildContext context,
  }) : super(
          children: children ?? [],
          context: context,
        );

  @override
  beforeRender(widgetObject) {
    anchorTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant AnchorTagRenderObject updatedRenderObject,
  ) {
    anchorTagProps.apply(
      widgetObject.element,
      updatedRenderObject.anchorTagProps,
    );
  }
}
