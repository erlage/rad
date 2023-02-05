// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import { SyntaxToken, SyntaxTokenType } from "./syntax_token";

export class Lexer {
    private inputText: string;
    private inputLength: number;

    private currentPosition: number;

    constructor(
        inputText: string,
    ) {
        this.inputText = inputText;
        this.inputLength = inputText.length;

        this.currentPosition = 0;
    }

    public lexCurrentToken(): SyntaxToken {
        let currentCharacter = this.currentCharacter();

        /*
            src comments
        */

        if ('/' === currentCharacter) {
            if ('/' === this.lookAheadCharacter(1)) {
                return this.lexSingleLineCommentLiteral();
            }

            if ('*' === this.lookAheadCharacter(1)) {
                return this.lexMultiLineCommentBlock();
            }
        }

        /*
            raw strings
        */

        if ("r" === currentCharacter) {
            switch (this.lookAheadCharacter(1)) {
                case '"':
                case "'":
                    // eat r
                    this.seekCurrentPosition(1);

                    // lex remaining string literal
                    return this.lexStringLiteralToken();
            }
        }

        /*
            identifiers
        */

        if (currentCharacter.match(/[a-zA-Z_]/)) {
            return this.lexIdentifierLiteralToken();
        }

        /*
            rest
        */

        switch (currentCharacter) {
            case '\0':
                return new SyntaxToken(SyntaxTokenType.endOfInputCharacter, this.currentPosition, 1, "\0");

            case '\n':
            case '\t':
                this.seekCurrentPosition(1);
                return this.lexCurrentToken();

            case ' ':
                return this.lexWhiteSpaceLiteralToken();

            case "'":
            case '"':
                return this.lexStringLiteralToken();

            case ',':
                return new SyntaxToken(SyntaxTokenType.commaCharacter, this.seekCurrentPosition(1), 1, ",");

            case '(':
                return new SyntaxToken(SyntaxTokenType.openParenthesisCharacter, this.seekCurrentPosition(1), 1, "(");

            case ')':
                return new SyntaxToken(SyntaxTokenType.closeParenthesisCharacter, this.seekCurrentPosition(1), 1, ")");

            case '[':
                return new SyntaxToken(SyntaxTokenType.openBracketCharacter, this.seekCurrentPosition(1), 1, "[");

            case ']':
                return new SyntaxToken(SyntaxTokenType.closeBracketCharacter, this.seekCurrentPosition(1), 1, "]");

            case '{':
                return new SyntaxToken(SyntaxTokenType.openBraceCharacter, this.seekCurrentPosition(1), 1, ";");

            case '}':
                return new SyntaxToken(SyntaxTokenType.closeBraceCharacter, this.seekCurrentPosition(1), 1, ";");

            case ':':
                return new SyntaxToken(SyntaxTokenType.doubleColonCharacter, this.seekCurrentPosition(1), 1, ":");

            case ';':
                return new SyntaxToken(SyntaxTokenType.semiColonCharacter, this.seekCurrentPosition(1), 1, ";");

            case '~':
            case '.':
            case '+':
            case '-':
            case '*':
            case '/':
            case '%':
            case '=':
            case '!':
            case '@':
            case '&':
            case '|':
            case '>':
            case '<':
                let character = this.currentCharacter();
                return new SyntaxToken(SyntaxTokenType.otherCharacter, this.seekCurrentPosition(1), 1, `<other character: ${character}>`);

            default:
                return new SyntaxToken(SyntaxTokenType.unknownCharacter, this.seekCurrentPosition(1), 1, `<unknown character: ${currentCharacter}>`);
        }
    }

    private currentCharacter(): string {
        if (this.currentPosition >= this.inputLength) {
            return '\0';
        }

        return this.inputText[this.currentPosition];
    }

    private seekCurrentPosition(steps: number): number {
        let start = this.currentPosition;
        this.currentPosition += steps;

        if (this.currentPosition > this.inputLength) {
            throw Error("Lexer has exceeded the bounds of the input string.");
        }

        return start;
    }

    private lookAheadCharacter(offset: number): string {
        let index = this.currentPosition + offset;

        if (index >= this.inputLength) {
            return '\0';
        }

        return this.inputText[index];
    }

    private lexIdentifierLiteralToken(): SyntaxToken {
        let start = this.currentPosition;
        do {
            this.seekCurrentPosition(1);
        } while (this.currentCharacter().match(/[a-zA-Z0-9_.]/));

        let text = this.inputText.substring(start, this.currentPosition);
        return new SyntaxToken(SyntaxTokenType.identifierLiteral, start, text.length, text);
    }

