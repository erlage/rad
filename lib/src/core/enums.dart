enum DomTag {
  div,
  span,
}

enum MeasuringUnit {
  pixel,
  percent,
}

enum Alignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// How to behave during hit tests.
enum HitTestBehavior {
  /// Child gesture detectors will receive events and won't let them propagate to parents
  deferToChild,

  /// Receive events and prevent child gesture detectors from receiving events.
  opaque,

  /// All detectors that are hit will receive events.
  translucent,
}
