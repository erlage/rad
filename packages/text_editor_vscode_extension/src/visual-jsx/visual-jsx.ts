// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';
import * as decorationsImport from './decorations';
import * as decorationsImportExperiment from './decorations_experimental';
import { Parser } from '../parser/parser';
import { PreparedDecorations } from './prepared_decorations';
import { HTMLWidgetCallExpression, HTMLWidgetCallNamedChildAttributeExpression, HTMLWidgetCallNamedChildrenAttributeExpression, HTMLWidgetCallPositionalChildrenAttributeExpression } from '../parser/expressions';
import { config } from '../config';
import { SyntaxToken } from '../parser/syntax_token';

export class VisualJSX {
	private parser: Parser;
	private activeEditor: vscode.TextEditor;
	private decorations = new PreparedDecorations();

	constructor(parser: Parser, activeEditor: vscode.TextEditor) {
		this.parser = parser;
		this.activeEditor = activeEditor;
	}

	public run() {
		if (config.jsxEnable) {
			this.parser.parse(); // idempotent
			this.setDecorations();
		} else {
			this.decorations.clear(this.activeEditor);
		}
	}

	private setDecorations() {

		let isExperimentParsingOfficialSyntaxEnabled = config.jsxEnableExperimentParsingOfficialSyntax;

		for (const expression of this.parser.extractedHTMLWidgetCallExpressions) {

			let treeExpression = expression.optionalChildTreeExpression;

			if (null !== treeExpression && treeExpression instanceof HTMLWidgetCallPositionalChildrenAttributeExpression) {
				this.decorateCallWithPositionalChildrenAttribute(expression, treeExpression);
				continue;
			}

			if (isExperimentParsingOfficialSyntaxEnabled) {
				if (null === treeExpression) {
					this.decorateCallWithoutChildWidgets(expression);
					continue;
				}

				if (treeExpression instanceof HTMLWidgetCallNamedChildrenAttributeExpression) {
					this.decorateCallWithNamedChildrenAttribute(expression, treeExpression);
					continue;
				}

				if (treeExpression instanceof HTMLWidgetCallNamedChildAttributeExpression) {
					this.decorateCallWithNamedChildAttribute(expression, treeExpression);
					continue;
				}
			}
		}

		this.decorations.apply(this.activeEditor);
	}

