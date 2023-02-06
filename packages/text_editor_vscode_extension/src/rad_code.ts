// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';
import { config } from './config';
import { Parser } from './parser/parser';
import { HTML2Rad } from './transpiler/html2rad';
import { VisualJSX } from './visual-jsx/visual-jsx';

export class RadCode {
    private runTimeout: NodeJS.Timer | undefined = undefined;

    constructor(context: vscode.ExtensionContext) {
        let activeEditor = vscode.window.activeTextEditor;

        context.subscriptions.push(vscode.commands.registerCommand('rad.jsxToggle', () => {
            config.setJsxEnable(!config.jsxEnable);
            this.triggerRun();
        }));

        context.subscriptions.push(vscode.commands.registerCommand('rad.jsxTogglePrettyMode', () => {
            config.setJsxEnablePrettyMode(!config.jsxEnablePrettyMode);
            this.triggerRun();
        }));

        context.subscriptions.push(vscode.commands.registerCommand('rad.jsxToggleExperimentParsingOriginalSyntax', () => {
            config.setJsxEnableExperimentParsingOriginalSyntax(!config.jsxEnableExperimentParsingOriginalSyntax);
            this.triggerRun();
        }));

        context.subscriptions.push(vscode.commands.registerCommand('rad.html2Rad', () => {
            this.runHTML2Rad();
        }));

        vscode.workspace.onDidChangeConfiguration((_) => {
            config.refresh();
            this.triggerRun();
        });

        vscode.window.onDidChangeActiveTextEditor(editor => {
            if (editor) {
                this.triggerRun();
            }
        }, null, context.subscriptions);

        vscode.workspace.onDidChangeTextDocument(event => {
            if (activeEditor && event.document === activeEditor.document) {
                this.triggerRun(true);
            }
        }, null, context.subscriptions);
    }

    public run(): void {
        this.triggerRun(true);
    }

    private triggerRun(throttle = false): void {
        if (this.runTimeout) {
            clearTimeout(this.runTimeout);
            this.runTimeout = undefined;
        }
        if (throttle) {
            this.runTimeout = setTimeout(this.dispatchRun, 100);
        } else {
            this.dispatchRun();
        }
    }

    private dispatchRun() {
        let activeEditor = vscode.window.activeTextEditor;
        if (!activeEditor) {
            return;
        }

        const documentText = activeEditor.document.getText();
        const parser = new Parser(documentText);

        const visualJSX = new VisualJSX(parser, activeEditor);
        visualJSX.run();
    }

    private runHTML2Rad() {
        let editor = vscode.window.activeTextEditor;
        if (!editor) {
            return;
        }

        let selection = editor.selection;
        let htmlText = editor.document.getText(selection);

        let h2Rad = new HTML2Rad();
        let radOutput = h2Rad.transpile(htmlText);

        if (null !== radOutput) {
            let nonNullRadOutput = radOutput;

            editor.edit(editBuilder => {
                editBuilder.replace(selection, nonNullRadOutput);
            });
        }
    }
}