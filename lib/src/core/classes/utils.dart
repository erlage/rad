import 'dart:math';

import 'package:rad/src/core/enums.dart';

class Utils {
  static var _extraCounter = 0;
  static var _widgetCounter = 0;

  static String generateWidgetKey() {
    _widgetCounter++;
    return _widgetCounter.toString() + "_" + Utils.random();
  }

  static String generateRandomKey() {
    _extraCounter++;
    return _extraCounter.toString() + "_" + Utils.random();
  }

  static String mapDomTag(DomTag tag) {
    switch (tag) {
      case DomTag.div:
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

      case DomTag.paragraph:
        return "p";

      case DomTag.input:
        return "input";

      case DomTag.form:
        return "form";
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

  static String mapFormEncType(FormEncType type) {
    switch (type) {
      case FormEncType.applicationXwwFormUrlEncoded:
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
          (Random()).nextInt(
            cSet.length,
          ),
        ),
      ),
    );
  }
}
