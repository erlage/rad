import 'package:meta/meta.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';

class InputFile extends InputTag {
  const InputFile({
    String? id,
    String? name,
    String? accept,
    bool? multiple,
    bool? required,
    bool? disabled,
    OnInputChangeCallback? onChange,
    String? title,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
  }) : super(
          id: id,
          type: System.inputFile,
          name: name,
          accept: accept,
          multiple: multiple,
          disabled: disabled,
          eventCallback: onChange,
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
  get concreteType => "$InputFile";
}
