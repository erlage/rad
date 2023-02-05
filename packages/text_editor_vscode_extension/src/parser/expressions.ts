// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import { SyntaxToken } from "./syntax_token";

export enum ExpressionType {
    otherExpression,
    customDelimitedExpression,
    htmlWidgetCallExpression,
    htmlWidgetCallAttributeExpression,
    htmlWidgetCallNamedChildAttributeExpression,
    htmlWidgetCallNamedChildrenAttributeExpression,
    htmlWidgetCallPositionalChildrenAttributeExpression,
}

export abstract class Expression {
    public type: ExpressionType;

    public childExpressions: Expression[];

    constructor(type: ExpressionType, childExpressions: Expression[]) {
        this.type = type;

        // it's upto each expression type to build it's own hierarchy.
        // we want only the relevant parts in the tree(that we hope to traverse exactly once)
        this.childExpressions = childExpressions;
    }
}

export class OtherExpression extends Expression {
    constructor(childExpressions: Expression[]) {
        super(ExpressionType.otherExpression, childExpressions);
    }
}

export class CustomDelimitedExpression extends Expression {
    public startToken: SyntaxToken;
    public stopToken: SyntaxToken;

    constructor(data: {
        startToken: SyntaxToken,
        stopToken: SyntaxToken,
        childExpressions: Expression[],
    }) {
        super(ExpressionType.customDelimitedExpression, data.childExpressions);
        this.startToken = data.startToken;
        this.stopToken = data.stopToken;
    }
}

export class HTMLWidgetCallAttributeExpression extends Expression {
    public nameToken: SyntaxToken;
    public doubleColonToken: SyntaxToken;

    public optionalEndingCommaToken: SyntaxToken | null;

    constructor(
        data: {
            attributeNameToken: SyntaxToken,
            attributeDoubleColonToken: SyntaxToken,

            optionalAttributeEndingCommaToken: SyntaxToken | null,
        }
    ) {
        super(ExpressionType.htmlWidgetCallAttributeExpression, []);

        this.nameToken = data.attributeNameToken;
        this.doubleColonToken = data.attributeDoubleColonToken;

        this.optionalEndingCommaToken = data.optionalAttributeEndingCommaToken;
    }
}

export abstract class HTMLWidgetCallChildTreeBaseExpression extends Expression {
    constructor(
        type: ExpressionType,
        childExpression: Expression | null,
    ) {
        if (null !== childExpression) {
            super(type, [childExpression]);
        }
        else {
            super(type, []);
        }
    }
}

export class HTMLWidgetCallNamedChildAttributeExpression extends HTMLWidgetCallChildTreeBaseExpression {
    public nameToken: SyntaxToken;
    public doubleColonToken: SyntaxToken;

    public optionalNullValueToken: SyntaxToken | null;
    public optionalWidgetValueExpression: Expression | null;

    public optionalEndingCommaToken: SyntaxToken | null;

    constructor(
        data: {
            childAttributeNameToken: SyntaxToken,
            childAttributeDoubleColonToken: SyntaxToken,

            optionalChildAttributeNullValueToken: SyntaxToken | null,
            optionalChildAttributeWidgetValueExpression: Expression | null,

            optionalChildAttributeEndingCommaToken: SyntaxToken | null,
        }
    ) {
        if (null !== data.optionalChildAttributeWidgetValueExpression) {
            super(ExpressionType.htmlWidgetCallNamedChildAttributeExpression, data.optionalChildAttributeWidgetValueExpression);
        } else {
            super(ExpressionType.htmlWidgetCallNamedChildAttributeExpression, null);
        }

        this.nameToken = data.childAttributeNameToken;
        this.doubleColonToken = data.childAttributeDoubleColonToken;

        this.optionalNullValueToken = data.optionalChildAttributeNullValueToken;
        this.optionalWidgetValueExpression = data.optionalChildAttributeWidgetValueExpression;

        this.optionalEndingCommaToken = data.optionalChildAttributeEndingCommaToken;
    }
}

