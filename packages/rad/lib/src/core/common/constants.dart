// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

/// Whether to include development utilities inside build.
///
// ignore: constant_identifier_names
const DEBUG_BUILD = bool.fromEnvironment(
  'include.debug.utils',
  defaultValue: true,
);

/// Class containing framework specific attributes and constants.
///
@internal
class Constants {
  /// Widget's type for root element.
  ///
  static const contextTypeBigBang = 'BigBang';

  // --------------------------------------------------------------------------
  // css classes
  // --------------------------------------------------------------------------

  static const classHidden = 'rad-hidden';

  // widgets related

  static const classRadApp = 'rad-app';
  static const classRoute = 'rad-route';
  static const classNavigator = 'rad-navigator';
  static const classGestureDetector = 'rad-gesture-detector';

  // list view related

  static const classListView = 'rad-list-view';
  static const classListViewContained = 'rad-list-view-layout-contained';
  static const classListViewExpanded = 'rad-list-view-layout-expanded';
  static const classListViewVeritcal = 'rad-list-view-vertical';
  static const classListViewHorizontal = 'rad-list-view-horizontal';
  static const classListViewItemContainer = 'rad-list-view-item-container';
}

/// Element attributes.
///
@internal
class Attributes {
  // global

  static const id = 'id';
  static const title = 'title';
  static const style = 'style';
  static const className = 'class';
  static const dir = 'dir';
  static const hidden = 'hidden';
  static const tabIndex = 'tabindex';
  static const draggable = 'draggable';
  static const contentEditable = 'contentEditable';

  // input

  static const type = 'type';
  static const name = 'name';
  static const value = 'value';
  static const accept = 'accept';
  static const multiple = 'multiple';
  static const disabled = 'disabled';
  static const required = 'required';
  static const checked = 'checked';
  static const placeholder = 'placeholder';
  static const readOnly = 'readonly';

  // table

  static const rowSpan = 'rowspan';
  static const colSpan = 'colspan';
  static const headers = 'headers';
  static const span = 'span';

  // anchor

  static const rel = 'rel';
  static const target = 'target';
  static const href = 'href';
  static const download = 'download';

  // blockquote

  static const cite = 'cite';

  // form

  static const action = 'action';
  static const method = 'method';
  static const enctype = 'enctype';

  // textarea

  static const rows = 'rows';
  static const cols = 'cols';
  static const minLength = 'minlength';
  static const maxLength = 'maxlength';

  // iframe

  static const allow = 'allow';
  static const allowFullscreen = 'allowfullscreen';
  static const allowPaymentRequest = 'allowpaymentrequest';

  // mixed

  static const label = 'label';
  static const selected = 'selected';
  static const forAttribute = 'for';
  static const pattern = 'pattern';
  static const src = 'src';
  static const srcDoc = 'srcdoc';
  static const alt = 'alt';
  static const height = 'height';
  static const width = 'width';
  static const start = 'start';
  static const reversed = 'reversed';
  static const dateTime = 'datetime';
  static const coords = 'coords';
  static const hrefLang = 'hreflang';
  static const ping = 'ping';
  static const referrerPolicy = 'referrerpolicy';
  static const shape = 'shape';
  static const autoPlay = 'autoplay';
  static const controls = 'controls';
  static const crossOrigin = 'crossorigin';
  static const loop = 'loop';
  static const muted = 'muted';
  static const preload = 'preload';
  static const defaultAttribute = 'default';
  static const kind = 'kind';
  static const srcLang = 'srclang';
  static const playsInline = 'playsinline';
  static const poster = 'poster';
  static const srcSet = 'srcset';
  static const sizes = 'sizes';
  static const media = 'media';
  static const open = 'open';
  static const form = 'form';
  static const formAction = 'formaction';
  static const formEncType = 'formenctype';
  static const formMethod = 'formmethod';
  static const formTarget = 'formtarget';
  static const formNoValidate = 'formnovalidate';
  static const noValidate = 'novalidate';
  static const acceptCharset = 'accept-charset';
  static const autoComplete = 'autocomplete';
  static const fetchPriority = 'fetchpriority';
  static const decoding = 'decoding';
  static const loading = 'loading';
  static const capture = 'capture';
  static const dirName = 'dirname';
  static const inputMode = 'inputmode';
  static const list = 'list';
  static const size = 'size';
  static const step = 'step';
  static const wrap = 'wrap';
  static const spellCheck = 'spellcheck';
  static const abbr = 'abbr';
  static const scope = 'scope';

  static const max = 'max';
  static const min = 'min';
  static const high = 'high';
  static const low = 'low';
  static const optimum = 'optimum';

  // meta

  static const content = 'content';
  static const charset = 'charset';
  static const httpEquiv = 'http-equiv';
}

/// Element properties.
///
@internal
class Properties {
  static const value = 'value';

  static const innerText = 'innerText';
  static const innerHtml = 'innerHtml';
}
