// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';

@internal
DomEventType? fnMapEventTypeToDomEventType(String eventType) {
  // could cache this map or maybe we can hardcode it.
  var typeMap = <String, DomEventType>{};

  for (final type in DomEventType.values) {
    typeMap[type.nativeValue] = type;
  }

  return typeMap[eventType];
}

@internal
String fnEncodeValue(String value) => Uri.encodeComponent(value);

@internal
String fnDecodeValue(String value) => Uri.decodeComponent(value);

@internal
bool fnIsKeyValueMapEqual(
  Map<String, String>? mapOne,
  Map<String, String>? mapTwo,
) {
  // 1. if same instance(or both are null)
  if (mapOne == mapTwo) return true;

  // 2. if one of them is null, this mean other is not
  if (null == mapOne || null == mapTwo) return false;

  // 3. if lengths are different
  if (mapOne.length != mapTwo.length) return false;

  // 4. walk
  for (final key in mapOne.keys) {
    if (mapOne[key] != mapTwo[key]) return false;
  }

  return true;
}

/// Return slash joined encoded key value map.
///
@internal
String fnEncodeKeyValueMap(Map<String, String> valueMap) {
  var encodedMapValues = <String>[];

  for (final key in valueMap.keys) {
    if (key.isNotEmpty) {
      encodedMapValues.add(fnEncodeValue(key));
    }

    var value = valueMap[key];

    if (null != value && value.isNotEmpty) {
      encodedMapValues.add(fnEncodeValue(valueMap[key]!));
    }
  }

  return encodedMapValues.join('/');
}
