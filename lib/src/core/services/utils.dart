import 'dart:math';

import 'package:rad/src/core/enums.dart';

class Utils {
  static var _extraCounter = 0;
  static var _widgetCounter = 0;
  static final _random = Random();

  static String generateWidgetKey() {
    _widgetCounter++;
    return "_gen_" + _widgetCounter.toString() + "_" + Utils.random();
  }

  static String generateRandomKey() {
    _extraCounter++;
    return _extraCounter.toString() + "_" + Utils.random();
  }

  static String mapDomTag(DomTag tag) {
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
    }
  }

  static String mapDomEventType(DomEventType eventType) {
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

  static String mapInputType(InputType type) {
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

  static String mapButtonType(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.button:
        return "button";

      case ButtonType.submit:
        return "submit";

      case ButtonType.reset:
        return "reset";
    }
  }

  static String mapFormEncType(FormEncType type) {
    switch (type) {
      case FormEncType.applicationXwwwFormUrlEncoded:
        return "application/x-www-form-urlencoded";

      case FormEncType.multipartFormData:
        return "multipart/form-data";

      case FormEncType.textPlain:
        return "text/plain";
    }
  }

  static String mapFormMethod(FormMethod method) {
    switch (method) {
      case FormMethod.post:
        return "post";

      case FormMethod.get:
        return "get";
    }
  }

  static String random([int length = 6]) {
    var cSet = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => cSet.codeUnitAt(
          (_random).nextInt(
            cSet.length,
          ),
        ),
      ),
    );
  }

  static bool isKeyValueMapEqual(
    Map<String, String> mapOne,
    Map<String, String> mapTwo,
  ) {
    if (mapOne.length != mapTwo.length) return false;

    for (var key in mapOne.keys) {
      if (mapOne[key] != mapTwo[key]) return false;
    }

    return true;
  }

  static String encodeKeyValueMap(Map<String, String> valueMap) {
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
}
