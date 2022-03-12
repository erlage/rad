import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/division.dart';

class UnOrderedList extends Division {
  UnOrderedList({
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
          children: children,
        );

  @override
  get concreteType => "$UnOrderedList";

  @override
  get correspondingTag => DomTag.unOrderedList;
}
