import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

@internal
bool fnIsKeyValueMapEqual(
  Map<String, String>? mapOne,
  Map<String, String>? mapTwo,
) {
  // 1. if same instance(or both are null)
  if (mapOne == mapTwo) return true;

  // 2. if one of them is null, this mean other is not
  if (null == mapOne || null == mapTwo) return false;

  // 3. if lengths are different
  if (mapOne.length != mapTwo.length) return false;

  // 4. walk
  for (final key in mapOne.keys) {
    if (mapOne[key] != mapTwo[key]) return false;
  }

  return true;
}

@internal
class DomNodePatchFillable implements DomNodePatch {
  /// Attributes patch.
  ///
  @override
  final Map<String, String?> attributes;

  /// Properties patch.
  ///
  @override
  final Map<String, String?> properties;

  const DomNodePatchFillable({
    required this.attributes,
    required this.properties,
  });
}

/// Element properties.
///
@internal
class Properties {
  static const value = 'value';
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
