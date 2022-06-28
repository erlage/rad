// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Meta information.
///
class MetaInformation {
  /// A unique id(within single app instance).
  ///
  final String informationId;

  /// The name and content attributes can be used together to provide document
  /// metadata in terms of name-value pairs, with the name attribute giving the
  /// metadata name, and the content attribute giving the value.
  ///
  final String? name;

  /// This attribute contains the value for the http-equiv or name attribute,
  /// depending on which is used.
  ///
  final String? content;

  /// This attribute declares the document's character encoding. If the
  /// attribute is present, its value must be an ASCII case-insensitive match
  /// for the string "utf-8", because UTF-8 is the only valid encoding for
  /// HTML5 documents. <meta> elements which declare a character encoding must
  /// be located entirely within the first 1024 bytes of the document.
  ///
  final String? charset;

  /// Defines a pragma directive.
  ///
  final String? httpEquiv;

  /// Any additional attributes.
  ///
  final Map<String, String>? additionalAttributes;

  MetaInformation({
    required this.informationId,
    this.name,
    this.content,
    this.charset,
    this.httpEquiv,
    this.additionalAttributes,
  });
}
