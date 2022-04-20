import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/html/span.dart';
import 'package:rad/src/core/common/objects/key.dart';

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
    Key? key,
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
