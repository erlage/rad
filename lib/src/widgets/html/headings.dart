import 'package:rad/src/core/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/division.dart';

class Heading1 extends Division {
  Heading1({
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
  get concreteType => "$Heading1";

  @override
  get correspondingTag => DomTag.heading1;
}

class Heading2 extends Heading1 {
  Heading2({
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
  get concreteType => "$Heading2";

  @override
  get correspondingTag => DomTag.heading2;
}

class Heading3 extends Heading1 {
  Heading3({
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
  get concreteType => "$Heading3";

  @override
  get correspondingTag => DomTag.heading3;
}

class Heading4 extends Heading1 {
  Heading4({
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
  get concreteType => "$Heading4";

  @override
  get correspondingTag => DomTag.heading4;
}

class Heading5 extends Heading1 {
  Heading5({
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
  get concreteType => "$Heading5";

  @override
  get correspondingTag => DomTag.heading5;
}

class Heading6 extends Heading1 {
  Heading6({
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
  get concreteType => "$Heading6";

  @override
  get correspondingTag => DomTag.heading6;
}
