// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';
import { config } from '../config';

export namespace Common {
    export const decorationFadeText = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
    });

    const tagName = vscode.window.createTextEditorDecorationType({
        color: '#E45649',
        fontWeight: 'normal',
        before: {
            contentText: '<',
            color: "#383A42",
        },
        dark: {
            color: '#E06C75',
            before: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.OpenClosed,
    });
    export function getForTagName(): vscode.TextEditorDecorationType {
        return tagName;
    }

    const callOpenParenthesis = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
    });
    export function getForCallOpenParenthesis(): vscode.TextEditorDecorationType {
        return callOpenParenthesis;
    }

    const attributeName = vscode.window.createTextEditorDecorationType({
        light: {
            color: "#986801",
        },
        dark: {
            color: "#D19A66",
        },
    });
    export function getForAttributeName(): vscode.TextEditorDecorationType {
        return attributeName;
    }

    const attributeDoubleColon = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        after: {
            contentText: '=',
            color: "#383A42",
        },
        dark: {
            after: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.OpenOpen,
    });
    const attributeDoubleColonPrettyMode = vscode.window.createTextEditorDecorationType({
        color: "#383A42",
        dark: {
            color: '#ABB2BF',
        },
        rangeBehavior: vscode.DecorationRangeBehavior.OpenOpen,
    });
    export function getForAttributeDoubleColon(): vscode.TextEditorDecorationType {
        if (config.jsxEnablePrettyMode) {
            return attributeDoubleColonPrettyMode;
        }

        return attributeDoubleColon;
    }

    const attributeEndingComma = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
    });
    const attributeEndingCommaPrettyMode = vscode.window.createTextEditorDecorationType({
        color: "#383A42",
        dark: {
            color: '#ABB2BF',
        },
    });
    export function getForAttributeEndingComma(): vscode.TextEditorDecorationType {
        if (config.jsxEnablePrettyMode) {
            return attributeEndingCommaPrettyMode;
        }

        return attributeEndingComma;
    }
}

export namespace CallWithPositionalChildrenAttribute {
    const openBracket = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        before: {
            contentText: '>',
            color: "#383A42",
        },
        dark: {
            before: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.ClosedOpen,
    });
    export function getForOpenBracket(_: string): vscode.TextEditorDecorationType {
        return openBracket;
    }

    const closeBracketMap: Map<string, vscode.TextEditorDecorationType> = new Map();
    export function getForCloseBracket(tagName: string): vscode.TextEditorDecorationType {
        if (!closeBracketMap.has(tagName)) {
            closeBracketMap.set(tagName, vscode.window.createTextEditorDecorationType({
                color: '#00000010',
                before: {
                    contentText: '</',
                    color: "#383A42",
                },
                after: {
                    contentText: tagName,
                    color: '#E45649',
                    margin: '-8px',
                },
                dark: {
                    before: {
                        color: '#ABB2BF',
                    },
                    after: {
                        color: '#E06C75',
                    }
                },
                rangeBehavior: vscode.DecorationRangeBehavior.OpenClosed,
            }));
        }

        return closeBracketMap.get(tagName)!;
    }

    export function getForCloseParenthesis(_: string): vscode.TextEditorDecorationType {
        return Common.decorationFadeText;
    }

    const optionalEndingCommaOrEndingSemiColon = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        before: {
            contentText: '>',
            color: "#383A42",
        },
        dark: {
            before: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.ClosedOpen,
    });
    export function getForCallOptionalEndingComma(_: string): vscode.TextEditorDecorationType {
        return optionalEndingCommaOrEndingSemiColon;
    }
    export function getForCallOptionalEndingSemiColon(_: string): vscode.TextEditorDecorationType {
        return optionalEndingCommaOrEndingSemiColon;
    }
}
