// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

/// Test Stack.
///
/// Used by tests for logging 'order in which particular event occurs',
/// procedure, or any detail that requires some sort of state so it
/// can be verified later.
///
class RT_TestStack {
  final _entries = <String>[];
  List<String> get entries => _entries.toList();

  void push(String entry) => _entries.add(entry);

  String pop() => _entries.removeLast();

  String popFromStart() => _entries.removeAt(0);

  bool canPop() => _entries.isNotEmpty;

  void clearState() => _entries.clear();
}
