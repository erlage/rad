import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/html/blockquote_tag_props.dart';

/// The Block Quotation tag.
///
class Blockquote extends Widget {
  /// The key attribute specifies a unique id for an HTML
  /// element (the value must be unique within the HTML document).
  ///
  final String? key;

  /// A URL for the source of the quotation may be given using the cite attribute.
  ///
  final String? cite;

  /// The classes attribute specifies one or more class names for an element.
  ///
  final String? classes;

  /// Children tags.
  ///
  final List<Widget>? children;

  const Blockquote({
    this.key,
    this.cite,
    this.classes,
    this.children,
  });

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  String get type => "$Blockquote";

  @override
  DomTag get tag => DomTag.blockquote;

  @override
  createRenderObject(context) {
    return BlockquoteRenderObject(
      context: context,
      children: children,
      blockquoteProps: BlockquoteProps(cite: cite, classes: classes),
    );
  }
}

class BlockquoteRenderObject extends MultiChildRenderObject {
  BlockquoteProps blockquoteProps;

  BlockquoteRenderObject({
    List<Widget>? children,
    required this.blockquoteProps,
    required BuildContext context,
  }) : super(
          children: children ?? [],
          context: context,
        );

  @override
  beforeRender(widgetObject) {
    blockquoteProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant BlockquoteRenderObject updatedRenderObject,
  ) {
    blockquoteProps.apply(
      widgetObject.element,
      updatedRenderObject.blockquoteProps,
    );
  }
}
