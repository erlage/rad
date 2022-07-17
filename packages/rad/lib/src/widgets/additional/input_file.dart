// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/input.dart';

/// The InputFile widget (HTML's `input` tag with `type = 'file'`).
///
class InputFile extends Input {
  const InputFile({
    Key? key,
    String? id,
    String? name,
    String? accept,
    bool? multiple,
    bool? required,
    bool? disabled,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onChange,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          type: InputType.file,
          name: name,
          accept: accept,
          multiple: multiple,
          disabled: disabled,
          required: required,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          innerText: innerText,
          child: child,
          children: children,
          onChange: onChange,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );
}
