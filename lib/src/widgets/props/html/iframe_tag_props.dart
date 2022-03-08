import 'dart:html';

class IFrameTagProps {
  String? src;

  String? name;

  String? allow;

  bool? allowFullscreen;

  bool? allowPaymentRequest;

  IFrameTagProps({
    this.src,
    this.name,
    this.allow,
    this.allowFullscreen,
    this.allowPaymentRequest,
  });

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [IFrameTagProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  bool _isChanged(IFrameTagProps props) {
    return src != props.src ||
        name != props.name ||
        allow != props.allow ||
        allowFullscreen != props.allowFullscreen ||
        allowPaymentRequest != props.allowPaymentRequest;
  }

  void _switchProps(IFrameTagProps updatedProps) {
    this
      ..src = updatedProps.src
      ..name = updatedProps.name
      ..allow = updatedProps.allow
      ..allowFullscreen = updatedProps.allowFullscreen
      ..allowPaymentRequest = updatedProps.allowPaymentRequest;
  }

  // statics

  static void _applyProps(HtmlElement element, IFrameTagProps props) {
    element as IFrameElement;

    if (null != props.src) {
      element.src = props.src!;
    }

    if (null != props.name) {
      element.name = props.name!;
    }

    if (null != props.allow) {
      element.allow = props.allow;
    }

    if (null != props.allowFullscreen) {
      element.allowFullscreen = props.allowFullscreen!;
    }

    if (null != props.allowPaymentRequest) {
      element.allowPaymentRequest = props.allowPaymentRequest;
    }
  }

  static void _clearProps(HtmlElement element, IFrameTagProps props) {
    element as IFrameElement;

    if (null != props.src) {
      element.src = "";
    }

    if (null != props.name) {
      element.name = "";
    }

    if (null != props.allow) {
      element.allow = "";
    }

    if (null != props.allowFullscreen) {
      element.allowFullscreen = false;
    }

    if (null != props.allowPaymentRequest) {
      element.allowPaymentRequest = false;
    }
  }
}