	private decorateCommons(expression: HTMLWidgetCallExpression): void {
		let decorationNameSpaceCommon = decorationsImport.Common;

		let tagNameToken = expression.nameToken;
		let openParenthesisToken = expression.openParenthesisToken;

		this.decorations.addRange(decorationNameSpaceCommon.getForTagName(), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(tagNameToken.offset),
				this.activeEditor.document.positionAt(tagNameToken.offset + tagNameToken.length)
			),
		});

		this.decorations.addRange(decorationNameSpaceCommon.getForCallOpenParenthesis(), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(openParenthesisToken.offset),
				this.activeEditor.document.positionAt(openParenthesisToken.offset + 1)
			),
		});

		// ----------------------------------------------------------

		for (const attributeExpression of expression.attributeExpressions) {
			this.decorateAttribute({
				attributeNameToken: attributeExpression.nameToken,
				attributeDoubleColonToken: attributeExpression.doubleColonToken,
				optionalAttributeEndingCommaToken: attributeExpression.optionalEndingCommaToken,
			});
		}
	}

	private decorateAttribute(o: {
		attributeNameToken: SyntaxToken,
		attributeDoubleColonToken: SyntaxToken,
		optionalAttributeEndingCommaToken: SyntaxToken | null,
	}): void {
		this.decorations.addRange(decorationsImport.Common.getForAttributeName(), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(o.attributeNameToken.offset),
				this.activeEditor.document.positionAt(o.attributeNameToken.offset + o.attributeNameToken.length)
			),
		});

		this.decorations.addRange(decorationsImport.Common.getForAttributeDoubleColon(), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(o.attributeDoubleColonToken.offset),
				this.activeEditor.document.positionAt(o.attributeDoubleColonToken.offset + 1)
			),
		});

		if (null !== o.optionalAttributeEndingCommaToken) {
			this.decorations.addRange(decorationsImport.Common.getForAttributeEndingComma(), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(o.optionalAttributeEndingCommaToken.offset),
					this.activeEditor.document.positionAt(o.optionalAttributeEndingCommaToken.offset + 1)
				),
			});
		}
	}

	private decorateTreeExpressionAsAttribute(treeExpression: HTMLWidgetCallNamedChildrenAttributeExpression): void {
		this.decorateAttribute({
			attributeNameToken: treeExpression.childrenLiteralToken,
			attributeDoubleColonToken: treeExpression.doubleColonToken,
			optionalAttributeEndingCommaToken: treeExpression.optionalEndingCommaToken,
		});
	}

	// ----------------------------------------------------------



	private decorateCallWithPositionalChildrenAttribute(expression: HTMLWidgetCallExpression, treeExpression: HTMLWidgetCallPositionalChildrenAttributeExpression): void {
		let decorationNameSpace = decorationsImport.CallWithPositionalChildrenAttribute;

		this.decorateCommons(expression);

		let tagNameToken = expression.nameToken;
		let closeParenthesisToken = expression.closeParenthesisToken;

		let openBracketToken = treeExpression.listValueExpression.startToken;
		let closeBracketToken = treeExpression.listValueExpression.stopToken;

		let optionalEndingCommaToken = expression.optionalEndingCommaToken;
		let optionalEndingSemiColonToken = expression.optionalEndingSemiColonToken;


		this.decorations.addRange(decorationNameSpace.getForOpenBracket(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(openBracketToken.offset),
				this.activeEditor.document.positionAt(openBracketToken.offset + 1)
			),
		});

		this.decorations.addRange(decorationNameSpace.getForCloseBracket(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(closeBracketToken.offset),
				this.activeEditor.document.positionAt(closeBracketToken.offset + 1)
			),
		});

		this.decorations.addRange(decorationNameSpace.getForCloseParenthesis(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(closeParenthesisToken.offset),
				this.activeEditor.document.positionAt(closeParenthesisToken.offset + 1)
			),
		});

		if (null !== optionalEndingCommaToken) {
			this.decorations.addRange(decorationNameSpace.getForCallOptionalEndingComma(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset),
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset + 1)
				),
			});
		}

		if (null !== optionalEndingSemiColonToken) {
			this.decorations.addRange(decorationNameSpace.getForCallOptionalEndingSemiColon(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset),
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset + 1)
				),
			});
		}
	}

	// [Experimental] 
	// visualising of official(but unpleasant) syntax.

	private decorateCallWithoutChildWidgets(expression: HTMLWidgetCallExpression): void {
		let optionalLastAttributeEndingComma: SyntaxToken | null = null;

		if (!config.jsxEnablePrettyMode) {
			return this.decorateHTMLWidgetWithoutChildWidgetsOnSingleLine(expression);
		}

		if (expression.attributeExpressions.length > 0) {
			let lastAttributeExpression = expression.attributeExpressions[expression.attributeExpressions.length - 1];

			optionalLastAttributeEndingComma = lastAttributeExpression.optionalEndingCommaToken;
		}

		if (null === optionalLastAttributeEndingComma) {
			return this.decorateHTMLWidgetWithoutChildWidgetsOnSingleLine(expression);
		}

		return this.decorateHTMLWidgetWithoutChildWidgetsOnMultiLine(expression, optionalLastAttributeEndingComma);
	}

	private decorateHTMLWidgetWithoutChildWidgetsOnSingleLine(expression: HTMLWidgetCallExpression): void {
		let decorationNameSpace = decorationsImportExperiment.CallWithoutChildWidgets;

		this.decorateCommons(expression);

		let tagNameToken = expression.nameToken;
		let closeParenthesisToken = expression.closeParenthesisToken;

		this.decorations.addRange(decorationNameSpace.getForCallCloseParenthesisSingleLine(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(closeParenthesisToken.offset),
				this.activeEditor.document.positionAt(closeParenthesisToken.offset + 1)
			),
		});

		let optionalEndingCommaToken = expression.optionalEndingCommaToken;
		let optionalEndingSemiColonToken = expression.optionalEndingSemiColonToken;

		if (null !== optionalEndingCommaToken) {
			this.decorations.addRange(decorationNameSpace.getForOptionalCallEndingCommaSingleLine(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset),
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset + 1)
				),
			});
		}

		if (null !== optionalEndingSemiColonToken) {
			this.decorations.addRange(decorationNameSpace.getForOptionalEndingSemiColonSingleLine(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset),
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset + 1)
				),
			});
		}
	}

	private decorateHTMLWidgetWithoutChildWidgetsOnMultiLine(expression: HTMLWidgetCallExpression, commaFollowingLastAttribute: SyntaxToken): void {
		let decorationNameSpace = decorationsImportExperiment.CallWithoutChildWidgets;

		this.decorateCommons(expression);

		let tagNameToken = expression.nameToken;
		let closeParenthesisToken = expression.closeParenthesisToken;

		let optionalCommaToken = expression.optionalEndingCommaToken;
		let optionalSemiColonToken = expression.optionalEndingSemiColonToken;

		this.decorations.addRange(decorationNameSpace.getForOptionalAttributeEndingComma(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(commaFollowingLastAttribute.offset),
				this.activeEditor.document.positionAt(commaFollowingLastAttribute.offset + 1)
			),
		});

		this.decorations.addRange(decorationNameSpace.getForCallCloseParenthesisMultiLine(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(closeParenthesisToken.offset),
				this.activeEditor.document.positionAt(closeParenthesisToken.offset + 1)
			),
		});

		if (null !== optionalCommaToken) {
			this.decorations.addRange(decorationNameSpace.getForOptionalCallEndingCommaMultiLine(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalCommaToken.offset),
					this.activeEditor.document.positionAt(optionalCommaToken.offset + 1)
				),
			});
		}

		if (null !== optionalSemiColonToken) {
			this.decorations.addRange(decorationNameSpace.getForOptionalCallSemiColonMultiLine(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalSemiColonToken.offset),
					this.activeEditor.document.positionAt(optionalSemiColonToken.offset + 1)
				),
			});
		}
	}

	private decorateCallWithNamedChildAttribute(_: HTMLWidgetCallExpression, __: HTMLWidgetCallNamedChildAttributeExpression): void {
		// not supported at all.
	}

	private decorateCallWithNamedChildrenAttribute(expression: HTMLWidgetCallExpression, treeExpression: HTMLWidgetCallNamedChildrenAttributeExpression): void {
		let optionalChildNullValueToken = treeExpression.optionalNullValueToken;
		if (null !== optionalChildNullValueToken) {
			return this.decorateCallWithNamedChildrenAttributeHavingNullValue(expression, treeExpression);
		}

		return this.decorateCallWithNamedChildrenAttributeHavingListValue(expression, treeExpression);
	}

	private decorateCallWithNamedChildrenAttributeHavingNullValue(expression: HTMLWidgetCallExpression, treeExpression: HTMLWidgetCallNamedChildrenAttributeExpression): void {
		let decorationNameSpace = decorationsImportExperiment.CallWithNamedChildrenAttribute;

		this.decorateCommons(expression);
		this.decorateTreeExpressionAsAttribute(treeExpression);

		let tagNameToken = expression.nameToken;
		let closeParenthesisToken = expression.closeParenthesisToken;

		let optionalEndingCommaToken = expression.optionalEndingCommaToken;
		let optionalEndingSemiColonToken = expression.optionalEndingSemiColonToken;

		this.decorations.addRange(decorationNameSpace.getForCallCloseParenthesis(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(closeParenthesisToken.offset),
				this.activeEditor.document.positionAt(closeParenthesisToken.offset + 1)
			),
		});

		if (null !== optionalEndingCommaToken) {
			this.decorations.addRange(decorationNameSpace.getForOptionalCallEndingComma(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset),
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset + 1)
				),
			});
		}

		if (null !== optionalEndingSemiColonToken) {
			this.decorations.addRange(decorationNameSpace.getForOptionalCallEndingSemiColon(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset),
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset + 1)
				),
			});
		}
	}

	private decorateCallWithNamedChildrenAttributeHavingListValue(expression: HTMLWidgetCallExpression, treeExpression: HTMLWidgetCallNamedChildrenAttributeExpression): void {
		let decorationNameSpace = decorationsImportExperiment.CallWithNamedChildrenAttribute;

		this.decorateCommons(expression);

		let tagNameToken = expression.nameToken;
		let closeParenthesisToken = expression.closeParenthesisToken;
		let childrenLiteralToken = treeExpression.childrenLiteralToken;
		let optionalEndingCommaToken = expression.optionalEndingCommaToken;
		let optionalEndingSemiColonToken = expression.optionalEndingSemiColonToken;

		let listValueExpression = treeExpression.optionalListValueExpression!;
		let childrenListOpenBracketToken = listValueExpression.startToken;
		let childrenListCloseBracketToken = listValueExpression.stopToken;

		this.decorations.addRange(decorationNameSpace.getForChildrenAttributeNameAndOpenBracket(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(childrenLiteralToken.offset),
				this.activeEditor.document.positionAt(childrenListOpenBracketToken.offset + 1)
			),
		});

		this.decorations.addRange(decorationNameSpace.getForChildrenAttributeCloseBracket(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(childrenListCloseBracketToken.offset),
				this.activeEditor.document.positionAt(childrenListCloseBracketToken.offset + 1)
			),
		});

		this.decorations.addRange(decorationNameSpace.getForCallCloseParenthesisNonNull(tagNameToken.text), {
			range: new vscode.Range(
				this.activeEditor.document.positionAt(closeParenthesisToken.offset),
				this.activeEditor.document.positionAt(closeParenthesisToken.offset + 1)
			),
		});

		if (null !== optionalEndingCommaToken) {
			this.decorations.addRange(decorationNameSpace.getForCallOptionalCommaNonNull(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset),
					this.activeEditor.document.positionAt(optionalEndingCommaToken.offset + 1)
				),
			});
		}

		if (null !== optionalEndingSemiColonToken) {
			this.decorations.addRange(decorationNameSpace.getForCallOptionalSemiColonNonNull(tagNameToken.text), {
				range: new vscode.Range(
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset),
					this.activeEditor.document.positionAt(optionalEndingSemiColonToken.offset + 1)
				),
			});
		}
	}
}
