import 'package:rad/src/core/common/enums.dart';

String fnMapDomTag(DomTag tag) {
  switch (tag) {
    case DomTag.header:
      return "header";

    case DomTag.footer:
      return "footer";

    case DomTag.navigation:
      return "nav";

    case DomTag.division:
      return "div";

    case DomTag.span:
      return "span";

    case DomTag.anchor:
      return "a";

    case DomTag.blockquote:
      return "blockquote";

    case DomTag.horizontalRule:
      return "hr";

    case DomTag.label:
      return "label";

    case DomTag.iFrame:
      return "iframe";

    case DomTag.breakLine:
      return "br";

    case DomTag.image:
      return "img";

    case DomTag.canvas:
      return "canvas";

    case DomTag.paragraph:
      return "p";

    case DomTag.input:
      return "input";

    case DomTag.form:
      return "form";

    case DomTag.fieldSet:
      return "fieldset";

    case DomTag.legend:
      return "legend";

    case DomTag.idiomatic:
      return "i";

    case DomTag.strong:
      return "strong";

    case DomTag.small:
      return "small";

    case DomTag.subScript:
      return "sub";

    case DomTag.superScript:
      return "sup";

    case DomTag.unOrderedList:
      return "ul";

    case DomTag.listItem:
      return "li";

    case DomTag.button:
      return "button";

    case DomTag.select:
      return "select";

    case DomTag.option:
      return "option";

    case DomTag.progress:
      return "progress";

    case DomTag.textArea:
      return "textarea";

    // headings

    case DomTag.heading1:
      return "h1";

    case DomTag.heading2:
      return "h2";

    case DomTag.heading3:
      return "h3";

    case DomTag.heading4:
      return "h4";

    case DomTag.heading5:
      return "h5";

    case DomTag.heading6:
      return "h6";

    // table related

    case DomTag.table:
      return "table";

    case DomTag.caption:
      return "caption";

    case DomTag.tableColumn:
      return "col";

    case DomTag.tableColumnGroup:
      return "colgroup";

    case DomTag.tableHead:
      return "thead";

    case DomTag.tableDataCell:
      return "td";

    case DomTag.tableHeaderCell:
      return "th";

    case DomTag.tableBody:
      return "tbody";

    case DomTag.tableFoot:
      return "tfoot";

    case DomTag.tableRow:
      return "tr";
  }
}

String fnMapDomEventType(DomEventType eventType) {
  switch (eventType) {
    case DomEventType.click:
      return "click";

    case DomEventType.change:
      return "change";

    case DomEventType.input:
      return "input";

    case DomEventType.submit:
      return "submit";
  }
}

DomEventType? fnMapEventTypeToDomEventType(String eventType) {
  // could cache this map or maybe we can hardcode it.
  var typeMap = <String, DomEventType>{};

  for (var type in DomEventType.values) {
    typeMap[fnMapDomEventType(type)] = type;
  }

  return typeMap[eventType];
}

String fnMapInputType(InputType type) {
  switch (type) {
    case InputType.text:
      return "text";

    case InputType.password:
      return "password";

    case InputType.file:
      return "file";

    case InputType.radio:
      return "radio";

    case InputType.checkbox:
      return "checkbox";

    case InputType.submit:
      return "submit";
  }
}

String fnMapButtonType(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.button:
      return "button";

    case ButtonType.submit:
      return "submit";

    case ButtonType.reset:
      return "reset";
  }
}

String fnMapFormEncType(FormEncType type) {
  switch (type) {
    case FormEncType.applicationXwwwFormUrlEncoded:
      return "application/x-www-form-urlencoded";

    case FormEncType.multipartFormData:
      return "multipart/form-data";

    case FormEncType.textPlain:
      return "text/plain";
  }
}

String fnMapFormMethod(FormMethod method) {
  switch (method) {
    case FormMethod.post:
      return "post";

    case FormMethod.get:
      return "get";
  }
}

bool fnIsKeyValueMapEqual(
  Map<String, String> mapOne,
  Map<String, String> mapTwo,
) {
  if (mapOne.length != mapTwo.length) return false;

  for (var key in mapOne.keys) {
    if (mapOne[key] != mapTwo[key]) return false;
  }

  return true;
}

String fnEncodeKeyValueMap(Map<String, String> valueMap) {
  var encodedMap = '';

  for (var key in valueMap.keys) {
    if (key.isNotEmpty) {
      encodedMap += '/${Uri.encodeComponent(key)}';
    }

    var value = valueMap[key];

    if (null != value && value.isNotEmpty) {
      encodedMap += '/${Uri.encodeComponent(valueMap[key]!)}';
    }
  }

  return encodedMap;
}
