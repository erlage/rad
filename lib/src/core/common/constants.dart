import 'package:rad/src/core/common/objects/key.dart';

/// Class containing framework specific attributes and constants.
///
class Constants {
  // widget attributes

  static const attrWidgetType = 'rad-wtype';

  static const allAttributes = [
    attrWidgetType,
  ];

  // context specific

  static const contextTypeBigBang = 'BigBang';
  static const contextGenKeyPrefix = '_gen_';
  static const contextKeyNotSet = Key('_not_set_');

  // errors

  static const coreError = 'Framework has gone wild.';
  static const routerError = 'Router has gone wild.';

  // css classes

  static const classHidden = 'rad-hidden';

  // list view related

  static const classListViewContained = 'rad-list-view-layout-contained';
  static const classListViewExpanded = 'rad-list-view-layout-expanded';
  static const classListViewVeritcal = 'rad-list-view-vertical';
  static const classListViewHorizontal = 'rad-list-view-horizontal';
  static const classListViewItemContainer = 'rad-list-view-item-container';
}

/// Element attributes.
///
class Attributes {
  // global

  static const id = 'id';
  static const title = 'title';
  static const style = 'style';
  static const hidden = 'hidden';
  static const tabIndex = 'tabindex';
  static const draggable = 'draggable';
  static const contentEditable = 'contenteditable';
  static const onClick = 'onclick';

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
  static const readOnly = 'selected';

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
  static const minLength = 'minlenth';
  static const maxLength = 'maxlength';

  // iframe

  static const allow = 'allow';
  static const allowFullscreen = 'allowfullscreen';
  static const allowPaymentRequest = 'allowpaymentrequest';

  // misc

  static const max = 'max';
  static const label = 'label';
  static const selected = 'selected';
  static const forAttribute = 'for';
  static const pattern = 'pattern';
  static const src = 'src';
  static const alt = 'alt';
  static const height = 'height';
  static const width = 'width';
}
