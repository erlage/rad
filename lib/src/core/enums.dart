/// Units of measurement
///
/// [MeasuringUnit.pixel] means values will be translated to px
/// [MeasuringUnit.percent] means values will be translated to %
///
enum MeasuringUnit {
  pixel,
  percent,
}

/// Defines [GestureDetector] behaviour
///
enum HitTestBehavior {
  /// Child gesture detectors will receive events and won't let them propagate to parents
  ///
  deferToChild,

  /// Receive events and prevent child gesture detectors from receiving events.
  ///
  opaque,

  /// All detectors that are hit will receive events.
  ///
  translucent,
}

/// The two cardinal directions in two dimensions.
///
enum Axis {
  /// Left and right.
  ///
  horizontal,

  /// Up and down.
  ///
  vertical,
}

/// How the children should be placed along the main axis in a flex layout.
///
enum MainAxisAlignment {
  /// Place the children as close to the start of the main axis as possible.
  ///
  start,

  /// Place the children as close to the end of the main axis as possible.
  ///
  end,

  /// Place the children as close to the middle of the main axis as possible.
  ///
  center,

  /// Place the free space evenly between the children.
  ///
  spaceBetween,

  /// Place the free space evenly between the children as well as half of that
  /// space before and after the first and last child.
  ///
  spaceAround,

  /// Place the free space evenly between the children as well as before and
  /// after the first and last child.
  ///
  spaceEvenly,
}

/// How the children should be placed along the cross axis in a flex layout.
///
enum CrossAxisAlignment {
  /// Place the children with their start edge aligned with the start side of
  /// the cross axis.
  ///
  start,

  /// Place the children as close to the end of the cross axis as possible.
  ///
  end,

  /// Place the children so that their centers align with the middle of the
  /// cross axis.
  ///
  center,

  /// Require the children to fill the cross axis.
  ///
  stretch,

  /// Place the children along the cross axis such that their baselines match.
  ///
  baseline,
}

/// By default, flex items will all try to fit onto one line. You can change
/// that and allow the items to wrap as needed with this property.
///
enum FlexWrap {
  /// All flex items will be on one line
  /// (default)
  ///
  nowrap,

  /// Flex items will wrap onto multiple lines, from top to bottom.
  ///
  wrap,

  /// Flex items will wrap onto multiple lines from bottom to top.
  ///
  wrapReverse,
}

/*
|--------------------------------------------------------------------------
| internals
|--------------------------------------------------------------------------
*/

enum DomTag {
  div,
  span,
}

/// Type of margin.
///
/// Setting margin to zero can be problem in some layouts. Therefore
/// we try to set only side whos values are provided by the user. Remaining
/// sides are ignored.
///
enum MarginType {
  only,
  symmetric,
  allSame,
  allDifferent,
}

/// Type of padding.
///
enum PaddingType {
  only,
  symmetric,
  allSame,
  allDifferent,
}

/// Type of route entry.
///
enum RouterStackEntryType {
  push,
}
