// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Variable widget (HTML's `var` tag).
///
class Variable extends HTMLWidgetBase {
  const Variable({
    Key? key,
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
    String? id,
    String? title,
    String? style,
    String? className,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          hidden: hidden,
          style: style,
          className: className,
          contentEditable: contentEditable,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @nonVirtual
  @override
  String get widgetType => 'Variable';

  @override
  DomTagType get correspondingTag => DomTagType.variable;
}
