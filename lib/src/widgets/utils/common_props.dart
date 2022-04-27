import 'dart:html';

import 'package:rad/src/core/common/constants.dart';

class CommonProps {
  static void applyClassAttribute(HtmlElement element, String? classAttribute) {
    if (null != classAttribute && classAttribute.isNotEmpty) {
      var classList = classAttribute.split(" ")
        ..removeWhere((element) => element.isEmpty);

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
      // clean system reserved attributes(if user has set as part of dataset)
      dataAttributes.removeWhere(
        (key, value) => Constants.allAttributes.contains(key),
      );

      element.dataset.addAll(dataAttributes);
    }
  }

  static void clearClassAttribute(HtmlElement element, String? classAttribute) {
    if (null != classAttribute && classAttribute.isNotEmpty) {
      var classList = classAttribute.split(" ")
        ..removeWhere((element) => element.isEmpty);

      if (classList.isNotEmpty) {
        element.classes.removeAll(classList);
      }
    }
  }

  static void clearDataAttributes(
    HtmlElement element,
    Map<String, String>? dataAttributes,
  ) {
    if (null != dataAttributes && dataAttributes.isNotEmpty) {
      element.dataset.removeWhere(
        (key, value) => dataAttributes.containsKey(key),

        // no need to check whether attributes contains any system reserved
        // attributes beacuse oldAttributes were cleaned during the time of
        // initial apply in apply() function.

        // return attr...contain..(key) && !Constants.allAttr...contains(key);
      );
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
          element.style.width = sizeProps.first;
        }

        if (sizeProps.length > 1 && "_" != sizeProps[1]) {
          element.style.height = sizeProps[1];
        }
      }
    } else {
      if (null != width) {
        element.style.width = width;
      }

      if (null != height) {
        element.style.height = height;
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

class _Props {
  static const width = "width";
  static const height = "height";
}
