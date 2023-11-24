// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_input_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The InputUrl widget (HTML's `input` tag with `type = 'url'`).
///
class InputUrl extends HTMLInputBase {
  const InputUrl({
    String? autoComplete,
    String? list,
    int? maxLength,
    int? minLength,
    String? pattern,
    String? placeholder,
    bool? readOnly,
    bool? required,
    String? size,
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
          maxLength: maxLength,
          minLength: minLength,
          pattern: pattern,
          placeholder: placeholder,
          readOnly: readOnly,
          required: required,
          size: size,
          name: name,
          form: form,
          valueProperty: value,
          tabIndex: tabIndex,
          disabled: disabled,
          inputMode: inputMode,
          type: InputType.url,
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
