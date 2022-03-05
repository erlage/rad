import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/widgets/layout/align.dart';
import 'package:rad/src/widgets/layout/center.dart';
import 'package:rad/src/widgets/layout/column.dart';
import 'package:rad/src/widgets/layout/expanded.dart';
import 'package:rad/src/widgets/layout/flex.dart';
import 'package:rad/src/widgets/layout/flexible.dart';

/// A widget that displays its children in a horizontal array.
///
/// To cause a child to expand to fill the available horizontal space, wrap the
/// child in an [Expanded] widget.
///
/// The [Row] widget does not scroll (and in general it is considered an error
/// to have more children in a [Row] than will fit in the available room).
///
/// For a vertical variant, see [Column].
///
/// If you only have one child, then consider using [Align] or [Center] to
/// position the child.
///
/// See also:
///
///  * [Column], for a vertical equivalent.
///  * [Flex], if you don't know in advance if you want a horizontal or vertical
///  * [Expanded]
///  * [Flexible]
///
class Row extends Flex {
  Row({
    String? key,
    double? gap,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    required List<Widget> children,
  }) : super(
          key: key,
          gap: gap,
          axis: Axis.horizontal,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        );
}
