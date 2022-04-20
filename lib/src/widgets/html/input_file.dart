import 'package:meta/meta.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';

/// The InputFile widget (HTML's `input` tag with `type = 'file'`).
///
class InputFile extends InputTag {
  const InputFile({
    Key? key,
    String? name,
    String? accept,
    bool? multiple,
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
          type: InputType.file,
          name: name,
          accept: accept,
          multiple: multiple,
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
  get concreteType => "$InputFile";
}
