// Copyright 2022-2023 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';

/// The Strong widget (HTML's `strong` tag).
///
/// This HTML dom node indicates that its contents have strong importance,
/// seriousness, or urgency. Browsers typically render the contents in bold type
///
@internal
class Strong extends HTMLWidgetBase {
  const Strong(
    List<Widget> children, {
    Key? key,
    void Function(Element? element)? ref,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          children,
          key: key,
          ref: ref,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @override
  DomTagType get correspondingTag => DomTagType.strong;
}
