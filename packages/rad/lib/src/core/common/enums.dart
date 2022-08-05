// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
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

/// Text render direction.
///
enum DirectionType {
  leftToRight('ltr'),
  rightToLeft('rtl'),
  auto('auto'),
  ;

  final String nativeValue;
  const DirectionType(this.nativeValue);
}

/// Indicates how the control wraps text.
///
enum WrapType {
  /// The browser automatically inserts line breaks (CR+LF) so that each line
  /// has no more than the width of the control; the cols attribute must also
  /// be specified for this to take effect.
  ///
  hard('hard'),

  /// The browser ensures that all line breaks in the value consist of a CR+LF
  /// pair, but does not insert any additional line breaks.
  ///
  soft('soft'),

  /// Non-Standard : Like soft but changes appearance to white-space: pre so
  /// line segments exceeding cols are not wrapped and the textarea becomes
  /// horizontally scrollable.
  ///
  off('off'),
  ;

  final String nativeValue;
  const WrapType(this.nativeValue);
}

/// Specifies whether the <textarea> is subject to spell checking by the
/// underlying browser/OS.
///
enum SpellCheckType {
  /// Indicates that the element needs to have its spelling and grammar checked.
  ///
  trueValue('true'),

  /// Indicates that the element should not be spell checked.
  ///
  falseValue('false'),

  /// Indicates that the element is to act according to a default behavior,
  /// possibly based on the parent element's own spellcheck value.
  ///
  defaultValue('default'),
  ;

  final String nativeValue;
  const SpellCheckType(this.nativeValue);
}

/// This enumerated attribute defines the cells that the header (defined in the
/// TableHeaderCell) element relates to.
///
enum ScopeType {
  /// The header relates to all cells of the row it belongs to.
  ///
  row('row'),

  /// The header relates to all cells of the column it belongs to.
  ///
  column('col'),

  /// The header belongs to a rowgroup and relates to all of its cells.
  ///
  rowGroup('rowgroup'),

  /// The header belongs to a colgroup and relates to all of its cells.
  ///
  columnGroup('colgroup'),
  ;

  final String nativeValue;
  const ScopeType(this.nativeValue);
}

/// HTML Input type.
///
enum InputType {
  button('button'),
  checkbox('checkbox'),
  color('color'),
  date('date'),
  dateTimeLocal('datetime-local'),
  email('email'),
  file('file'),
  hidden('hidden'),
  image('image'),
  month('month'),
  number('number'),
  password('password'),
  radio('radio'),
  range('range'),
  reset('reset'),
  search('search'),
  submit('submit'),
  telephone('tel'),
  text('text'),
  time('time'),
  url('url'),
  week('week'),
  ;

  final String nativeValue;
  const InputType(this.nativeValue);
}

/// HTML form's encoding type.
///
enum FormEncType {
  applicationXwwwFormUrlEncoded('application/x-www-form-urlencoded'),
  multipartFormData('multipart/form-data'),
  textPlain('text/plain'),
  ;

  final String nativeValue;
  const FormEncType(this.nativeValue);
}

/// HTML form's method type.
///
enum FormMethodType {
  post('post'),
  get('get'),
  ;

  final String nativeValue;
  const FormMethodType(this.nativeValue);
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

  final String nativeValue;
  const ButtonType(this.nativeValue);
}

/// Type of ordered list.
///
enum ListType {
  lowerCaseLetters('a'),
  upperCaseLetters('A'),
  lowerCaseRomanNumerals('i'),
  upperCaseRomanNumerals('I'),
  numbers('1'),
  ;

  final String nativeValue;
  const ListType(this.nativeValue);
}

/// Cross origin request type.
///
enum CrossOriginType {
  /// Sends a cross-origin request without a credential. In other words, it
  /// sends the Origin: HTTP header without a cookie, X.509 certificate, or
  /// performing HTTP Basic authentication.
  ///
  anonymous('anonymous'),

  /// Sends a cross-origin request with a credential. In other words, it sends
  /// the Origin: HTTP header with a cookie, a certificate, or performing HTTP
  /// Basic authentication.
  ///
  useCredentials('use-credentials');

  final String nativeValue;
  const CrossOriginType(this.nativeValue);
}

/// Decoding type.
///
enum DecodingType {
  /// Decode the image synchronously, for atomic presentation with other
  /// content.
  ///
  sync('sync'),

  /// Decode the image asynchronously, to reduce delay in presenting other
  /// content.
  ///
  async('async'),

  /// No preference for the decoding mode.
  ///
  auto('auto');

  final String nativeValue;
  const DecodingType(this.nativeValue);
}

enum LoadingType {
  /// Loads the image immediately, regardless of whether or not the image is
  /// currently within the visible viewport.
  ///
  eager('eager'),

  /// Defers loading the image until it reaches a calculated distance from the
  /// viewport.
  ///
  lazy('lazy'),
  ;

  final String nativeValue;
  const LoadingType(this.nativeValue);
}

/// Preload type.
///
enum PreloadType {
  /// Indicates that the audio should not be preloaded.
  ///
  none('none'),

  /// Indicates that only audio metadata (e.g. length) is fetched.
  ///
  metaData('metadata'),

  /// Indicates that the whole audio file can be downloaded, even if the user
  /// is not expected to use it.
  ///
  auto('auto'),

  /// A synonym of the auto value.
  ///
  empty(''),
  ;

  final String nativeValue;
  const PreloadType(this.nativeValue);
}

/// Provides a hint of the relative priority to use when fetching the resource.
///
enum FetchPriorityType {
  /// Signals a high-priority fetch relative to other resources of same type.
  ///
  high('high'),

