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

/// Type of update event that's happend in parent tree.
///
/// Widgets can act according to type of update events.
///
enum UpdateType {
  /// A setState is called in parent tree.
  ///
  setState,

  /// A Navigator called open on page that this widget is in.
  ///
  navigatorOpen,
}

/*
|--------------------------------------------------------------------------
| internals
|--------------------------------------------------------------------------
*/

/// Widget's corresponding DOM tag.
///
enum DomTag {
  /// Division.
  ///
  div,

  /// Span.
  ///
  span,

  /// Anchor.
  ///
  anchor,

  /// Blockquote.
  ///
  blockquote,
}

enum WidgetAction {
  dispose,
  hideWidget,
  showWidget,
  updateWidget,
  skipRest,
}
