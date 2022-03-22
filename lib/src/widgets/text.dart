import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/html/span.dart';

/// A utility widget to print text on screen.
///
/// Note that [Text] widget wraps text in a [Span] widget.
///
/// ```dart
/// Text('some text');
///
/// // is equivalent to
///
/// Span(innerText: 'some text');
/// ```
///
class Text extends Span {
  const Text(
    String text, {
    String? key,
    String? title,
    String? style,
    String? classAttribute,
    bool? hidden,
    String? onClick,
    EventCallback? onClickEventListener,
  }) : super(
          key: key,
          title: title,
          style: style,
          classAttribute: classAttribute,
          hidden: hidden,
          onClick: onClick,
          onClickEventListener: onClickEventListener,
          innerText: text,
        );

  @override
  get concreteType => "$Text";

  @override
  get correspondingTag => DomTag.span;
}
