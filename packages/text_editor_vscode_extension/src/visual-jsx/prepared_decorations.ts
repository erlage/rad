// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';

const decorations: Map<vscode.TextEditorDecorationType, vscode.DecorationOptions[]> = new Map();

export class PreparedDecorations {
    public apply(activeEditor: vscode.TextEditor): void {
        for (const decorationType of decorations.keys()) {
            activeEditor.setDecorations(decorationType, decorations.get(decorationType)!);
            decorations.set(decorationType, []);
        }
    }

    public clear(activeEditor: vscode.TextEditor) {
        for (const decorationType of decorations.keys()) {
            decorations.set(decorationType, []);
            activeEditor.setDecorations(decorationType, []);
        }
    }

    public addRange(decorationType: vscode.TextEditorDecorationType, range: vscode.DecorationOptions): void {
        let container = decorations.get(decorationType);
        if (undefined === container) {
            container = [];
            decorations.set(decorationType, [range]);
        }

        container.push(range);
    }
}