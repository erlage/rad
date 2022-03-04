import 'package:rad/src/core/props/alignment.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/widgets/layout/align.dart';

/// A widget that centers its child within itself.
///
class Center extends Align {
  const Center({
    String? key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          alignment: Alignment.center,
        );
}
