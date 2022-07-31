// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_input_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The InputCheckBox widget (HTML's `input` tag with `type = 'checkbox'`).
///
class InputCheckBox extends HTMLInputBase {
  const InputCheckBox({
    bool? checked,
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
    EventCallback? onChange,
    Map<String, String>? additionalAttributes,
  }) : super(
          checked: checked,
          required: required,
          name: name,
          form: form,
          inputMode: inputMode,
          tabIndex: tabIndex,
          value: value,
          disabled: disabled,
          type: InputType.checkbox,
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
          onChange: onChange,
          additionalAttributes: additionalAttributes,
        );
}
