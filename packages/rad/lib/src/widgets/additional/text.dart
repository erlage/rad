// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

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

    // all these properties are marked experimental because we might
    // implement text nodes in future and text nodes cannot have these
    // properties

    @experimental String? title,
    @experimental String? style,
    @experimental String? classAttribute,
    @experimental bool? hidden,
    @experimental String? onClickAttribute,
    @experimental EventCallback? onClick,
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
