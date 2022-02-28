import 'package:rad/src/widgets/layout/align.dart';

enum DomTag {
  div,
  span,
}

enum MeasuringUnit {
  pixel,
  percent,
}

/// Alignment enum
/// to be used with [Align] widget
///
enum Alignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Defines [GestureDetector] behaviour
enum HitTestBehavior {
  /// Child gesture detectors will receive events and won't let them propagate to parents
  deferToChild,

  /// Receive events and prevent child gesture detectors from receiving events.
  opaque,

  /// All detectors that are hit will receive events.
  translucent,
}
