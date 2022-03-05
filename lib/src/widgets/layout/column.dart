import 'package:rad/rad.dart';

/// A widget that displays its children in a vertical array.
///
/// To cause a child to expand to fill the available vertical space, wrap the
/// child in an [Expanded] widget.
///
/// The [Column] widget does not scroll (and in general it is considered an error
/// to have more children in a [Column] than will fit in the available room).
///
/// For a horizontal variant, see [Row].
///
/// If you only have one child, then consider using [Align] or [Center] to
/// position the child.
///
/// When the contents of a [Column] exceed the amount of space available, the
/// [Column] overflows, and the contents are clipped.
///
/// See also:
///
///  * [Row], for a horizontal equivalent.
///  * [Flex], if you don't know in advance if you want a horizontal or vertical
///  * [Expanded]
///  * [Flexible]
///
class Column extends Flex {
  Column({
    String? key,
    double? gap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    required List<Widget> children,
  }) : super(
          key: key,
          gap: gap,
          axis: Axis.vertical,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
}
