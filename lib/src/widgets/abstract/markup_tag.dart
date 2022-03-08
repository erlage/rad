import 'package:rad/src/core/constants.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/props/html/markup_tag_props.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';

/// HTML tag.
///
abstract class MarkUpTag extends Widget {
  /// The key attribute specifies a unique id for an HTML
  /// element (the value must be unique within the HTML document).
  ///
  final String? key;

  /// The title attribute specifies extra information about an element.
  ///
  final String? title;

  /// The classes attribute specifies one or more class names for an element.
  ///
  final String? classes;

  /// The tabindex attribute specifies the tab order of an
  /// element (when the "tab" button is used for navigating).
  ///
  final int? tabIndex;

  /// The draggable attribute specifies whether an element
  /// is draggable or not.
  ///
  final bool? draggable;

  /// The contenteditable attribute specifies whether the content of an
  /// element is editable or not.
  ///
  final bool? contenteditable;

  /// The data-* attributes is used to store custom data
  /// private to the page or application.
  ///
  final Map<String, String>? dataset;

  /// The hidden attribute is a boolean attribute.
  /// When present, it specifies that an element is not yet, or
  /// is no longer, relevant.
  ///
  final bool? hidden;

  /// Children tags.
  ///
  final List<Widget>? children;

  const MarkUpTag({
    this.key,
    this.title,
    this.tabIndex,
    this.classes,
    this.dataset,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.children,
  });

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return MarkUpTagRenderObject(
      context: context,
      children: children,
      markUpTagProps: MarkUpTagProps(
        title: title,
        tabIndex: tabIndex,
        classes: classes,
        dataset: dataset,
        hidden: hidden,
        draggable: draggable,
        contenteditable: contenteditable,
      ),
    );
  }
}

class MarkUpTagRenderObject extends MultiChildRenderObject {
  MarkUpTagProps markUpTagProps;

  MarkUpTagRenderObject({
    List<Widget>? children,
    required this.markUpTagProps,
    required BuildContext context,
  }) : super(
          children: children ?? [],
          context: context,
        );

  @override
  beforeRender(widgetObject) {
    markUpTagProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant MarkUpTagRenderObject updatedRenderObject,
  ) {
    markUpTagProps.apply(
      widgetObject.element,
      updatedRenderObject.markUpTagProps,
    );
  }
}
