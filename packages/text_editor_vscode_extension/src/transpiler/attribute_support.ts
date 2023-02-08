import { AttributeValueType } from "./attribute_value_types";

export const constSupportedGlobalAttributes = new Map([
    ['id', AttributeValueType._stringType],
    ['className', AttributeValueType._stringType],
    ['hidden', AttributeValueType._boolType],
    ['style', AttributeValueType._stringType],
    ['title', AttributeValueType._stringType],
]);

export const constSupportedAttributeForTagsMappings = new Map([
    [
        'Anchor', new Map([
            ['href', AttributeValueType._stringType],
            ['hrefLang', AttributeValueType._stringType],
            ['ping', AttributeValueType._stringType],
            ['referrerPolicy', AttributeValueType.enumReferrerPolicyType],
            ['rel', AttributeValueType._stringType],
            ['target', AttributeValueType._stringType],
            ['download', AttributeValueType._stringType],
            ['type', AttributeValueType._stringType],
        ])
    ],
    [
        'Audio', new Map([
            ['autoPlay', AttributeValueType._boolType],
            ['controls', AttributeValueType._boolType],
            ['crossOrigin', AttributeValueType.enumCrossOriginType],
            ['loop', AttributeValueType._boolType],
            ['muted', AttributeValueType._boolType],
            ['preload', AttributeValueType.enumPreloadType],
            ['src', AttributeValueType._stringType],
        ])
    ],
    [
        'BidirectionalIsolate', new Map([
            ['dir', AttributeValueType.enumDirectionType],
        ])
    ],
    [
        'BidirectionalTextOverride', new Map([
            ['dir', AttributeValueType.enumDirectionType],
        ])
    ],
    [
        'BlockQuote', new Map([
            ['cite', AttributeValueType._stringType],
        ])
    ],
    [
        'Button', new Map([
            ['name', AttributeValueType._stringType],
            ['value', AttributeValueType._stringType],
            ['type', AttributeValueType.enumButtonType],
            ['disabled', AttributeValueType._boolType],
            ['form', AttributeValueType._stringType],
            ['formAction', AttributeValueType._stringType],
            ['formEncType', AttributeValueType.enumFormEncType],
            ['formMethod', AttributeValueType.enumFormMethodType],
            ['formTarget', AttributeValueType._stringType],
            ['formNoValidate', AttributeValueType._boolType],
        ])
    ],
    [
        'Canvas', new Map([
            ['height', AttributeValueType._stringType],
            ['width', AttributeValueType._stringType],
        ])
    ],
    [
        'Data', new Map([
            ['value', AttributeValueType._stringType],
        ])
    ],
    [
        'DeletedText', new Map([
            ['cite', AttributeValueType._stringType],
            ['dateTime', AttributeValueType._stringType],
        ])
    ],
    [
        'Details', new Map([
            ['open', AttributeValueType._boolType],
        ])
    ],
    [
        'EmbedExternal', new Map([
            ['width', AttributeValueType._stringType],
            ['src', AttributeValueType._stringType],
            ['type', AttributeValueType._stringType],
            ['height', AttributeValueType._stringType],
        ])
    ],
    [
        'EmbedTextTrack', new Map([
            ['defaultAttribute', AttributeValueType._boolType],
            ['kind', AttributeValueType.enumKindType],
            ['label', AttributeValueType._stringType],
            ['src', AttributeValueType._stringType],
            ['srcLang', AttributeValueType._stringType],
        ])
    ],
    [
        'FieldSet', new Map([
            ['name', AttributeValueType._stringType],
            ['form', AttributeValueType._stringType],
            ['disabled', AttributeValueType._boolType],
        ])
    ],
    [
        'Form', new Map([
            ['name', AttributeValueType._stringType],
            ['acceptCharset', AttributeValueType._stringType],
            ['autoComplete', AttributeValueType._stringType],
            ['rel', AttributeValueType._stringType],
            ['action', AttributeValueType._stringType],
            ['enctype', AttributeValueType.enumFormEncType],
            ['method', AttributeValueType.enumFormMethodType],
            ['noValidate', AttributeValueType._boolType],
            ['target', AttributeValueType._stringType],
        ])
    ],
    [
        'IFrame', new Map([
            ['src', AttributeValueType._stringType],
            ['srcDoc', AttributeValueType._stringType],
            ['name', AttributeValueType._stringType],
            ['allow', AttributeValueType._stringType],
            ['allowfullscreen', AttributeValueType._boolType],
            ['allowpaymentrequest', AttributeValueType._boolType],
            ['width', AttributeValueType._stringType],
            ['height', AttributeValueType._stringType],
            ['fetchPriority', AttributeValueType.enumFetchPriorityType],
            ['referrerPolicy', AttributeValueType.enumReferrerPolicyType],
        ])
    ],
    [
        'Image', new Map([
            ['alt', AttributeValueType._stringType],
            ['crossOrigin', AttributeValueType.enumCrossOriginType],
            ['decoding', AttributeValueType.enumDecodingType],
            ['fetchPriority', AttributeValueType.enumFetchPriorityType],
            ['loading', AttributeValueType.enumLoadingType],
            ['referrerPolicy', AttributeValueType.enumReferrerPolicyType],
            ['src', AttributeValueType._stringType],
            ['srcSet', AttributeValueType._stringType],
            ['width', AttributeValueType._stringType],
            ['height', AttributeValueType._stringType],
        ])
    ],
    [
        'ImageMap', new Map([
            ['name', AttributeValueType._stringType],
        ])
    ],
    [
        'ImageMapArea', new Map([
            ['alt', AttributeValueType._stringType],
            ['coords', AttributeValueType._stringType],
            ['href', AttributeValueType._stringType],
            ['hrefLang', AttributeValueType._stringType],
            ['ping', AttributeValueType._stringType],
            ['referrerPolicy', AttributeValueType.enumReferrerPolicyType],
            ['rel', AttributeValueType._stringType],
            ['shape', AttributeValueType._stringType],
            ['target', AttributeValueType._stringType],
            ['download', AttributeValueType._stringType],
        ])
    ],
    [
        'InlineQuotation', new Map([
            ['cite', AttributeValueType._stringType],
        ])
    ],
    [
        'Input', new Map([
            ['type', AttributeValueType.enumInputType],

            ['name', AttributeValueType._stringType],
            ['disabled', AttributeValueType._boolType],
            ['form', AttributeValueType._stringType],
            ['inputMode', AttributeValueType._stringType],
            ['tabIndex', AttributeValueType._stringType],
            ['value', AttributeValueType._stringType],
        ])
    ],
    [
        'InsertedText', new Map([
            ['cite', AttributeValueType._stringType],
            ['dateTime', AttributeValueType._stringType],
        ])
    ],
    [
        'Label', new Map([
            ['forAttribute', AttributeValueType._stringType],
        ])
    ],
    [
        'ListItem', new Map([
            ['value', AttributeValueType._intType],
        ])
    ],
    [
        'MediaSource', new Map([
            ['type', AttributeValueType._stringType],
            ['src', AttributeValueType._stringType],
            ['srcSet', AttributeValueType._stringType],
            ['sizes', AttributeValueType._stringType],
            ['media', AttributeValueType._stringType],
            ['height', AttributeValueType._stringType],
            ['width', AttributeValueType._stringType],
        ])
    ],
    [
        'Meter', new Map([
            ['value', AttributeValueType._intType],
            ['max', AttributeValueType._intType],
            ['min', AttributeValueType._intType],
            ['high', AttributeValueType._intType],
            ['low', AttributeValueType._intType],
            ['optimum', AttributeValueType._intType],
        ])
    ],
    [
        'OrderedList', new Map([
            ['start', AttributeValueType._intType],
            ['reversed', AttributeValueType._boolType],
            ['list', AttributeValueType.enumListType],
        ])
    ],
    [
        'Option', new Map([
            ['value', AttributeValueType._stringType],
            ['label', AttributeValueType._stringType],
            ['selected', AttributeValueType._boolType],
            ['disabled', AttributeValueType._boolType],
        ])
    ],
    [
        'OptionGroup', new Map([
            ['label', AttributeValueType._stringType],
            ['disabled', AttributeValueType._boolType],
        ])
    ],
    [
        'Output', new Map([
            ['name', AttributeValueType._stringType],
            ['form', AttributeValueType._stringType],
            ['forAttribute', AttributeValueType._stringType],
        ])
    ],
    [
        'Portal', new Map([
            ['referrerPolicy', AttributeValueType.enumReferrerPolicyType],
            ['src', AttributeValueType._stringType],
        ])
    ],
    [
        'Progress', new Map([
            ['value', AttributeValueType._intType],
            ['max', AttributeValueType._intType],
        ])
    ],
    [
        'Select', new Map([
            ['autoComplete', AttributeValueType._stringType],
            ['name', AttributeValueType._stringType],
            ['form', AttributeValueType._stringType],
            ['size', AttributeValueType._stringType],
            ['multiple', AttributeValueType._boolType],
            ['required', AttributeValueType._boolType],
            ['disabled', AttributeValueType._boolType],
        ])
    ],
    [
        'TableColumnGroup', new Map([
            ['span', AttributeValueType._intType],
        ])
    ],
    [
        'TableColumn', new Map([
            ['span', AttributeValueType._intType],
        ])
    ],
    [
        'TableDataCell', new Map([
            ['rowSpan', AttributeValueType._intType],
            ['colSpan', AttributeValueType._intType],
            ['headers', AttributeValueType._stringType],
        ])
    ],
    [
        'TableHeaderCell', new Map([
            ['abbr', AttributeValueType._stringType],
            ['rowSpan', AttributeValueType._intType],
            ['colSpan', AttributeValueType._intType],
            ['scope', AttributeValueType.enumScopeType],
            ['headers', AttributeValueType._stringType],
        ])
    ],
    [
        'TextArea', new Map([
            ['autoComplete', AttributeValueType._stringType],
            ['name', AttributeValueType._stringType],
            ['form', AttributeValueType._stringType],

            ['value', AttributeValueType._stringType],
            ['placeholder', AttributeValueType._stringType],

            ['rows', AttributeValueType._intType],
            ['cols', AttributeValueType._intType],
            ['minLength', AttributeValueType._intType],
            ['maxLength', AttributeValueType._intType],

            ['required', AttributeValueType._boolType],
            ['readOnly', AttributeValueType._boolType],
            ['disabled', AttributeValueType._boolType],

            ['spellCheck', AttributeValueType.enumSpellCheckType],
            ['wrap', AttributeValueType.enumWrapType],
        ])
    ],
    [
        'Time', new Map([
            ['dateTime', AttributeValueType._stringType],
        ])
    ],
    [
        'Video', new Map([
            ['autoPlay', AttributeValueType._boolType],
            ['controls', AttributeValueType._boolType],
            ['crossOrigin', AttributeValueType.enumCrossOriginType],
            ['height', AttributeValueType._stringType],
            ['loop', AttributeValueType._boolType],
            ['muted', AttributeValueType._boolType],
            ['playsInline', AttributeValueType._boolType],
            ['poster', AttributeValueType._stringType],
            ['preload', AttributeValueType.enumPreloadType],
            ['src', AttributeValueType._stringType],
            ['width', AttributeValueType._stringType],
        ])
    ],
]);
