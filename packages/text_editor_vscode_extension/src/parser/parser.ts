// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import { Lexer } from "./lexer";
import { config } from "../config";
import { SyntaxToken, SyntaxTokenType } from "./syntax_token";
import { constRadToNativeAttributeNameMappings, constRadToNativeEventNameMappings, constLongTagToShortTagMappings, constShortTagToLongTagMappings } from "../constants";
import { HTMLWidgetCallAttributeExpression, CustomDelimitedExpression, HTMLWidgetCallExpression, Expression, ExpressionType, OtherExpression, HTMLWidgetCallNamedChildrenAttributeExpression, HTMLWidgetCallNamedChildAttributeExpression, HTMLWidgetCallPositionalChildrenAttributeExpression, HTMLWidgetCallChildTreeBaseExpression } from "./expressions";

const constEmptyExpression = new OtherExpression([]);

export class Parser {
    private syntaxTokens: SyntaxToken[];
    private currentPosition: number;

    public extractedHTMLWidgetCallExpressions: HTMLWidgetCallExpression[];

    constructor(
        inputText: string,
    ) {
        this.currentPosition = 0;
        this.extractedHTMLWidgetCallExpressions = [];
        this.syntaxTokens = this.parseSyntaxTokens(inputText);
    }

    public parse(): void {
        while (true) {
            let expression = this.tryParseExpression();
            if (null === expression) {
                break;
            }

            this.extractHTMLWidgetCallExpressions(expression);
        }
    }

    private parseSyntaxTokens(inputText: string): SyntaxToken[] {
        let syntaxTokens = [];
        let lexer = new Lexer(inputText);

        let maxLexerTokens = inputText.length;
        let token: SyntaxToken;
        do {
            token = lexer.lexCurrentToken();

            switch (token.type) {
                case SyntaxTokenType.whiteSpaceLiteral:
                case SyntaxTokenType.singleLineCommentLiteral:
                case SyntaxTokenType.multiLineCommentBlock:
                case SyntaxTokenType.otherCharacter:
                case SyntaxTokenType.unknownCharacter:
                    // not required in parsing.. so we're going to drop them here
                    break;

                default:
                    // ignore const literals as well
                    if (SyntaxTokenType.identifierLiteral === token.type && 'const' === token.text) {
                        break;
                    }

                    syntaxTokens.push(token);
            }

            if (--maxLexerTokens < 0) {
                throw Error('Parser: "lexer is running wild!"');
            }
        } while (token.type !== SyntaxTokenType.endOfInputCharacter);

        return syntaxTokens;
    }

    private currentToken(): SyntaxToken {
        return this.lookAheadToken(0);
    }

    private lookAheadToken(offset: number): SyntaxToken {
        const index = this.currentPosition + offset;

        if (index >= this.syntaxTokens.length) {
            return this.syntaxTokens[this.syntaxTokens.length - 1];
        }

        return this.syntaxTokens[index];
    }

    private seekCurrentPosition(steps: number): number {
        const start = this.currentPosition;
        this.currentPosition += steps;

        if (this.currentPosition > this.syntaxTokens.length) {
            throw Error("The parser is over-iterating during parsing.");
        }

        return start;
    }

    private matchToken(type: SyntaxTokenType): SyntaxToken {
        let currentToken = this.currentToken();

        if (type === currentToken.type) {
            this.seekCurrentPosition(1);
            return currentToken;
        }

        throw Error(`Invalid input text, expecting token of type ${SyntaxTokenType[type]} but found ${SyntaxTokenType[currentToken.type]}`);
    }

    private tryMatchToken(type: SyntaxTokenType): SyntaxToken | null {
        if (type === this.currentToken().type) {
            return this.matchToken(type);
        }

        return null;
    }

