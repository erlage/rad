import 'package:rad/src/core/enums.dart';
import 'package:rad/src/widgets/layout/column.dart';
import 'package:rad/src/widgets/layout/expanded.dart';
import 'package:rad/src/widgets/layout/flex.dart';
import 'package:rad/src/widgets/layout/row.dart';
import 'package:rad/src/widgets/layout/sized_box.dart';

/// Spacer creates an adjustable, empty spacer that can be used to tune the
/// spacing between widgets in a [Flex] container, like [Row] or [Column].
///
/// The [Spacer] widget will take up any available space, so setting the
/// [Flex.mainAxisAlignment] on a flex container that contains a [Spacer] to
/// [MainAxisAlignment.spaceAround], [MainAxisAlignment.spaceBetween], or
/// [MainAxisAlignment.spaceEvenly] will not have any visible effect: the
/// [Spacer] has taken up all of the additional space, therefore there is none
/// left to redistribute.
///
///  * [Row] and [Column], which are the most common containers to use a Spacer
///    in.
///  * [SizedBox], to create a box with a specific size and an optional child.
///
class Spacer extends Expanded {
  Spacer({
    String? key,
    int flex = 1,
  }) : super(
          key: key,
          flex: flex,
          child: SizedBox.shrink(),
        );
}
