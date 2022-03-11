import 'package:meta/meta.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';

class InputSubmit extends InputTag {
  const InputSubmit({
    String? key,
    String? name,
    String? value,
    bool? required,
    bool? disabled,
    EventCallback? onClick,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
  }) : super(
          key: key,
          type: InputType.submit,
          name: name,
          disabled: disabled,
          eventCallback: onClick,
          value: value,
          required: required,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
        );

  @nonVirtual
  @override
  get concreteType => "$InputSubmit";
}