    public tryParseExpression(): Expression | null {
        try {
            switch (this.currentToken().type) {
                case SyntaxTokenType.endOfInputCharacter:
                    return null;

                case SyntaxTokenType.openBraceCharacter:
                    return this.parseBraceExpression(); // block expression

                case SyntaxTokenType.openBracketCharacter:
                    return this.parseBracketExpression();

                case SyntaxTokenType.openParenthesisCharacter:
                    return this.parseParenthesisExpression();

                case SyntaxTokenType.identifierLiteral:
                    return this.parseIdentifierExpression();

                case SyntaxTokenType.commaCharacter:
                case SyntaxTokenType.closeParenthesisCharacter:
                case SyntaxTokenType.closeBracketCharacter:
                case SyntaxTokenType.doubleColonCharacter:
                case SyntaxTokenType.semiColonCharacter:
                case SyntaxTokenType.stringLiteral:
                case SyntaxTokenType.otherCharacter:
                case SyntaxTokenType.unknownCharacter:
                    // we don't care about these at top level
                    this.seekCurrentPosition(1);
                    return constEmptyExpression;

                default:
                    if (config.devEnableLogs) {
                        console.log(`Unrecognized token with text: ${this.currentToken().text}`);
                    }

                    this.seekCurrentPosition(1);

                    return this.tryParseExpression();
            }
        }
        catch (e) {
            // parsing one of the above expressions failed(maybe expression isn't well formed)
            if (config.devEnableLogs) {
                console.log(e);
            }

            return constEmptyExpression;
        }
    }

    private parseBraceExpression(): Expression {
        return this.parseCustomDelimitedExpression({
            startTokenType: SyntaxTokenType.openBraceCharacter,
            stopTokenType: SyntaxTokenType.closeBraceCharacter,
        });
    }

    private parseBracketExpression(): Expression {
        return this.parseCustomDelimitedExpression({
            startTokenType: SyntaxTokenType.openBracketCharacter,
            stopTokenType: SyntaxTokenType.closeBracketCharacter,
        });
    }

    private parseParenthesisExpression(): Expression {
        return this.parseCustomDelimitedExpression({
            startTokenType: SyntaxTokenType.openParenthesisCharacter,
            stopTokenType: SyntaxTokenType.closeParenthesisCharacter,
        });
    }

    private parseIdentifierExpression(): Expression {
        let token = this.currentToken();

        if (constShortTagToLongTagMappings.has(token.text) || constLongTagToShortTagMappings.has(token.text)) {
            if (SyntaxTokenType.openParenthesisCharacter === this.lookAheadToken(1).type) {
                // div( span( etc...
                return this.parseHTMLWidgetCallExpression();
            }
        }

        // else eat the identifier
        this.seekCurrentPosition(1);
        return constEmptyExpression;
    }

    private parseHTMLWidgetCallExpression(): Expression {
        let tagNameToken = this.matchToken(SyntaxTokenType.identifierLiteral);
        let callOpenParenthesisToken = this.matchToken(SyntaxTokenType.openParenthesisCharacter);

        let optionalCallChildTreeExpression: HTMLWidgetCallChildTreeBaseExpression | null = null;
        let callAttributeExpressions = [];

        while (true) {
            if (null === optionalCallChildTreeExpression) {
                optionalCallChildTreeExpression = this.tryParseHTMLWidgetChildTreeExpression();
            }

            let attributeExpression = this.tryParseHTMLWidgetCallAttributeExpression();
            if (null === attributeExpression) {
                let currentToken = this.currentToken();
                if (SyntaxTokenType.endOfInputCharacter === currentToken.type) {
                    break;
                }

                if (SyntaxTokenType.closeParenthesisCharacter === currentToken.type) {
                    break;
                }

                this.seekCurrentPosition(1);
            } else {
                callAttributeExpressions.push(attributeExpression);
            }
        }

        let callCloseParenthesisToken = this.matchToken(SyntaxTokenType.closeParenthesisCharacter);

        let optionalCallEndingCommaToken = this.tryMatchToken(SyntaxTokenType.commaCharacter);
        let optionalCallEndingSemiColonToken = this.tryMatchToken(SyntaxTokenType.semiColonCharacter);

        return new HTMLWidgetCallExpression({
            tagNameToken: tagNameToken,

            callOpenParenthesisToken: callOpenParenthesisToken,
            callCloseParenthesisToken: callCloseParenthesisToken,

            callAttributeExpressions: callAttributeExpressions,
            optionalCallChildTreeExpression: optionalCallChildTreeExpression,

            optionalCallEndingCommaToken: optionalCallEndingCommaToken,
            optionalCallEndingSemiColonToken: optionalCallEndingSemiColonToken,
        });
    }

