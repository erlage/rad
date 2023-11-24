// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/raw_markup.dart';

/// A utility widget to print text on screen.
///
/// Note that [Text] widget wraps text in a span tag i.e [Text] widget is
/// not a pure HTML text-node.
///
/// ```dart
/// Text('some text');
///
/// // is equivalent to
///
/// Span(innerText: 'some text');
/// ```
///
/// This wrapper makes it easy to implement properties such as [style],
/// [className] on [Text] widget. It's very rare that you might run into need
/// of pure-text node, but if you do, you've two options:
///
/// - [RawMarkUp] widget.
/// - Or use innerText property on parent widget.
///
class Text extends HTMLWidgetBase {
  /// Text's contents.
  ///
  final String text;

  const Text(
    this.text, {
    Key? key,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    EventCallback? onClick,
  }) : super(
          key: key,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          onClick: onClick,
          innerText: text,
        );

  @override
  DomTagType? get correspondingTag => DomTagType.span;
}
