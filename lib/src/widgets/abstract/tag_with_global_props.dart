import 'package:rad/src/core/constants.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/props/html/global_tag_props.dart';

abstract class TagWithGlobalProps extends Widget {
  /// The title attribute specifies extra information about an element.
  ///
  final String? title;

  /// The classes attribute specifies one or more class names for an element.
  ///
  final String? classAttribute;

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
  final Map<String, String>? dataAttributes;

  /// The hidden attribute is a boolean attribute.
  /// When present, it specifies that an element is not yet, or
  /// is no longer, relevant.
  ///
  final bool? hidden;

  /// Children tags.
  ///
  final List<Widget>? children;

  const TagWithGlobalProps({
    String? id,
    this.title,
    this.tabIndex,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.children,
  }) : super(id);

  GlobalTagProps globalTagProps() => GlobalTagProps(
        title: title,
        tabIndex: tabIndex,
        classAttribute: classAttribute,
        dataAttributes: dataAttributes,
        hidden: hidden,
        draggable: draggable,
        contenteditable: contenteditable,
      );
}
