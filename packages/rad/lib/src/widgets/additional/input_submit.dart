// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/input.dart';

/// The InputSubmit widget (HTML's `input` tag with `type = 'submit'`).
///
class InputSubmit extends Input {
  const InputSubmit({
    Key? key,
    String? id,
    String? name,
    String? value,
    bool? required,
    bool? disabled,
    String? title,
    String? style,
    String? className,
    int? tabIndex,
    bool? draggable,
    bool? contentEditable,
    bool? hidden,
    String? innerText,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          type: InputType.submit,
          name: name,
          disabled: disabled,
          value: value,
          required: required,
          title: title,
          style: style,
          className: className,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          hidden: hidden,
          innerText: innerText,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );
}
