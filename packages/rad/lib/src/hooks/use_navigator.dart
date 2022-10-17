// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/abstract/hook.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/interface/hooks/dispatcher.dart';
import 'package:rad/src/widgets/navigator.dart';

/// Returns nearest navigator state.
///
/// If provided [byKey], will fetch state of a navigator with matching key.
///
NavigatorState useNavigator({Key? byKey}) {
  var useNavigatorHook = useHook();
  useNavigatorHook ??= setupHook(_UseNavigatorHook(byKey));

  if (useNavigatorHook is! _UseNavigatorHook) {
    throw Exception(
      'Expecting hook of type: $_UseNavigatorHook '
      'but got: ${useNavigatorHook.runtimeType}. '
      'Please make sure your hooks call order is not dynamic.',
    );
  }

  return useNavigatorHook.state!;
}

/// A hook for getting navigator state.
///
class _UseNavigatorHook extends Hook {
  /// Match with key(if provided).
  ///
  final Key? byKey;

  /// Fetched Navigator state.
  ///
  NavigatorState? state;

  /// Create navigator hook.
  ///
  _UseNavigatorHook(this.byKey);

  @override
  void register() {
    state = Navigator.of(context!, byKey: byKey);
  }
}
