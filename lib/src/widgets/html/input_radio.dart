import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';

/// The InputRadio widget (HTML's `input` tag with `type = 'radio'`).
///
class InputRadio extends InputTag {
  const InputRadio({
    Key? key,
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
    Widget? child,
    List<Widget>? children,
  }) : super(
          key: key,
          type: InputType.radio,
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
          child: child,
          children: children,
        );

  @nonVirtual
  @override
  get widgetType => "$InputRadio";
}
