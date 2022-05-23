import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
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
    Key? key,
    String? title,
    String? style,
    String? classAttribute,
    bool? hidden,
    String? onClickAttribute,
    EventCallback? onClick,
  }) : super(
          key: key,
          title: title,
          style: style,
          classAttribute: classAttribute,
          hidden: hidden,
          onClickAttribute: onClickAttribute,
          onClick: onClick,
          innerText: text,
        );

  @override
  DomTag get correspondingTag => DomTag.span;
}
