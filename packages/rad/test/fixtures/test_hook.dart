// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// Create a test hook.
///
RT_TestHook useTestHook({
  VoidCallback? eventWillBuildScope,
  VoidCallback? eventDidBuildScope,
  VoidCallback? eventWillRebuildScope,
  VoidCallback? eventDidRebuildScope,
  VoidCallback? eventDidRenderScope,
  VoidCallback? eventDidUpdateScope,
  VoidCallback? eventWillUnMountScope,
  VoidCallback? eventDidUnMountScope,
}) {
  var useStateHook = useHook();
  useStateHook ??= setupHook(RT_TestHook(
    eventWillBuildScope: eventWillBuildScope,
    eventDidBuildScope: eventDidBuildScope,
    eventWillRebuildScope: eventWillRebuildScope,
    eventDidRebuildScope: eventDidRebuildScope,
    eventDidRenderScope: eventDidRenderScope,
    eventDidUpdateScope: eventDidUpdateScope,
    eventWillUnMountScope: eventWillUnMountScope,
    eventDidUnMountScope: eventDidUnMountScope,
  ));

  if (useStateHook is! RT_TestHook) {
    throw Exception('Please make sure your hooks order is not dynamic.');
  }

  return useStateHook;
}

/// A test hook that allows hooking into its internals.
///
class RT_TestHook extends Hook {
  VoidCallback? eventWillBuildScope;
  VoidCallback? eventDidBuildScope;
  VoidCallback? eventWillRebuildScope;
  VoidCallback? eventDidRebuildScope;
  VoidCallback? eventDidRenderScope;
  VoidCallback? eventDidUpdateScope;
  VoidCallback? eventWillUnMountScope;
  VoidCallback? eventDidUnMountScope;

  RT_TestHook({
    this.eventWillBuildScope,
    this.eventDidBuildScope,
    this.eventWillRebuildScope,
    this.eventDidRebuildScope,
    this.eventDidRenderScope,
    this.eventDidUpdateScope,
    this.eventWillUnMountScope,
    this.eventDidUnMountScope,
  });

  @override
  void register() {
    addHookEventListeners({
      HookEventType.willBuildScope: (_) => eventWillBuildScope?.call(),
      HookEventType.didBuildScope: (_) => eventDidBuildScope?.call(),
      HookEventType.willRebuildScope: (_) => eventWillRebuildScope?.call(),
      HookEventType.didRebuildScope: (_) => eventDidRebuildScope?.call(),
      HookEventType.didRenderScope: (_) => eventDidRenderScope?.call(),
      HookEventType.didUpdateScope: (_) => eventDidUpdateScope?.call(),
      HookEventType.willUnMountScope: (_) => eventWillUnMountScope?.call(),
      HookEventType.didUnMountScope: (_) => eventDidUnMountScope?.call(),
    });
  }

  /// Dispatch a rebuild request.
  ///
  void dispatchRebuildRequest() => performRebuild();
}