    private tryParseHTMLWidgetChildTreeExpression(): HTMLWidgetCallChildTreeBaseExpression | null {
        let currentToken = this.currentToken();

        if (SyntaxTokenType.identifierLiteral === currentToken.type) {
            if ('null' === currentToken.text) {
                return this.parseHTMLWidgetCallPositionalChildrenAttributeExpression();
            }

            if (SyntaxTokenType.doubleColonCharacter === this.lookAheadToken(1).type) {
                if ('children' === currentToken.text) {
                    if ('null' === this.lookAheadToken(2).text || SyntaxTokenType.openBracketCharacter === this.lookAheadToken(2).type) {
                        return this.parseHTMLWidgetCallNamedChildrenAttributeExpression();
                    } else {
                        // children: some-identifier[not-null], do nothing, let it parse as an attribute.
                    }
                }

                if ('child' === currentToken.text) {
                    return this.parseHTMLWidgetCallNamedChildAttributeExpression();
                }
            }
        } else {
            if (SyntaxTokenType.openBracketCharacter === currentToken.type) {
                return this.parseHTMLWidgetCallPositionalChildrenAttributeExpression();
            }
        }

        return null;
    }

    private parseHTMLWidgetCallNamedChildAttributeExpression(): HTMLWidgetCallNamedChildAttributeExpression {
        let childAttributeNameToken = this.matchToken(SyntaxTokenType.identifierLiteral);
        let childAttributeDoubleColonToken = this.matchToken(SyntaxTokenType.doubleColonCharacter);

        let optionalChildAttributeNullValueToken: SyntaxToken | null = null;
        let optionalChildAttributeWidgetValueExpression: Expression | null = null;

        let currentToken = this.currentToken();
        if ('null' === currentToken.text) {
            optionalChildAttributeNullValueToken = this.matchToken(SyntaxTokenType.identifierLiteral);
        } else {
            optionalChildAttributeWidgetValueExpression = this.tryParseExpression();
        }

        let optionalChildAttributeEndingCommaToken = this.tryMatchToken(SyntaxTokenType.commaCharacter);

        return new HTMLWidgetCallNamedChildAttributeExpression({
            childAttributeNameToken: childAttributeNameToken,
            childAttributeDoubleColonToken: childAttributeDoubleColonToken,

            optionalChildAttributeNullValueToken: optionalChildAttributeNullValueToken,
            optionalChildAttributeWidgetValueExpression: optionalChildAttributeWidgetValueExpression,

            optionalChildAttributeEndingCommaToken: optionalChildAttributeEndingCommaToken,
        });
    }

    private parseHTMLWidgetCallNamedChildrenAttributeExpression(): HTMLWidgetCallNamedChildrenAttributeExpression {
        let childrenAttributeNameToken = this.matchToken(SyntaxTokenType.identifierLiteral);
        let childrenAttributeDoubleColonToken = this.matchToken(SyntaxTokenType.doubleColonCharacter);

        let optionalChildrenAttributeNullValueToken: SyntaxToken | null = null;
        let optionalChildrenAttributeListValueExpression: CustomDelimitedExpression | null = null;

        let currentToken = this.currentToken();
        if ('null' === currentToken.text) {
            optionalChildrenAttributeNullValueToken = this.matchToken(SyntaxTokenType.identifierLiteral);
        } else {
            optionalChildrenAttributeListValueExpression = this.parseCustomDelimitedExpression({
                startTokenType: SyntaxTokenType.openBracketCharacter,
                stopTokenType: SyntaxTokenType.closeBracketCharacter,
            });
        }

        let optionalChildrenAttributeEndingCommaToken = this.tryMatchToken(SyntaxTokenType.commaCharacter);

        return new HTMLWidgetCallNamedChildrenAttributeExpression({
            childrenAttributeNameToken: childrenAttributeNameToken,
            childrenAttributeDoubleColonToken: childrenAttributeDoubleColonToken,

            optionalChildrenAttributeNullValueToken: optionalChildrenAttributeNullValueToken,
            optionalChildrenAttributeListValueExpression: optionalChildrenAttributeListValueExpression,

            optionalChildrenAttributeEndingCommaToken: optionalChildrenAttributeEndingCommaToken,
        });
    }

