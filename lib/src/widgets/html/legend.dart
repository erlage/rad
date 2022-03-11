import 'package:rad/src/core/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/division.dart';

/// The <legend> HTML element represents a caption for the content of
/// its parent <fieldset>.
///
class Legend extends Division {
  Legend({
    String? key,
    String? title,
    String? style,
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
          style: style,
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
  get concreteType => "$Legend";

  @override
  get correspondingTag => DomTag.legend;
}
