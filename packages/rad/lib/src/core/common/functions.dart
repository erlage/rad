import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';

DomEventType? fnMapEventTypeToDomEventType(String eventType) {
  // could cache this map or maybe we can hardcode it.
  var typeMap = <String, DomEventType>{};

  for (final type in DomEventType.values) {
    typeMap[type.nativeName] = type;
  }

  return typeMap[eventType];
}

String fnEncodeValue(String value) => Uri.encodeComponent(value);

String fnDecodeValue(String value) => Uri.decodeComponent(value);

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

String? fnCommonPrepareClassAttribute({
  required String? classAttribute,
  required String? oldClassAttribute,
}) {
  if (null != classAttribute) {
    return classAttribute;
  } else {
    // clean old classes(if were set)
    if (null != oldClassAttribute && oldClassAttribute.isNotEmpty) {
      return '';
    }
  }

  return null;
}

Map<String, String?> fnCommonPrepareDataset({
  required Map<String, String>? dataAttributes,
  required Map<String, String>? oldDataAttributes,
}) {
  var prepared = <String, String?>{};

  if (null != dataAttributes) {
    for (final attributeName in dataAttributes.keys) {
      if (Constants.reservedAttributes.isNotEmpty) {
        if (Constants.reservedAttributes.contains(attributeName)) {
          continue;
        }
      }

      prepared[attributeName] = dataAttributes[attributeName];
    }
  }

  if (null != oldDataAttributes) {
    for (final attributeName in oldDataAttributes.keys) {
      if (Constants.reservedAttributes.isNotEmpty) {
        if (Constants.reservedAttributes.contains(attributeName)) {
          continue;
        }
      }

      if (!prepared.containsKey(attributeName)) {
        prepared[attributeName] = null;
      }
    }
  }

  return prepared;
}