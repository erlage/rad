// Copyright (c) 2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// App Mount options.
///
class MountOptions {
  /// Whether to inject Rad's inline styles.
  ///
  /// By default the framework will try to inject inline styles that
  /// are required to normalize behaviour of Rad's elements in the dom
  /// (such as the one's inserted by the router). In case inline styles
  /// are disabled on your web page(maybe using CSP headers for example)
  /// then you might see your browser issue a error when framework attempt
  /// to inject styles. In cases like these, directly import the linked CSS
  /// in your app using link tag and set [injectInlineStyles] to false to
  /// get rid of that error.
  ///
  /// CSS: https://raw.githubusercontent.com/erlage/rad/main/packages/rad/lib/src/css/main.css
  ///
  final bool injectInlineStyles;

  const MountOptions({
    required this.injectInlineStyles,
  });

  static const defaultMode = MountOptions(
    injectInlineStyles: true,
  );
}
