// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/input.dart';

/// The InputCheckBox widget (HTML's `input` tag with `type = 'checkbox'`).
///
class InputCheckBox extends Input {
  const InputCheckBox({
    Key? key,
    String? name,
    String? value,
    bool? checked,
    bool? required,
    bool? disabled,
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contentEditable,
    bool? hidden,
    String? onClickAttribute,
    String? innerText,
    List<Widget>? children,
    EventCallback? onChange,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          type: InputType.checkbox,
          name: name,
          value: value,
          checked: checked,
          disabled: disabled,
          required: required,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          hidden: hidden,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          children: children,
          onChange: onChange,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );
}
