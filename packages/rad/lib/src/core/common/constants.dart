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

/// Element properties.
///
@internal
class Properties {
  static const value = 'value';

  static const innerText = 'innerText';
  static const innerHtml = 'innerHtml';
}

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
  static const abbr = 'abbr';
  static const accept = 'accept';
  static const acceptCharset = 'accept-charset';
  static const action = 'action';
  static const allow = 'allow';
  static const allowFullscreen = 'allowfullscreen';
  static const allowPaymentRequest = 'allowpaymentrequest';
  static const alt = 'alt';
  static const autoComplete = 'autocomplete';
  static const autoPlay = 'autoplay';
  static const capture = 'capture';
  static const charset = 'charset';
  static const checked = 'checked';
  static const cite = 'cite';
  static const className = 'class';
  static const cols = 'cols';
  static const colSpan = 'colspan';
  static const content = 'content';
  static const contentEditable = 'contentEditable';
  static const controls = 'controls';
  static const coords = 'coords';
  static const crossOrigin = 'crossorigin';
  static const dateTime = 'datetime';
  static const decoding = 'decoding';
  static const defaultAttribute = 'default';
  static const dir = 'dir';
  static const dirName = 'dirname';
  static const disabled = 'disabled';
  static const download = 'download';
  static const draggable = 'draggable';
  static const enctype = 'enctype';
  static const fetchPriority = 'fetchpriority';
  static const forAttribute = 'for';
  static const form = 'form';
  static const formAction = 'formaction';
  static const formEncType = 'formenctype';
  static const formMethod = 'formmethod';
  static const formNoValidate = 'formnovalidate';
  static const formTarget = 'formtarget';
  static const headers = 'headers';
  static const height = 'height';
  static const hidden = 'hidden';
  static const high = 'high';
  static const href = 'href';
  static const hrefLang = 'hreflang';
  static const httpEquiv = 'http-equiv';
  static const id = 'id';
  static const inputMode = 'inputmode';
  static const kind = 'kind';
  static const label = 'label';
  static const list = 'list';
  static const loading = 'loading';
  static const loop = 'loop';
  static const low = 'low';
  static const max = 'max';
  static const maxLength = 'maxlength';
  static const media = 'media';
  static const method = 'method';
  static const min = 'min';
  static const minLength = 'minlength';
  static const multiple = 'multiple';
  static const muted = 'muted';
  static const name = 'name';
  static const noValidate = 'novalidate';
  static const open = 'open';
  static const optimum = 'optimum';
  static const pattern = 'pattern';
  static const ping = 'ping';
  static const placeholder = 'placeholder';
  static const playsInline = 'playsinline';
  static const poster = 'poster';
  static const preload = 'preload';
  static const readOnly = 'readonly';
  static const referrerPolicy = 'referrerpolicy';
  static const rel = 'rel';
  static const required = 'required';
  static const reversed = 'reversed';
  static const rows = 'rows';
  static const rowSpan = 'rowspan';
  static const scope = 'scope';
  static const selected = 'selected';
  static const shape = 'shape';
  static const size = 'size';
  static const sizes = 'sizes';
  static const span = 'span';
  static const spellCheck = 'spellcheck';
  static const src = 'src';
  static const srcDoc = 'srcdoc';
  static const srcLang = 'srclang';
  static const srcSet = 'srcset';
  static const start = 'start';
  static const step = 'step';
  static const style = 'style';
  static const tabIndex = 'tabindex';
  static const target = 'target';
  static const title = 'title';
  static const type = 'type';
  static const value = 'value';
  static const width = 'width';
  static const wrap = 'wrap';
}
