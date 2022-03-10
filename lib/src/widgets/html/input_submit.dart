import 'package:meta/meta.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';

class InputSubmit extends InputTag {
  const InputSubmit({
    String? id,
    String? name,
    String? value,
    bool? required,
    bool? disabled,
    OnInputChangeCallback? onClick,
    String? title,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
  }) : super(
          id: id,
          type: System.inputSubmit,
          name: name,
          disabled: disabled,
          eventCallback: onClick,
          value: value,
          required: required,
          title: title,
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
