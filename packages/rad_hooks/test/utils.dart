// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/rad.dart';
import 'package:rad_hooks/src/use_effect.dart';
import 'package:rad_hooks/src/use_layout_effect.dart';

class TestEffectCallback<T> {
  final VoidCallback? Function() callback;
  final List<T>? dependencies;

  TestEffectCallback(this.callback, [this.dependencies]);
}

Widget testUseScopedEffectsWidget(
  List<TestEffectCallback<dynamic>> effectCallbacks,
) =>
    HookScope(() {
      for (final effectCallback in effectCallbacks) {
        useEffect(
          () {
            return effectCallback.callback();
          },
          effectCallback.dependencies,
        );
      }

      return const Text('hello world');
    });

Widget testUseScopedLayoutEffectsWidget(
  List<TestEffectCallback<dynamic>> effectCallbacks,
) =>
    HookScope(() {
      for (final effectCallback in effectCallbacks) {
        useLayoutEffect(
          () {
            return effectCallback.callback();
          },
          effectCallback.dependencies,
        );
      }

      return const Text('hello world');
    });
