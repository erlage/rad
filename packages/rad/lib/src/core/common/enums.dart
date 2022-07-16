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

/// Type of DOM event.
///
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

/// Text render direction.
///
enum TextDirection {
  leftToRight('ltr'),
  rightToLeft('rtl'),
  auto('auto'),
  ;

  final String nativeName;

  const TextDirection(this.nativeName);
}

/// HTML Input type.
///
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

/// HTML form's encoding type.
///
enum FormEncType {
  applicationXwwwFormUrlEncoded('application/x-www-form-urlencoded'),
  multipartFormData('multipart/form-data'),
  textPlain('text/plain'),
  ;

  final String nativeName;

  const FormEncType(this.nativeName);
}

/// Type of ordered list.
///
enum OrderedListType {
  lowerCaseLetters('a'),
  upperCaseLetters('A'),
  lowerCaseRomanNumerals('i'),
  upperCaseRomanNumerals('I'),
  numbers('1'),
  get('get'),
  ;

  final String nativeName;

  const OrderedListType(this.nativeName);
}

/// HTML form's method type.
///
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
  address('address'),
  anchor('a'),
  article('article'),
  aside('aside'),
  bidirectionalTextOverride('bdo'),
  bidirectionalIsolate('bdi'),
  blockQuote('blockquote'),
  breakLine('br'),
  button('button'),
  canvas('canvas'),
  caption('caption'),
  citation('cite'),
  code('code'),
  data('data'),
  definition('dfn'),
  descriptionDetails('dd'),
  descriptionList('dl'),
  descriptionTerm('dt'),
  division('div'),
  emphasis('em'),
  fieldSet('fieldset'),
  figure('figure'),
  figureCaption('figcaption'),
  footer('footer'),
  form('form'),
  header('header'),
  heading1('h1'),
  heading2('h2'),
  heading3('h3'),
  heading4('h4'),
  heading5('h5'),
  heading6('h6'),
  horizontalRule('hr'),
  idiomatic('i'),
  iFrame('iframe'),
  image('img'),
  input('input'),
  label('label'),
  legend('legend'),
  listItem('li'),
  menu('menu'),
  navigation('nav'),
  orderedList('ol'),
  option('option'),
  paragraph('p'),
  preformattedText('pre'),
  progress('progress'),
  select('select'),
  small('small'),
  span('span'),
  strikeThrough('s'),
  strong('strong'),
  subScript('sub'),
  superScript('sup'),
  table('table'),
  tableBody('tbody'),
  tableColumn('col'),
  tableColumnGroup('colgroup'),
  tableDataCell('td'),
  tableFoot('tfoot'),
  tableHead('thead'),
  tableHeaderCell('th'),
  tableRow('tr'),
  textArea('textarea'),
  unOrderedList('ul'),
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
