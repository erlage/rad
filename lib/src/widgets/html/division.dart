import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_attributes.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/html/markup_tag_props.dart';

class Division extends MarkUpTagWithGlobalAttributes {
  Division({
    String? key,
    String? title,
    String? classes,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataset,
    bool? hidden,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          classes: classes,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataset: dataset,
          hidden: hidden,
          children: children,
        );

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => "$Division";

  @override
  createRenderObject(context) {
    return DivisionRenderObject(
      context: context,
      markUpTagProps: props(),
      children: children ?? [],
    );
  }
}

class DivisionRenderObject extends MultiChildRenderObject {
  MarkUpTagProps markUpTagProps;

  DivisionRenderObject({
    required this.markUpTagProps,
    required List<Widget> children,
    required BuildContext context,
  }) : super(children: children, context: context);

  @override
  beforeRender(widgetObject) {
    markUpTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant DivisionRenderObject updatedRenderObject,
  ) {
    markUpTagProps.apply(
      widgetObject.element,
      updatedRenderObject.markUpTagProps,
    );
  }
}
