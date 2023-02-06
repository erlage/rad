export enum AttributeValueType {

    // for primitive types

    _intType = '__int',
    _boolType = '__bool',
    _stringType = '__string',

    // enum types

    enumDirectionType = 'DirectionType',
    enumWrapType = 'WrapType',
    enumSpellCheckType = 'SpellCheckType',
    enumScopeType = 'ScopeType',
    enumInputType = 'InputType',
    enumFormEncType = 'FormEncType',
    enumFormMethodType = 'FormMethodType',
    enumButtonType = 'ButtonType',
    enumListType = 'ListType',
    enumCrossOriginType = 'CrossOriginType',
    enumDecodingType = 'DecodingType',
    enumLoadingType = 'LoadingType',
    enumPreloadType = 'PreloadType',
    enumFetchPriorityType = 'FetchPriorityType',
    enumKindType = 'KindType',
    enumReferrerPolicyType = 'ReferrerPolicyType',
}

export const attributeValueTypeEnumMappings = new Map<string, Map<string, string>>([

    ['__int', new Map([])],
    ['__bool', new Map([])],
    ['__string', new Map([])],

    [
        'DirectionType', new Map([
            ['ltr', 'leftToRight'],
            ['rtl', 'rightToLeft'],
            ['auto', 'auto'],
        ])
    ],
    [
        'WrapType', new Map([
            ['hard', 'hard'],
            ['soft', 'soft'],
            ['off', 'off'],
        ])
    ],
    [
        'SpellCheckType', new Map([
            ['true', 'trueValue'],
            ['false', 'falseValue'],
            ['default', 'defaultValue'],
        ])
    ],
    [
        'ScopeType', new Map([
            ['row', 'row'],
            ['col', 'column'],
            ['rowgroup', 'rowGroup'],
            ['colgroup', 'columnGroup'],
        ])
    ],
    [
        'InputType', new Map([
            ['button', 'button'],
            ['checkbox', 'checkbox'],
            ['color', 'color'],
            ['date', 'date'],
            ['datetime-local', 'dateTimeLocal'],
            ['email', 'email'],
            ['file', 'file'],
            ['hidden', 'hidden'],
            ['image', 'image'],
            ['month', 'month'],
            ['number', 'number'],
            ['password', 'password'],
            ['radio', 'radio'],
            ['range', 'range'],
            ['reset', 'reset'],
            ['search', 'search'],
            ['submit', 'submit'],
            ['tel', 'telephone'],
            ['text', 'text'],
            ['time', 'time'],
            ['url', 'url'],
            ['week', 'week'],
        ])
    ],
    [
        'FormEncType', new Map([
            ['application/x-www-form-urlencoded', 'applicationXwwwFormUrlEncoded'],
            ['multipart/form-data', 'multipartFormData'],
            ['text/plain', 'textPlain'],
        ])
    ],
    [
        'FormMethodType', new Map([
            ['post', 'post'],
            ['get', 'get'],
        ])
    ],
    [
        'ButtonType', new Map([
            ['button', 'button'],
            ['submit', 'submit'],
            ['reset', 'reset'],
        ])
    ],
    [
        'ListType', new Map([
            ['a', 'lowerCaseLetters'],
            ['A', 'upperCaseLetters'],
            ['i', 'lowerCaseRomanNumerals'],
            ['I', 'upperCaseRomanNumerals'],
            ['1', 'numbers'],
        ])
    ],
    [
        'CrossOriginType', new Map([
            ['anonymous', 'anonymous'],
            ['use-credentials', 'useCredentials'],
        ])
    ],
    [
        'DecodingType', new Map([
            ['sync', 'sync'],
            ['async', 'async'],
            ['auto', 'auto'],
        ])
    ],
    [
        'LoadingType', new Map([
            ['eager', 'eager'],
            ['lazy', 'lazy'],
        ])
    ],
    [
        'PreloadType', new Map([
            ['none', 'none'],
            ['metadata', 'metaData'],
            ['auto', 'auto'],
            ['', 'empty'],
        ])
    ],
    [
        'FetchPriorityType', new Map([
            ['high', 'high'],
            ['low', 'low'],
            ['auto', 'auto'],
        ])
    ],
    [
        'KindType', new Map([
            ['subtitles', 'subtitles'],
            ['captions', 'captions'],
            ['descriptions', 'descriptions'],
            ['chapters', 'chapters'],
            ['metadata', 'metaData'],
        ])
    ],
    [
        'ReferrerPolicyType', new Map([
            ['no-referrer', 'noReferrer'],
            ['no-referrer-when-downgrade', 'noReferrerWhenDowngrade'],
            ['origin', 'origin'],
            ['origin-when-cross-origin', 'originWhenCrossOrigin'],
            ['same-origin', 'sameOrigin'],
            ['strict-origin', 'strictOrigin'],
            ['strict-origin-when-cross-origin', 'strictOriginWhenCrossOrigin'],
            ['unsafe-url', 'unSafeUrl'],
        ])
    ],
]);