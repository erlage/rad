import 'package:rad/src/core/constants.dart';
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
  /// The value of the [htmlFor] attribute must be a single id for a labelable
  /// form-related element in the same document as the <label> element.
  ///
  final String? htmlFor;

  const Label({
    String? key,
    this.htmlFor,
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
  String get type => "$Label";

  @override
  DomTag get tag => DomTag.label;

  @override
  createRenderObject(context) {
    return LabelRenderObject(
      context: context,
      children: children,
      globalTagProps: globalTagProps(),
      labelTagProps: LabelTagProps(htmlFor),
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
