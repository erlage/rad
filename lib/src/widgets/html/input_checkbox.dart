import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';

/// The InputCheckBox widget (HTML's `input` tag with `type = 'checkbox'`).
///
class InputCheckBox extends InputTag {
  const InputCheckBox({
    Key? key,
    String? name,
    String? value,
    bool? checked,
    bool? required,
    bool? disabled,
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? onClick,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onChangeEventListener,
    EventCallback? onClickEventListener,
  }) : super(
          key: key,
          id: id,
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
          innerText: innerText,
          child: child,
          children: children,
          onChangeEventListener: onChangeEventListener,
          onClickEventListener: onClickEventListener,
        );

  @nonVirtual
  @override
  get widgetType => "$InputCheckBox";
}
