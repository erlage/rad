// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';
import { Common } from './decorations';

export namespace CallWithoutChildWidgets {
    const optionalCallEndingCommaSingleLine = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        after: {
            contentText: '>',
            color: "#383A42",
        },
        dark: {
            after: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.ClosedOpen,
    });
    export function getForOptionalCallEndingCommaSingleLine(_: string): vscode.TextEditorDecorationType {
        return optionalCallEndingCommaSingleLine;
    }
    export function getForOptionalCallEndingCommaMultiLine(_: string): vscode.TextEditorDecorationType {
        return optionalCallEndingCommaSingleLine;
    }

    const optionalCallEndingSemiColonSingleLine = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        after: {
            contentText: '>',
            color: "#383A42",
        },
        dark: {
            after: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.ClosedOpen,
    });
    export function getForOptionalEndingSemiColonSingleLine(_: string): vscode.TextEditorDecorationType {
        return optionalCallEndingSemiColonSingleLine;
    }
    export function getForOptionalCallSemiColonMultiLine(_: string): vscode.TextEditorDecorationType {
        return optionalCallEndingSemiColonSingleLine;
    }

    const optionalAttributeEndingComma = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        after: {
            contentText: '>',
            color: "#383A42",
        },
        dark: {
            after: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.ClosedOpen,
    });
    export function getForOptionalAttributeEndingComma(_: string): vscode.TextEditorDecorationType {
        return optionalAttributeEndingComma;
    }

    const callCloseParenthesisMapSingleLine: Map<string, vscode.TextEditorDecorationType> = new Map();
    export function getForCallCloseParenthesisSingleLine(tagName: string): vscode.TextEditorDecorationType {
        if (!callCloseParenthesisMapSingleLine.has(tagName)) {
            callCloseParenthesisMapSingleLine.set(tagName, vscode.window.createTextEditorDecorationType({
                color: '#00000010',
                before: {
                    contentText: '> </',
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
                rangeBehavior: vscode.DecorationRangeBehavior.ClosedClosed,
            }));
        }

        return callCloseParenthesisMapSingleLine.get(tagName)!;
    }

    const callCloseParenthesisMapMultiLine: Map<string, vscode.TextEditorDecorationType> = new Map();
    export function getForCallCloseParenthesisMultiLine(tagName: string): vscode.TextEditorDecorationType {
        if (!callCloseParenthesisMapMultiLine.has(tagName)) {
            callCloseParenthesisMapMultiLine.set(tagName, vscode.window.createTextEditorDecorationType({
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

        return callCloseParenthesisMapMultiLine.get(tagName)!;
    }
}

export namespace CallWithNamedChildrenAttribute {

    export function getForOptionalCommaAfterNull(_: string): vscode.TextEditorDecorationType {
        return Common.decorationFadeText;
    }

    export function getForOptionalCallEndingComma(_: string): vscode.TextEditorDecorationType {
        return CallWithoutChildWidgets.getForOptionalCallEndingCommaMultiLine(_);
    }

    export function getForOptionalCallEndingSemiColon(_: string): vscode.TextEditorDecorationType {
        return CallWithoutChildWidgets.getForOptionalEndingSemiColonSingleLine(_);
    }

    const childrenAttributeNameAndOpenBracket = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        after: {
            contentText: '>',
            color: "#383A42",
        },
        dark: {
            after: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.ClosedOpen,
    });
    export function getForChildrenAttributeNameAndOpenBracket(_: string): vscode.TextEditorDecorationType {
        return childrenAttributeNameAndOpenBracket;
    }

    const callCloseParenthesisMap: Map<string, vscode.TextEditorDecorationType> = new Map();
    export function getForCallCloseParenthesis(tagName: string): vscode.TextEditorDecorationType {
        if (!callCloseParenthesisMap.has(tagName)) {
            callCloseParenthesisMap.set(tagName, vscode.window.createTextEditorDecorationType({
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


        return callCloseParenthesisMap.get(tagName)!;
    }

    const childrenAttributeCloseBracketMap: Map<string, vscode.TextEditorDecorationType> = new Map();
    export function getForChildrenAttributeCloseBracket(tagName: string): vscode.TextEditorDecorationType {
        if (!childrenAttributeCloseBracketMap.has(tagName)) {
            childrenAttributeCloseBracketMap.set(tagName, vscode.window.createTextEditorDecorationType({
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

        return childrenAttributeCloseBracketMap.get(tagName)!;
    }

    const callCloseParenthesisNonNull = vscode.window.createTextEditorDecorationType({
        color: '#00000010',
        after: {
            contentText: '>',
            color: "#383A42",
        },
        dark: {
            after: {
                color: '#ABB2BF',
            },
        },
        rangeBehavior: vscode.DecorationRangeBehavior.ClosedOpen,
    });
    export function getForCallCloseParenthesisNonNull(_: string): vscode.TextEditorDecorationType {
        return callCloseParenthesisNonNull;
    }

    export function getForCallOptionalCommaNonNull(_: string): vscode.TextEditorDecorationType {
        return Common.decorationFadeText;
    }

    export function getForCallOptionalSemiColonNonNull(_: string): vscode.TextEditorDecorationType {
        return Common.decorationFadeText;
    }
}
