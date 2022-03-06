import 'package:rad/src/widgets/layout/column.dart';
import 'package:rad/src/widgets/layout/flex.dart';
import 'package:rad/src/widgets/layout/flexible.dart';
import 'package:rad/src/widgets/layout/row.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';

/// A widget that expands a child of a [Row], [Column], or [Flex]
/// so that the child fills the available space.
///
/// Using an [Expanded] widget makes a child of a [Row], [Column], or [Flex]
/// expand to fill the available space along the main axis (e.g., horizontally for
/// a [Row] or vertically for a [Column]). If multiple children are expanded,
/// the available space is divided among them according to the [flex] factor.
///
/// See also:
///
///  * [Flexible].
///
class Expanded extends Flexible {
  Expanded({
    String? key,
    int flex = 1,
    required Widget child,
  }) : super(
          key: key,
          flex: flex,
          child: child,
        );
}
