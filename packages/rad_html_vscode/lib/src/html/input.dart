// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_input_base.dart';

/// The Input widget (HTML's `input` tag).
///
@internal
class Input extends HTMLInputBase {
  const Input(
    List<Widget> children, {
    InputType? type,
    String? name,
    bool? disabled,
    String? form,
    String? inputMode,
    int? tabIndex,
    String? value,
    Key? key,
    void Function(Element? element)? ref,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    EventCallback? onClick,
    EventCallback? onInput,
    EventCallback? onChange,
    EventCallback? onKeyUp,
    EventCallback? onKeyDown,
    EventCallback? onKeyPress,
    Map<String, String>? additionalAttributes,
  }) : super(
          children,
          name: name,
          form: form,
          value: value,
          tabIndex: tabIndex,
          disabled: disabled,
          inputMode: inputMode,
          type: type,
          key: key,
          ref: ref,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          onClick: onClick,
          onInput: onInput,
          onChange: onChange,
          onKeyUp: onKeyUp,
          onKeyDown: onKeyDown,
          onKeyPress: onKeyPress,
          additionalAttributes: additionalAttributes,
        );
}
