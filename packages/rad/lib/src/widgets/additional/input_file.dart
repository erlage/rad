// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_input_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The InputFile widget (HTML's `input` tag with `type = 'file'`).
///
class InputFile extends HTMLInputBase {
  const InputFile({
    String? accept,
    String? autoComplete,
    String? capture,
    String? list,
    bool? multiple,
    bool? readOnly,
    String? name,
    bool? disabled,
    String? form,
    String? inputMode,
    int? tabIndex,
    String? value,
    Key? key,
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
          accept: accept,
          autoComplete: autoComplete,
          capture: capture,
          list: list,
          multiple: multiple,
          readOnly: readOnly,
          name: name,
          form: form,
          value: value,
          tabIndex: tabIndex,
          disabled: disabled,
          inputMode: inputMode,
          type: InputType.file,
          key: key,
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
