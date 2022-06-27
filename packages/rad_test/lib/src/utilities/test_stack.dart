// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Test Stack.
///
/// Can be used for logging order in which particular events occured, or a
/// procedure order, or any detail that requires some sort of state so that
/// can be verified later.
///
class TestStack {
  final _entries = <String>[];
  final _loggedEntries = <String>[];

  /// List of stack entries.
  ///
  List<String> get entries => _entries.toList();

  /// List of logged entries.
  ///
  List<String> get loggedEntries => _loggedEntries.toList();

  /// Push a entry on top of stack.
  ///
  void push(String entry) {
    _entries.add(entry);
    _loggedEntries.add(entry);
  }

  /// Pop entry from top of stack.
  ///
  String pop() => _entries.removeLast();

  /// Reverse pop.
  ///
  String popFromStart() => _entries.removeAt(0);

  /// Whether current stack is not empty.
  ///
  bool canPop() => _entries.isNotEmpty;

  /// Clear stack state.
  ///
  void clearState() => _entries.clear();
}
