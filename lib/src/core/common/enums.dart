import 'package:rad/src/widgets/gesture_detector.dart';

/// Defines [GestureDetector] behaviour
///
enum HitTestBehavior {
  /// Child gesture detectors will receive events and won't let them propagate
  /// to parents
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

  /// When a inherited dependency changes.
  ///
  dependencyChanged,

  /// When lazy builder(such as ListView.builder) append new childs.
  ///
  lazyBuild,

  /// Undefined.
  ///
  undefined,
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

enum FormEncType {
  applicationXwwwFormUrlEncoded,
  multipartFormData,
  textPlain,
}

enum FormMethod {
  post,
  get,
}

/// Type of Button.
///
/// Possible values are [button], [submit] and [reset]
///
enum ButtonType {
  button,
  submit,
  reset,
}

/// Widget's corresponding DOM tag.
///
enum DomTag {
  header,
  footer,
  navigation,
  division,
  span,
  anchor,
  blockquote,
  horizontalRule,
  label,
  iFrame,
  breakLine,
  image,
  canvas,
  paragraph,
  input,
  form,
  fieldSet,
  idiomatic,
  strong,
  small,
  subScript,
  superScript,
  unOrderedList,
  listItem,
  button,
  select,
  option,
  legend,
  progress,
  textArea,
  heading1,
  heading2,
  heading3,
  heading4,
  heading5,
  heading6,
}

enum WidgetAction {
  dispose,
  hideWidget,
  showWidget,
  updateWidget,
  skipRest,
}

enum SchedulerTaskType {
  build,
  update,
  manage,
  dispose,
  updateDependent,
  stimulateListener,
}

enum SchedulerEventType {
  sendNextTask,
}