    private lexWhiteSpaceLiteralToken(): SyntaxToken {
        let start = this.currentPosition;

        while (' ' === this.currentCharacter()) {
            this.seekCurrentPosition(1);
        }

        let text = this.inputText.substring(start, this.currentPosition);
        return new SyntaxToken(SyntaxTokenType.whiteSpaceLiteral, start, text.length, text);
    }

    private lexSingleLineCommentLiteral(): SyntaxToken {
        let start = this.currentPosition;

        let currentCharacter = '';
        while (true) {
            currentCharacter = this.currentCharacter();
            if ('\0' === currentCharacter) {
                break;
            }

            this.seekCurrentPosition(1);

            if ('\n' === currentCharacter) {
                break;
            }
        }

        let text = this.inputText.substring(start, this.currentPosition);
        return new SyntaxToken(SyntaxTokenType.singleLineCommentLiteral, start, text.length, text);
    }

    private lexMultiLineCommentBlock(): SyntaxToken {
        let start = this.currentPosition;

        let currentCharacter = '';
        while (true) {
            currentCharacter = this.currentCharacter();
            if ('\0' === currentCharacter) {
                break;
            }

            if ('*' === currentCharacter && '/' === this.lookAheadCharacter(1)) {
                this.seekCurrentPosition(2);
                break;
            }

            this.seekCurrentPosition(1);
        }

        let text = this.inputText.substring(start, this.currentPosition);
        return new SyntaxToken(SyntaxTokenType.multiLineCommentBlock, start, text.length, text);
    }

    private lexStringLiteralToken(): SyntaxToken {
        let currentCharacter = this.currentCharacter();
        let secondCharacter = this.lookAheadCharacter(1);
        let thirdCharacter = this.lookAheadCharacter(2);

        if ("'" === currentCharacter) {
            if ("'" === secondCharacter && "'" === thirdCharacter) {
                return this.lexMultiQuotedStringLiteral("'");
            } else {
                return this.lexQuotedStringLiteral("'");
            }
        }

        if ('"' === currentCharacter) {
            if ('"' === secondCharacter && '"' === thirdCharacter) {
                return this.lexMultiQuotedStringLiteral('"');
            } else {
                return this.lexQuotedStringLiteral('"');
            }
        }

        throw Error("lexStringLiteral called without looking ahead.");
    }

    private lexQuotedStringLiteral(stringDelimiterCharacter: string): SyntaxToken {
        let start = this.seekCurrentPosition(1); // eat quote at start

        while (stringDelimiterCharacter !== this.currentCharacter()) {
            if ('\0' === this.currentCharacter()) {
                // string not well formed, drop it
                return new SyntaxToken(SyntaxTokenType.endOfInputCharacter, start, 1, '\0');
            }

            // escape sequence
            if ('\\' === this.currentCharacter()) {
                if ('\0' !== this.lookAheadCharacter(1)) {
                    this.seekCurrentPosition(2);
                    continue;
                }
            }

            this.seekCurrentPosition(1);
        }

        this.seekCurrentPosition(1); // eat quote at stop

        let text = this.inputText.substring(start, this.currentPosition);
        return new SyntaxToken(SyntaxTokenType.stringLiteral, start, text.length, text);
    }

    private lexMultiQuotedStringLiteral(stringDelimiterCharacter: string): SyntaxToken {
        let quoteCount: number = 0;
        let start = this.currentPosition;

        while (stringDelimiterCharacter === this.currentCharacter()) {
            this.seekCurrentPosition(1);
            quoteCount++;
        }

        while (quoteCount > 0) {
            if ('\0' === this.currentCharacter()) {
                return new SyntaxToken(SyntaxTokenType.endOfInputCharacter, start, 1, '\0');
            }

            if ('\\' === this.currentCharacter()) {
                if ('\0' !== this.lookAheadCharacter(1)) {
                    this.seekCurrentPosition(2);
                    continue;
                }
            }

            if (stringDelimiterCharacter === this.currentCharacter()) {
                quoteCount--;
            }

            this.seekCurrentPosition(1);
        }

        let text = this.inputText.substring(start, this.currentPosition);
        return new SyntaxToken(SyntaxTokenType.stringLiteral, start, text.length, text);
    }
}
