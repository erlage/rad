// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_input_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The InputMonth widget (HTML's `input` tag with `type = 'month'`).
///
class InputMonth extends HTMLInputBase {
  const InputMonth({
    String? autoComplete,
    String? list,
    String? max,
    String? min,
    bool? readOnly,
    bool? required,
    String? step,
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
    Map<String, String>? additionalAttributes,
  }) : super(
          autoComplete: autoComplete,
          list: list,
          max: max,
          min: min,
          readOnly: readOnly,
          required: required,
          step: step,
          name: name,
          form: form,
          valueProperty: value,
          tabIndex: tabIndex,
          disabled: disabled,
          inputMode: inputMode,
          type: InputType.month,
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
          additionalAttributes: additionalAttributes,
        );
}
