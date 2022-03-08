import 'dart:html';

class _Props {
  static const width = "width";
  static const height = "height";
  static const margin = "margin";
  static const padding = "padding";
}

class SizeProps {
  String? margin;
  String? padding;

  String? width;
  String? height;
  String? size;

  SizeProps({
    this.size,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [SizeProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  bool _isChanged(SizeProps props) {
    return size != props.size ||
        width != props.width ||
        height != props.height ||
        margin != props.margin ||
        padding != props.padding;
  }

  void _switchProps(SizeProps props) {
    this
      ..size = props.size
      ..width = props.width
      ..height = props.height
      ..margin = props.margin
      ..padding = props.padding;
  }

  // statics

  static void _applyProps(HtmlElement element, SizeProps props) {
    var size = props.size;

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
      if (null != props.width) {
        element.style.setProperty(_Props.width, props.width);
      }

      if (null != props.height) {
        element.style.setProperty(_Props.height, props.height);
      }
    }

    if (null != props.margin) {
      element.style.setProperty(_Props.margin, props.margin);
    }

    if (null != props.padding) {
      element.style.setProperty(_Props.padding, props.padding);
    }
  }

  static void _clearProps(HtmlElement element, SizeProps props) {
    var size = props.size;

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
      if (null != props.width) {
        element.style.removeProperty(_Props.width);
      }

      if (null != props.height) {
        element.style.removeProperty(_Props.height);
      }
    }

    if (null != props.margin) {
      element.style.removeProperty(_Props.margin);
    }

    if (null != props.padding) {
      element.style.removeProperty(_Props.padding);
    }
  }
}
