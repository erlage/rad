import 'package:rad/src/core/common/constants.dart';

Map<String, bool> fnCommonPrepareClasses({
  required String? classAttribute,
  required String? oldClassAttribute,
}) {
  var prepared = <String, bool>{};

  if (null != classAttribute) {
    var classList = _prepareClassList(classAttribute);

    for (final className in classList) {
      prepared[className] = true;
    }
  }

  if (null != oldClassAttribute) {
    var oldClassList = _prepareClassList(oldClassAttribute);

    for (final className in oldClassList) {
      prepared[className] = false;
    }
  }

  return prepared;
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

List<String> _prepareClassList(String classAttribute) {
  if (classAttribute.isEmpty) {
    return [];
  }

  return classAttribute.split(' ')..removeWhere((element) => element.isEmpty);
}
