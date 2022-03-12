import 'package:meta/meta.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class InputCheckBox extends InputTag {
  const InputCheckBox({
    String? key,
    String? name,
    String? value,
    bool? checked,
    bool? required,
    bool? disabled,
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
    EventCallback? onChangeEventListener,
    String? innerText,
    List<Widget>? children,
  }) : super(
          key: key,
          type: InputType.checkbox,
          name: name,
          value: value,
          checked: checked,
          disabled: disabled,
          required: required,
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
          eventListenerCallback: onChangeEventListener,
          innerText: innerText,
          children: children,
        );

  @nonVirtual
  @override
  get concreteType => "$InputCheckBox";
}
