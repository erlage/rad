import 'dart:html';

class CommonProps {
  static void applyClassAttribute(HtmlElement element, String? classAttribute) {
    if (null != classAttribute) {
      var classList = classAttribute.split(" ");

      if (classList.isNotEmpty) {
        element.classes.addAll(classList);
      }
    }
  }

  static void applyDataAttributes(
    HtmlElement element,
    Map<String, String>? dataAttributes,
  ) {
    if (null != dataAttributes && dataAttributes.isNotEmpty) {
      element.dataset.addAll(dataAttributes);
    }
  }

  static void clearClassAttribute(HtmlElement element, String? classAttribute) {
    if (null != classAttribute) {
      var classList = classAttribute.split(" ");

      if (classList.isNotEmpty) {
        element.classes.removeAll(classList);
      }
    }
  }

  static void clearDataAttributes(
    HtmlElement element,
    Map<String, String>? dataAttributes,
  ) {
    if (null != dataAttributes) {
      if (dataAttributes.isNotEmpty) {
        element.dataset.removeWhere(
          ((key, value) => dataAttributes.containsKey(key)),
        );
      }
    }
  }
}
