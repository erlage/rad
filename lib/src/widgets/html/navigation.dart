import 'package:rad/src/core/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/division.dart';

class Navigation extends Division {
  Navigation({
    String? key,
    String? title,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? innerText,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          innerText: innerText,
          children: children,
        );

  @override
  get concreteType => "$Navigation";

  @override
  get correspondingTag => DomTag.navigation;
}
