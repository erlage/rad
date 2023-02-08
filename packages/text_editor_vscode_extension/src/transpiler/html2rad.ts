// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';

import { config } from '../config';
import { HTMLElement, Node, parse, TextNode } from 'node-html-parser';
import { AttributeValueType, attributeValueTypeEnumMappings } from "./attribute_value_types";
import { constSupportedAttributeForTagsMappings, constSupportedGlobalAttributes } from "./attribute_support";
import { constNativeToRadAttributeNameMappings, constNativeToRadTagMappings, constShortTagToLongTagMappings } from "../constants";

enum OutputSyntax {
    rad,
    radLong,
    htmlVSCodePackage,
}

export class HTML2Rad {
    private outputSyntaxType: OutputSyntax;

    constructor() {
        switch (config.html2RadOutputSyntax) {
            case 'rad':
                this.outputSyntaxType = OutputSyntax.rad;
                break;

            case 'rad__long':
                this.outputSyntaxType = OutputSyntax.radLong;
                break;

            default:
                this.outputSyntaxType = OutputSyntax.htmlVSCodePackage;
        }
    }

    public transpile(htmlText: string): string | null {
        try {
            let domTreeRootNode = parse(htmlText); // using node-html-parser

            return this.domTreeToWidgetsString(domTreeRootNode, '', ';');
        } catch (e) {
            vscode.window.showInformationMessage(`Unable to parse HTML contents: ${e}`);
        }

        return null;
    }

    private domTreeToWidgetsString(treeRootNode: Node, indent: string, suffix: string) {
        if (treeRootNode instanceof TextNode) {
            return this.textNodeToString(treeRootNode, indent, suffix);
        }

        if (treeRootNode instanceof HTMLElement) {
            return this.elementToString(treeRootNode, indent, suffix);
        }

        return this.multipleNodesToString(treeRootNode, indent, suffix);
    }

    private textNodeToString(node: TextNode, indent: string, suffix: string): string {
        let nodeText = this.trimWhitespace(node.text);
        if (0 === nodeText.length) {
            return '';
        }

        return `${indent}Text('${this.escapeString(nodeText)}')${suffix}`;
    }

    private multipleNodesToString(root: Node, indent: string, suffix: string) {
        let buffer = '';

        for (const childNode of root.childNodes) {
            buffer += this.domTreeToWidgetsString(childNode, indent, suffix);
        }

        return buffer;
    }

    private elementToString(node: HTMLElement, indent: string, suffix: string): string {
        let tagRadName = constNativeToRadTagMappings.get(node.rawTagName);
        if (undefined === tagRadName) {
            return this.allChildNodesToString(node.childNodes, indent, suffix);
        }

        let buffer = `${this.getTagNameString(tagRadName)}(`;

        buffer += this.allAttributesToString(tagRadName, node.attributes);

        buffer += this.getChildrenAttribute(node, indent, suffix);

        return buffer;
    }

    private allChildNodesToString(childNodes: Node[], indent: string, suffix: string) {
        indent += '    ';
        let buffer = '';
        for (const childNode of childNodes) {
            buffer += '\n' + this.domTreeToWidgetsString(childNode, indent, suffix);
        }

        return buffer;
    }

    private allAttributesToString(tagRadName: string, attributes: Record<string, string>): string {
        let additionalAttributes = new Map<string, string>();

        let buffer = '';
        for (const attributeNativeName in attributes) {
            const attributeNativeValue = attributes[attributeNativeName];

            let attributeString = this.getAttributeString(tagRadName, attributeNativeName, attributeNativeValue);
            if (null === attributeString) {
                additionalAttributes.set(attributeNativeName, attributeNativeValue);
            } else {
                buffer += attributeString + ', ';
            }
        }

        if (additionalAttributes.size > 0) {
            buffer += 'additionalAttributes: {';
            for (const attributeNativeName of additionalAttributes.keys()) {
                let attributeNativeValue = additionalAttributes.get(attributeNativeName)!;

                let escapedNativeName = this.escapeString(attributeNativeName);
                let escapedNativeValue = this.escapeString(attributeNativeValue);

                buffer += `'${escapedNativeName}': '${escapedNativeValue}',`;
            }
            buffer += '}, ';
        }

        return buffer;
    }

    private getTagNameString(tagRadName: string): string {
        if (OutputSyntax.htmlVSCodePackage === this.outputSyntaxType) {
            return tagRadName;
        }

        if (OutputSyntax.rad === this.outputSyntaxType) {
            return tagRadName;
        }

        return constShortTagToLongTagMappings.get(tagRadName) ?? '';
    }

    private getChildrenAttribute(node: Node, indent: string, suffix: string): string {
        let buffer = '';

        switch (this.outputSyntaxType) {
            case OutputSyntax.rad:
            case OutputSyntax.radLong:
                buffer += 'children: [';
                break;

            default:
                buffer += '[';
        }

        buffer += this.allChildNodesToString(node.childNodes, indent, ',');
        buffer += `\n${indent}])${suffix}`;

        return buffer;
    }

    private getAttributeString(tagRadName: string, attributeNativeName: string, attributeNativeValue: string): string | null {
        let attributeRadName = constNativeToRadAttributeNameMappings.get(attributeNativeName);
        if (undefined === attributeRadName) {
            return null;
        }

        let attributeRadValueType = constSupportedGlobalAttributes.get(attributeRadName);
        if (undefined === attributeRadValueType) {
            let radLongTagName = constShortTagToLongTagMappings.get(tagRadName);
            if (undefined === radLongTagName) {
                vscode.window.showInformationMessage(`Looks like something is broken inside extension(getAttributeString()).`);
                return null;
            }

            let tagSupportMap = constSupportedAttributeForTagsMappings.get(radLongTagName);
            if (undefined === tagSupportMap) {
                return null;
            }

            attributeRadValueType = tagSupportMap.get(attributeRadName);
            if (undefined === attributeRadValueType) {
                return null;
            }
        }

        return this.generateAttributeStringForRadType({
            attributeRadName: attributeRadName,
            attributeNativeName: attributeNativeName,
            attributeNativeValue: attributeNativeValue,
            radValueType: attributeRadValueType,
        });
    }

    private generateAttributeStringForRadType(o: {
        attributeRadName: string,
        attributeNativeName: string,
        attributeNativeValue: string,
        radValueType: AttributeValueType,
    }): string | null {

        // handle primitive types

        switch (o.radValueType) {
            case AttributeValueType._boolType:
                let boolLiteral = o.attributeNativeValue === 'false' ? 'false' : 'true';
                return `${o.attributeRadName}: ${boolLiteral}`;

            case AttributeValueType._intType:
                let intLiteral = o.attributeNativeValue;
                return `${o.attributeRadName}: ${intLiteral}`;

            case AttributeValueType._stringType:
                let escapedStringLiteral = this.escapeString(o.attributeNativeValue);
                return `${o.attributeRadName}: '${escapedStringLiteral}'`;
        }

        // handle enum types

        let enumRadTypeValuesMap = attributeValueTypeEnumMappings.get(o.radValueType);
        if (undefined === enumRadTypeValuesMap) {
            return null;
        }

        let enumRadValue = enumRadTypeValuesMap.get(o.attributeNativeValue);
        if (undefined === enumRadValue) {
            return null;
        }

        return `${o.attributeRadName}: ${o.radValueType}.${enumRadValue}`;
    }

    private escapeString(input: string): string {
        return input
            .replaceAll("'", "\\'")
            .replaceAll("$", "\\$")
            ;
    }

    private trimWhitespace(input: string): string {
        return input.replace(/\s/g, '');
    }
}