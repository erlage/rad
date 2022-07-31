// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_input_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The InputNumber widget (HTML's `input` tag with `type = 'number'`).
///
class InputNumber extends HTMLInputBase {
  const InputNumber({
    String? autoComplete,
    String? list,
    String? placeholder,
    bool? readOnly,
    bool? required,
    String? name,
    bool? disabled,
    String? form,
    String? inputMode,
    int? tabIndex,
    String? value,
    Key? key,
    NullableElementCallback? ref,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
    EventCallback? onInput,
    EventCallback? onChange,
    EventCallback? onKeyUp,
    EventCallback? onKeyDown,
    EventCallback? onKeyPress,
    Map<String, String>? additionalAttributes,
  }) : super(
          autoComplete: autoComplete,
          list: list,
          placeholder: placeholder,
          readOnly: readOnly,
          required: required,
          name: name,
          form: form,
          valueProperty: value,
          tabIndex: tabIndex,
          disabled: disabled,
          inputMode: inputMode,
          type: InputType.number,
          key: key,
          ref: ref,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          onInput: onInput,
          onChange: onChange,
          onKeyUp: onKeyUp,
          onKeyDown: onKeyDown,
          onKeyPress: onKeyPress,
          additionalAttributes: additionalAttributes,
        );
}
