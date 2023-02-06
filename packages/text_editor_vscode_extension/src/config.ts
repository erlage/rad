// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';

class Config {
    private config: vscode.WorkspaceConfiguration;

    constructor() {
        this.config = vscode.workspace.getConfiguration("rad");
    }

    public refresh(): void {
        this.config = vscode.workspace.getConfiguration("rad");
    }

    private get<T>(key: string, defaultValue: T): T {
        return this.config.get<T>(key, defaultValue) ?? defaultValue;
    }

    private async set<T>(key: string, value: T, target: vscode.ConfigurationTarget): Promise<void> {
        await this.config.update(key, value, target);
    }

    get jsxEnable(): boolean { return this.get<boolean>("jsxEnable", true); }
    get jsxEnablePrettyMode(): boolean { return this.get<boolean>("jsxEnablePrettyMode", false); }
    get jsxEnableExperimentParsingOriginalSyntax(): boolean { return this.get<boolean>("jsxEnableExperimentParsingOriginalSyntax", false); }
    get html2RadOutputSyntax(): string { return this.get<string>("html2RadOutputSyntax", "rad_html_vscode"); }

    public setJsxEnable(value: boolean) {
        this.set("jsxEnable", value, vscode.ConfigurationTarget.Global);
    }

    public setJsxEnablePrettyMode(value: boolean) {
        this.set("jsxEnablePrettyMode", value, vscode.ConfigurationTarget.Global);
    }

    public setJsxEnableExperimentParsingOriginalSyntax(value: boolean) {
        this.set("jsxEnableExperimentParsingOriginalSyntax", value, vscode.ConfigurationTarget.Global);
    }
}

export const config = new Config();
