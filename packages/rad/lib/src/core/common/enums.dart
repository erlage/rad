// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/widgets/gesture_detector.dart';

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

/// Type of layout.
///
enum LayoutType {
  /// Contain (Default).
  ///
  /// Widget will try containing itself in its parent bounds.
  ///
  contain,

  /// Expand.
  ///
  /// Widget will try adapting to the available screen size.
  ///
  expand,
}

/// Defines [GestureDetector] behaviour.
///
/// Applies to only tap/doubleTap events.
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

enum DomEventType {
  click('click'),
  doubleClick('dblclick'),
  change('change'),
  input('input'),
  submit('submit'),
  keyUp('keyup'),
  keyDown('keydown'),
  keyPress('keypress'),

  // drag

  drag('drag'),
  dragEnd('dragend'),
  dragEnter('dragenter'),
  dragLeave('dragleave'),
  dragOver('dragover'),
  dragStart('dragstart'),
  drop('drop'),

  // mouse events

  mouseDown('mousedown'),
  mouseEnter('mouseenter'),
  mouseLeave('mouseleave'),
  mouseMove('mousemove'),
  mouseOver('mouseover'),
  mouseOut('mouseout'),
  mouseUp('mouseup'),
  ;

  final String nativeName;

  const DomEventType(this.nativeName);
}

enum InputType {
  text('text'),
  password('password'),
  file('file'),
  radio('radio'),
  checkbox('checkbox'),
  submit('submit'),
  ;

  final String nativeName;

  const InputType(this.nativeName);
}

enum FormEncType {
  applicationXwwwFormUrlEncoded('application/x-www-form-urlencoded'),
  multipartFormData('multipart/form-data'),
  textPlain('text/plain'),
  ;

  final String nativeName;

  const FormEncType(this.nativeName);
}

enum FormMethodType {
  post('post'),
  get('get'),
  ;

  final String nativeName;

  const FormMethodType(this.nativeName);
}

/// Type of Button.
///
/// Possible values are [button], [submit] and [reset]
///
enum ButtonType {
  button('button'),
  submit('submit'),
  reset('reset'),
  ;

  final String nativeName;

  const ButtonType(this.nativeName);
}

/// Widget's corresponding DOM tag.
///
enum DomTagType {
  abbreviation('abbr'),
  article('article'),
  code('code'),
  header('header'),
  footer('footer'),
  menu('menu'),
  navigation('nav'),
  division('div'),
  span('span'),
  anchor('a'),
  blockQuote('blockquote'),
  horizontalRule('hr'),
  label('label'),
  iFrame('iframe'),
  breakLine('br'),
  image('img'),
  canvas('canvas'),
  paragraph('p'),
  input('input'),
  form('form'),
  fieldSet('fieldset'),
  idiomatic('i'),
  strong('strong'),
  strikeThrough('s'),
  small('small'),
  subScript('sub'),
  superScript('sup'),
  unOrderedList('ul'),
  listItem('li'),
  button('button'),
  select('select'),
  option('option'),
  legend('legend'),
  progress('progress'),
  textArea('textarea'),
  heading1('h1'),
  heading2('h2'),
  heading3('h3'),
  heading4('h4'),
  heading5('h5'),
  heading6('h6'),

  // table

  caption('caption'),
  table('table'),
  tableColumn('col'),
  tableColumnGroup('colgroup'),
  tableHead('thead'),
  tableDataCell('td'),
  tableHeaderCell('th'),
  tableBody('tbody'),
  tableFoot('tfoot'),
  tableRow('tr'),
  ;

  final String nativeName;

  const DomTagType(this.nativeName);
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

  /// Some logic has visited and want the widget to update.
  ///
  visitorUpdate,

  /// Undefined.
  ///
  undefined,
}

@internal
enum WidgetUpdateType {
  /// Add a new widget.
  ///
  add,

  /// Update a existing widget.
  ///
  update,

  /// Dispose widget.
  ///
  dispose,

  /// Dispose multiple widgets.
  ///
  disposeMultiple,

  /// Add new widgets without cleaning parent contents.
  ///
  addAllWithoutClean,

  /// Dispose all widgets under context.
  ///
  cleanParent,
}

@internal
enum WidgetAction {
  dispose,
  hideWidget,
  showWidget,
  updateWidget,
  skipRest,
}

@internal
enum SchedulerTaskType {
  build,
  update,
  manage,
  dispose,
  updateDependent,
  stimulateListener,
}

@internal
enum SchedulerEventType {
  sendNextTask,
}
