// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_input_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The InputHidden widget (HTML's `input` tag with `type = 'hidden'`).
///
class InputHidden extends HTMLInputBase {
  const InputHidden({
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
          name: name,
          form: form,
          value: value,
          tabIndex: tabIndex,
          disabled: disabled,
          inputMode: inputMode,
          type: InputType.hidden,
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