export class HTMLWidgetCallPositionalChildrenAttributeExpression extends HTMLWidgetCallChildTreeBaseExpression {
    public listValueExpression: CustomDelimitedExpression;

    public optionalEndingCommaToken: SyntaxToken | null;

    constructor(
        data: {
            childrenAttributeListValueExpression: CustomDelimitedExpression,

            optionalChildrenAttributeEndingCommaToken: SyntaxToken | null,
        }
    ) {
        super(ExpressionType.htmlWidgetCallPositionalChildrenAttributeExpression, data.childrenAttributeListValueExpression);

        this.listValueExpression = data.childrenAttributeListValueExpression;
        this.optionalEndingCommaToken = data.optionalChildrenAttributeEndingCommaToken;
    }
}

export class HTMLWidgetCallNamedChildrenAttributeExpression extends HTMLWidgetCallChildTreeBaseExpression {
    public childrenLiteralToken: SyntaxToken;
    public doubleColonToken: SyntaxToken;

    public optionalNullValueToken: SyntaxToken | null;
    public optionalListValueExpression: CustomDelimitedExpression | null;

    public optionalEndingCommaToken: SyntaxToken | null;

    constructor(
        data: {
            childrenAttributeNameToken: SyntaxToken,
            childrenAttributeDoubleColonToken: SyntaxToken,

            optionalChildrenAttributeNullValueToken: SyntaxToken | null,
            optionalChildrenAttributeListValueExpression: CustomDelimitedExpression | null,

            optionalChildrenAttributeEndingCommaToken: SyntaxToken | null,
        }
    ) {
        if (null !== data.optionalChildrenAttributeListValueExpression) {
            super(ExpressionType.htmlWidgetCallNamedChildrenAttributeExpression, data.optionalChildrenAttributeListValueExpression);
        } else {
            super(ExpressionType.htmlWidgetCallNamedChildrenAttributeExpression, null);
        }

        this.childrenLiteralToken = data.childrenAttributeNameToken;
        this.doubleColonToken = data.childrenAttributeDoubleColonToken;

        this.optionalNullValueToken = data.optionalChildrenAttributeNullValueToken;
        this.optionalListValueExpression = data.optionalChildrenAttributeListValueExpression;
        this.optionalEndingCommaToken = data.optionalChildrenAttributeEndingCommaToken;
    }
}

export class HTMLWidgetCallExpression extends Expression {
    public nameToken: SyntaxToken;

    public openParenthesisToken: SyntaxToken;
    public closeParenthesisToken: SyntaxToken;

    public attributeExpressions: HTMLWidgetCallAttributeExpression[];
    public optionalChildTreeExpression: HTMLWidgetCallChildTreeBaseExpression | null;

    public optionalEndingCommaToken: SyntaxToken | null;
    public optionalEndingSemiColonToken: SyntaxToken | null;

    constructor(
        data: {
            tagNameToken: SyntaxToken,
            callOpenParenthesisToken: SyntaxToken,
            callCloseParenthesisToken: SyntaxToken,

            callAttributeExpressions: HTMLWidgetCallAttributeExpression[],
            optionalCallChildTreeExpression: HTMLWidgetCallChildTreeBaseExpression | null,

            optionalCallEndingCommaToken: SyntaxToken | null,
            optionalCallEndingSemiColonToken: SyntaxToken | null,
        }
    ) {
        if (null !== data.optionalCallChildTreeExpression) {
            super(ExpressionType.htmlWidgetCallExpression, [data.optionalCallChildTreeExpression]);
        }
        else {
            super(ExpressionType.htmlWidgetCallExpression, []);
        }

        this.nameToken = data.tagNameToken;

        this.openParenthesisToken = data.callOpenParenthesisToken;
        this.closeParenthesisToken = data.callCloseParenthesisToken;

        this.attributeExpressions = data.callAttributeExpressions;
        this.optionalChildTreeExpression = data.optionalCallChildTreeExpression;

        this.optionalEndingSemiColonToken = data.optionalCallEndingSemiColonToken;
        this.optionalEndingCommaToken = data.optionalCallEndingCommaToken;
    }
}
