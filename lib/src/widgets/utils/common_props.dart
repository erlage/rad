import 'dart:html';

class _Props {
  static const width = "width";
  static const height = "height";
}

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

  static void applySizeProps(
    HtmlElement element, {
    String? width,
    String? height,
    String? size,
  }) {
    if (null != size && size.isNotEmpty) {
      var sizeProps = size.split(" ");

      if (sizeProps.isNotEmpty) {
        if ("_" != sizeProps.first) {
          element.style.setProperty(_Props.width, sizeProps.first);
        }

        if (sizeProps.length > 1 && "_" != sizeProps[1]) {
          element.style.setProperty(_Props.height, sizeProps[1]);
        }
      }
    } else {
      if (null != width) {
        element.style.setProperty(_Props.width, width);
      }

      if (null != height) {
        element.style.setProperty(_Props.height, height);
      }
    }
  }

  static void clearSizeProps(
    HtmlElement element, {
    String? width,
    String? height,
    String? size,
  }) {
    if (null != size && size.isNotEmpty) {
      var sizeProps = size.split(" ");

      if (sizeProps.isNotEmpty) {
        if ("_" != sizeProps.first) {
          element.style.removeProperty(_Props.width);
        }

        if (sizeProps.length > 1 && "_" != sizeProps[1]) {
          element.style.removeProperty(_Props.height);
        }
      }
    } else {
      if (null != width) {
        element.style.removeProperty(_Props.width);
      }

      if (null != height) {
        element.style.removeProperty(_Props.height);
      }
    }
  }
}