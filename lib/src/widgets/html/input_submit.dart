import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The InputSubmit widget (HTML's `input` tag with `type = 'submit'`).
///
class InputSubmit extends InputTag {
  const InputSubmit({
    Key? key,
    String? id,
    String? name,
    String? value,
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
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClickEventListener,
  }) : super(
          key: key,
          id: id,
          type: InputType.submit,
          name: name,
          disabled: disabled,
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
          onClick: onClick,
          innerText: innerText,
          child: child,
          children: children,
          onClickEventListener: onClickEventListener,
        );

  @nonVirtual
  @override
  get widgetType => '$InputSubmit';
}