  /// Signals a low-priority fetch relative to other resources of same type.
  ///
  low('low'),

  /// Signals automatic determination of fetch priority relative to other
  /// resources of same type.
  ///
  auto('auto'),
  ;

  final String nativeValue;
  const FetchPriorityType(this.nativeValue);
}

enum KindType {
  /// Subtitles provide translation of content that cannot be understood by the
  /// viewer. For example speech or text that is not English in an English
  /// language film.
  ///
  subtitles('subtitles'),

  /// Closed captions provide a transcription and possibly a translation of
  /// audio. It may include important non-verbal information such as music cues
  /// or sound effects. It may indicate the cue's source (e.g. music, text,
  /// character). Suitable for users who are deaf or when the sound is muted.
  ///
  captions('captions'),

  /// Textual description of the video content.
  /// Suitable for users who are blind or where the video cannot be seen.
  ///
  descriptions('descriptions'),

  /// Chapter titles are intended to be used when the user is navigating
  /// the media resource.
  ///
  chapters('chapters'),

  /// Tracks used by scripts. Not visible to the user.
  ///
  metaData('metadata'),
  ;

  final String nativeValue;
  const KindType(this.nativeValue);
}

/// The Referrer-Policy HTTP header controls how much referrer information
/// (sent with the Referer header) should be included with requests.
///
enum ReferrerPolicyType {
  /// The Referer header will be omitted: sent requests do not include any
  /// referrer information.
  ///
  noReferrer('no-referrer'),

  /// Send the origin, path, and query-string in Referer when the protocol
  /// security level stays the same or improves (HTTP→HTTP, HTTP→HTTPS,
  /// HTTPS→HTTPS). Don't send the Referer header for requests to less secure
  /// destinations (HTTPS→HTTP, HTTPS→file).
  ///
  noReferrerWhenDowngrade('no-referrer-when-downgrade'),

  /// Send only the origin in the Referer header. For example, a document at
  /// https://example.com/page.html will send the referrer https://example.com/.
  ///
  origin('origin'),

  /// When performing a same-origin request to the same protocol level
  /// (HTTP→HTTP, HTTPS→HTTPS), send the origin, path, and query string.
  ///
  originWhenCrossOrigin('origin-when-cross-origin'),

  /// Send the origin, path, and query string for same-origin requests. Don't
  /// send the Referer header for cross-origin requests.
  ///
  sameOrigin('same-origin'),

  /// Send only the origin when the protocol security level stays the same
  /// (HTTPS→HTTPS). Don't send the Referer header to less secure
  /// destinations (HTTPS→HTTP).
  ///
  strictOrigin('strict-origin'),

  /// Send the origin, path, and query-string when performing a same-origin
  /// request.
  ///
  strictOriginWhenCrossOrigin('strict-origin-when-cross-origin'),

  /// Send the origin, path, and query string when performing any request,
  /// regardless of security.
  ///
  unSafeUrl('unsafe-url');

  final String nativeValue;
  const ReferrerPolicyType(this.nativeValue);
}

/// Type of Render event.
///
enum RenderEventType {
  /// A event that's fired after framework finishes rendering the output
  /// of [RenderElement.render] to the DOM.
  ///
  didRender,

  /// A event that's fired after framework finishes rendering the output
  /// of [RenderElement.update] to the DOM.
  ///
  didUpdate,

  /// A event that's fired when framework is about to remove the widget from
  /// the DOM.
  ///
  willUnMount,

  /// A event that's fired after framework finishes removing the widget from
  /// the DOM.
  ///
  didUnMount,
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

  final String nativeValue;
  const DomEventType(this.nativeValue);
}

/// Widget's corresponding DOM tag.
///
enum DomTagType {
  abbreviation('abbr'),
  address('address'),
  anchor('a'),
  article('article'),
  aside('aside'),
  audio('audio'),
  bidirectionalIsolate('bdi'),
  bidirectionalTextOverride('bdo'),
  blockQuote('blockquote'),
  lineBreak('br'),
  button('button'),
  canvas('canvas'),
  caption('caption'),
  citation('cite'),
  code('code'),
  data('data'),
  dataList('datalist'),
  definition('dfn'),
  deletedText('del'),
  descriptionDetails('dd'),
  descriptionList('dl'),
  descriptionTerm('dt'),
  details('details'),
  dialog('dialog'),
  division('div'),
  embedExternal('embed'),
  embedTextTrack('track'),
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
  imageMap('map'),
  imageMapArea('area'),
  inlineQuotation('q'),
  input('input'),
  insertedText('ins'),
  keyboardInput('kbd'),
  label('label'),
  legend('legend'),
  lineBreakOpportunity('wbr'),
  listItem('li'),
  markText('mark'),
  mediaSource('source'),
  menu('menu'),
  meter('meter'),
  navigation('nav'),
  option('option'),
  optionGroup('optgroup'),
  orderedList('ol'),
  output('output'),
  paragraph('p'),
  picture('picture'),
  portal('portal'),
  preformattedText('pre'),
  progress('progress'),
  rubyAnnotation('ruby'),
  rubyFallbackParenthesis('rp'),
  rubyText('rt'),
  sampleOutput('samp'),
  select('select'),
  small('small'),
  span('span'),
  strikeThrough('s'),
  strong('strong'),
  subScript('sub'),
  summary('summary'),
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
  time('time'),
  unOrderedList('ul'),
  variable('var'),
  video('video'),
  ;

  final String nativeValue;
  const DomTagType(this.nativeValue);
}

/// Type of update event that's happened in parent tree.
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
