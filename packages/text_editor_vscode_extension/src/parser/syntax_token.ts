// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export enum SyntaxTokenType {
    endOfInputCharacter,

    otherCharacter,
    unknownCharacter,

    whiteSpaceLiteral,

    singleLineCommentLiteral,
    multiLineCommentBlock,

    stringLiteral,
    identifierLiteral,

    commaCharacter,

    openParenthesisCharacter, closeParenthesisCharacter,
    openBracketCharacter, closeBracketCharacter,
    openBraceCharacter, closeBraceCharacter,

    doubleColonCharacter, semiColonCharacter,
}

export class SyntaxToken {
    public type: SyntaxTokenType;

    public offset: number;
    public length: number;

    public text: string;

    constructor(
        type: SyntaxTokenType,
        offset: number,
        length: number,
        text: string
    ) {
        this.type = type;
        this.offset = offset;
        this.length = length;
        this.text = text;
    }
}
