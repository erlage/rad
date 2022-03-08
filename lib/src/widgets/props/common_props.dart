import 'dart:html';

class CommonProps {
  static void applyClasses(HtmlElement element, String? classes) {
    if (null != classes) {
      var classList = classes.split(" ");

      if (classList.isNotEmpty) {
        element.classes.addAll(classList);
      }
    }
  }

  static void applyDataset(HtmlElement element, Map<String, String>? dataset) {
    if (null != dataset && dataset.isNotEmpty) {
      element.dataset.addAll(dataset);
    }
  }

  static void clearClasses(HtmlElement element, String? classes) {
    if (null != classes) {
      var classList = classes.split(" ");

      if (classList.isNotEmpty) {
        element.classes.removeAll(classList);
      }
    }
  }

  static void clearDataset(HtmlElement element, Map<String, String>? dataset) {
    if (null != dataset) {
      if (dataset.isNotEmpty) {
        element.dataset.removeWhere(
          ((key, value) => dataset.containsKey(key)),
        );
      }
    }
  }
}
