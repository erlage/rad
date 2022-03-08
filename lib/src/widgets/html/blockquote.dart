import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';
import 'package:rad/src/widgets/abstract/tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/html/blockquote_tag_props.dart';
import 'package:rad/src/widgets/props/html/global_tag_props.dart';

/// The Block Quotation tag.
///
class Blockquote extends TagWithGlobalProps {
  /// A URL for the source of the quotation may be given using the cite attribute.
  ///
  final String? cite;

  const Blockquote({
    String? key,
    this.cite,
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
  String get type => "$Blockquote";

  @override
  DomTag get tag => DomTag.blockquote;

  @override
  createRenderObject(context) {
    return BlockquoteRenderObject(
      context: context,
      children: children,
      globalTagProps: globalTagProps(),
      blockquoteProps: BlockquoteProps(cite),
    );
  }
}

class BlockquoteRenderObject extends MultiChildRenderObject {
  GlobalTagProps globalTagProps;
  BlockquoteProps blockquoteProps;

  BlockquoteRenderObject({
    List<Widget>? children,
    required this.globalTagProps,
    required this.blockquoteProps,
    required BuildContext context,
  }) : super(
          children: children ?? [],
          context: context,
        );

  @override
  beforeRender(widgetObject) {
    globalTagProps.apply(widgetObject.element);
    blockquoteProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant BlockquoteRenderObject updatedRenderObject,
  ) {
    globalTagProps.apply(
      widgetObject.element,
      updatedRenderObject.globalTagProps,
    );

    blockquoteProps.apply(
      widgetObject.element,
      updatedRenderObject.blockquoteProps,
    );
  }
}
