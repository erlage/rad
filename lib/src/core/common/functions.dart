import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';

String fnMapDomTag(DomTag tag) {
  switch (tag) {
    case DomTag.abbreviation:
      return 'abbr';

    case DomTag.article:
      return 'article';

    case DomTag.code:
      return 'code';

    case DomTag.header:
      return 'header';

    case DomTag.footer:
      return 'footer';

    case DomTag.menu:
      return 'menu';

    case DomTag.navigation:
      return 'nav';

    case DomTag.division:
      return 'div';

    case DomTag.span:
      return 'span';

    case DomTag.anchor:
      return 'a';

    case DomTag.blockquote:
      return 'blockquote';

    case DomTag.horizontalRule:
      return 'hr';

    case DomTag.label:
      return 'label';

    case DomTag.iFrame:
      return 'iframe';

    case DomTag.breakLine:
      return 'br';

    case DomTag.image:
      return 'img';

    case DomTag.canvas:
      return 'canvas';

    case DomTag.paragraph:
      return 'p';

    case DomTag.input:
      return 'input';

    case DomTag.form:
      return 'form';

    case DomTag.fieldSet:
      return 'fieldset';

    case DomTag.legend:
      return 'legend';

    case DomTag.idiomatic:
      return 'i';

    case DomTag.strikeThrough:
      return 's';

    case DomTag.strong:
      return 'strong';

    case DomTag.small:
      return 'small';

    case DomTag.subScript:
      return 'sub';

    case DomTag.superScript:
      return 'sup';

    case DomTag.unOrderedList:
      return 'ul';

    case DomTag.listItem:
      return 'li';

    case DomTag.button:
      return 'button';

    case DomTag.select:
      return 'select';

    case DomTag.option:
      return 'option';

    case DomTag.progress:
      return 'progress';

    case DomTag.textArea:
      return 'textarea';

    // headings

    case DomTag.heading1:
      return 'h1';

    case DomTag.heading2:
      return 'h2';

    case DomTag.heading3:
      return 'h3';

    case DomTag.heading4:
      return 'h4';

    case DomTag.heading5:
      return 'h5';

    case DomTag.heading6:
      return 'h6';

    // table related

    case DomTag.table:
      return 'table';

    case DomTag.caption:
      return 'caption';

    case DomTag.tableColumn:
      return 'col';

    case DomTag.tableColumnGroup:
      return 'colgroup';

    case DomTag.tableHead:
      return 'thead';

    case DomTag.tableDataCell:
      return 'td';

    case DomTag.tableHeaderCell:
      return 'th';

    case DomTag.tableBody:
      return 'tbody';

    case DomTag.tableFoot:
      return 'tfoot';

    case DomTag.tableRow:
      return 'tr';
  }
}

String fnMapDomEventType(DomEventType eventType) {
  switch (eventType) {
    case DomEventType.click:
      return 'click';

    case DomEventType.change:
      return 'change';

    case DomEventType.input:
      return 'input';

    case DomEventType.submit:
      return 'submit';

    case DomEventType.keyUp:
      return 'keyup';

    case DomEventType.keyDown:
      return 'keydown';

    case DomEventType.keyPress:
      return 'keypress';
  }
}

DomEventType? fnMapEventTypeToDomEventType(String eventType) {
  // could cache this map or maybe we can hardcode it.
  var typeMap = <String, DomEventType>{};

  for (final type in DomEventType.values) {
    typeMap[fnMapDomEventType(type)] = type;
  }

  return typeMap[eventType];
}

String fnMapInputType(InputType type) {
  switch (type) {
    case InputType.text:
      return 'text';

    case InputType.password:
      return 'password';

    case InputType.file:
      return 'file';

    case InputType.radio:
      return 'radio';

    case InputType.checkbox:
      return 'checkbox';

    case InputType.submit:
      return 'submit';
  }
}

String fnMapButtonType(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.button:
      return 'button';

    case ButtonType.submit:
      return 'submit';

    case ButtonType.reset:
      return 'reset';
  }
}

String fnMapFormEncType(FormEncType type) {
  switch (type) {
    case FormEncType.applicationXwwwFormUrlEncoded:
      return 'application/x-www-form-urlencoded';

    case FormEncType.multipartFormData:
      return 'multipart/form-data';

    case FormEncType.textPlain:
      return 'text/plain';
  }
}

String fnMapFormMethod(FormMethod method) {
  switch (method) {
    case FormMethod.post:
      return 'post';

    case FormMethod.get:
      return 'get';
  }
}

String fnEncodeValue(String value) => Uri.encodeComponent(value);

String fnDecodeValue(String value) => Uri.decodeComponent(value);

bool fnIsKeyValueMapEqual(
  Map<String, String> mapOne,
  Map<String, String> mapTwo,
) {
  if (mapOne.length != mapTwo.length) return false;

  for (final key in mapOne.keys) {
    if (mapOne[key] != mapTwo[key]) return false;
  }

  return true;
}

String fnEncodeKeyValueMap(Map<String, String> valueMap) {
  var encodedMap = '';

  for (final key in valueMap.keys) {
    if (key.isNotEmpty) {
      encodedMap += '/${fnEncodeValue(key)}';
    }

    var value = valueMap[key];

    if (null != value && value.isNotEmpty) {
      encodedMap += '/${fnEncodeValue(valueMap[key]!)}';
    }
  }

  return encodedMap;
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
