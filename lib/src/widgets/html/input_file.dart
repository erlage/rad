import 'package:meta/meta.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';

class InputFile extends InputTag {
  const InputFile({
    String? key,
    String? name,
    String? accept,
    bool? multiple,
    bool? required,
    bool? disabled,
    EventCallback? onChange,
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
          type: InputType.file,
          name: name,
          accept: accept,
          multiple: multiple,
          disabled: disabled,
          eventListenerCallback: onChange,
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
  get concreteType => "$InputFile";
}