    private parseHTMLWidgetCallPositionalChildrenAttributeExpression(): HTMLWidgetCallPositionalChildrenAttributeExpression {
        let childrenAttributeListValueExpression = this.parseCustomDelimitedExpression({
            startTokenType: SyntaxTokenType.openBracketCharacter,
            stopTokenType: SyntaxTokenType.closeBracketCharacter,
        });

        let optionalChildrenAttributeEndingCommaToken = this.tryMatchToken(SyntaxTokenType.commaCharacter);

        return new HTMLWidgetCallPositionalChildrenAttributeExpression({
            childrenAttributeListValueExpression: childrenAttributeListValueExpression,
            optionalChildrenAttributeEndingCommaToken: optionalChildrenAttributeEndingCommaToken,
        });
    }

    private tryParseHTMLWidgetCallAttributeExpression(): HTMLWidgetCallAttributeExpression | null {
        try {
            let currentToken = this.currentToken();

            // add:config:tryRecognizingArbitraryAttributes
            if (!true) {
                if (!constRadToNativeAttributeNameMappings.has(currentToken.text) && !constRadToNativeEventNameMappings.has(currentToken.text)) {
                    return null;
                }
            }

            if (SyntaxTokenType.doubleColonCharacter !== this.lookAheadToken(1).type) {
                return null;
            }

            let attributeNameToken = this.matchToken(SyntaxTokenType.identifierLiteral);
            let attributeDoubleColonToken = this.matchToken(SyntaxTokenType.doubleColonCharacter);

            let attributeValueExpression = this.tryParseExpression(); // ignore values for now

            let optionalAttributeEndingCommaToken = this.tryMatchToken(SyntaxTokenType.commaCharacter);

            return new HTMLWidgetCallAttributeExpression({
                attributeNameToken: attributeNameToken,
                attributeDoubleColonToken: attributeDoubleColonToken,
                optionalAttributeEndingCommaToken: optionalAttributeEndingCommaToken,
            });
        } catch (e) {
            return null;
        }
    }

    // for tokenized expressions
    private parseCustomDelimitedExpression(o: { startTokenType: SyntaxTokenType, stopTokenType: SyntaxTokenType }): CustomDelimitedExpression {
        let childExpressions = [];

        let startToken = this.matchToken(o.startTokenType);
        do {
            let currentToken = this.currentToken();
            if (SyntaxTokenType.endOfInputCharacter === currentToken.type) {
                break;
            }

            if (o.stopTokenType === currentToken.type) {
                break;
            }

            let expression = this.tryParseExpression();
            if (null === expression) {
                break;
            }

            childExpressions.push(expression);
        }
        while (true);
        let stopToken = this.matchToken(o.stopTokenType);

        return new CustomDelimitedExpression({
            startToken: startToken,
            stopToken: stopToken,
            childExpressions: childExpressions,
        });
    }

    private extractHTMLWidgetCallExpressions(expression: Expression): void {
        if (expression.type === ExpressionType.htmlWidgetCallExpression) {
            this.extractedHTMLWidgetCallExpressions.push(expression as HTMLWidgetCallExpression);
        }

        if (expression.childExpressions.length > 0) {
            for (const childExpression of expression.childExpressions) {
                this.extractHTMLWidgetCallExpressions(childExpression);
            }
        }
    }
}
