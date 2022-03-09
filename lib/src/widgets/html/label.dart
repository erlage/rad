import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';
import 'package:rad/src/widgets/abstract/tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/html/global_tag_props.dart';
import 'package:rad/src/widgets/props/html/lable_tag_props.dart';

/// The Label tag.
///
class Label extends TagWithGlobalProps {
  /// The value of the [forAttribute] attribute must be a single id for a labelable
  /// form-related element in the same document as the <label> element.
  ///
  final String? forAttribute;

  const Label({
    String? id,
    this.forAttribute,
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
  String get type => "$Label";

  @override
  DomTag get tag => DomTag.label;

  @override
  createRenderObject(context) {
    return LabelRenderObject(
      context: context,
      children: children,
      globalTagProps: globalTagProps(),
      labelTagProps: LabelTagProps(forAttribute),
    );
  }
}

class LabelRenderObject extends MultiChildRenderObject {
  GlobalTagProps globalTagProps;
  LabelTagProps labelTagProps;

  LabelRenderObject({
    List<Widget>? children,
    required this.globalTagProps,
    required this.labelTagProps,
    required BuildContext context,
  }) : super(
          children: children ?? [],
          context: context,
        );

  @override
  beforeRender(widgetObject) {
    globalTagProps.apply(widgetObject.element);
    labelTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant LabelRenderObject updatedRenderObject,
  ) {
    globalTagProps.apply(
      widgetObject.element,
      updatedRenderObject.globalTagProps,
    );

    labelTagProps.apply(
      widgetObject.element,
      updatedRenderObject.labelTagProps,
    );
  }
}
