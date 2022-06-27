// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/input.dart';

/// The InputText widget (HTML's `input` tag with `type = 'text'`).
///
class InputText extends Input {
  const InputText({
    bool isPassword = false,
    Key? key,
    String? id,
    String? name,
    String? value,
    int? minLength,
    int? maxLength,
    String? pattern,
    String? placeholder,
    bool? required,
    bool? readOnly,
    bool? disabled,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contentEditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onInput,
    EventCallback? onChange,
    EventCallback? onClick,
    EventCallback? onKeyUp,
    EventCallback? onKeyDown,
    EventCallback? onKeyPress,
  }) : super(
          key: key,
          id: id,
          type: isPassword ? InputType.password : InputType.text,
          name: name,
          value: value,
          minLength: minLength,
          maxLength: maxLength,
          pattern: pattern,
          placeholder: placeholder,
          disabled: disabled,
          required: required,
          readOnly: readOnly,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          onInput: onInput,
          onChange: onChange,
          onKeyUp: onKeyUp,
          onKeyDown: onKeyDown,
          onKeyPress: onKeyPress,
        );
}
