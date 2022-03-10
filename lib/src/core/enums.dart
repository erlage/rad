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

enum DomEventType {
  click,
  change,
  input,
  submit,
}

enum InputType {
  text,
  password,
  file,
  radio,
  checkbox,
  submit,
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

  /// Horizontal rule. (hr)
  ///
  horizontalRule,

  /// Label tag.
  ///
  label,

  /// Iframe tag.
  ///
  iFrame,

  /// Break line tag.
  ///
  breakLine,

  /// Image tag.
  ///
  image,

  /// Paragraph tag.
  ///
  paragraph,

  /// Form input tag.
  ///
  input,

  /// Form tag.
  ///
  form,
}

enum WidgetAction {
  dispose,
  hideWidget,
  showWidget,
  updateWidget,
  skipRest,
}
