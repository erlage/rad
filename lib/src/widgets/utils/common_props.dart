import 'package:rad/src/core/common/constants.dart';

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
    dataAttributes.removeWhere(
      (key, value) => Constants.allAttributes.contains(key),
    );

    for (final attributeName in dataAttributes.keys) {
      prepared[attributeName] = dataAttributes[attributeName];
    }
  }

  if (null != oldDataAttributes) {
    oldDataAttributes.removeWhere(
      (key, value) {
        var isSet = null != dataAttributes && dataAttributes.containsKey(key);
        var isReserved = Constants.allAttributes.contains(key);

        return isSet || isReserved;
      },
    );

    for (final attributeName in oldDataAttributes.keys) {
      prepared[attributeName] = null;
    }
  }

  return prepared;
}
