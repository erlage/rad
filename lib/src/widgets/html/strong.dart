import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Strong widget (HTML's `strong` tag).
///
/// This HTML element indicates that its contents have strong importance,
/// seriousness, or urgency. Browsers typically render the contents in bold type.
///
class Strong extends MarkUpTagWithGlobalProps {
  const Strong({
    String? key,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? onClick,
    EventCallback? onClickEventListener,
    String? innerText,
    Widget? child,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          onClick: onClick,
          onClickEventListener: onClickEventListener,
          innerText: innerText,
          child: child,
          children: children,
        );

  @override
  get concreteType => "$Strong";

  @override
  get correspondingTag => DomTag.strong;
}
