// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import * as vscode from 'vscode';
import { RadCode } from './rad_code';

let radCodeActivatedInstance: RadCode | null = null;
export function extension(): RadCode | null {
	return radCodeActivatedInstance;
}

export function activate(context: vscode.ExtensionContext) {
	radCodeActivatedInstance = new RadCode(context);
	radCodeActivatedInstance?.run();
}

export function deactivate() {
	radCodeActivatedInstance = null;
}
