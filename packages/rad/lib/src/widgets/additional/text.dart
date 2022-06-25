// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/html/span.dart';

/// A utility widget to print text on screen.
///
/// Note that [Text] widget wraps text in a [Span] widget.
///
/// ```dart
/// Text('some text');
///
/// // is equivalent to
///
/// Span(innerText: 'some text');
/// ```
///
class Text extends Span {
  final String text;

  const Text(
    this.text, {
    Key? key,
    String? title,
    String? style,
    String? classAttribute,
    bool? hidden,
    String? onClickAttribute,
    EventCallback? onClick,
  }) : super(
          key: key,
          title: title,
          style: style,
          classAttribute: classAttribute,
          hidden: hidden,
          onClickAttribute: onClickAttribute,
          onClick: onClick,
          innerText: text,
        );
}
