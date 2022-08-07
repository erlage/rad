// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

/// A simple base for dependency driven hooks.
///
@internal
abstract class DependenciesDrivenHook<DependenciesType> extends Hook {
  /// List of current dependencies.
  ///
  List<DependenciesType>? _currentDependencies;

  /// Whether dependencies have changed during renders
  ///
  @nonVirtual
  @protected
  bool get areDependenciesChanged => _areDependenciesChanged;
  var _areDependenciesChanged = false;

  /// Update dependencies.
  ///
  /// @nodoc
  @nonVirtual
  void updateDependencies(List<DependenciesType>? dependencies) {
    _areDependenciesChanged = _isDifferent(
      dependenciesSetOne: dependencies,
      dependenciesSetTwo: _currentDependencies,
    );

    _currentDependencies = dependencies;
  }

  /// Whether two dependency sets are different.
  ///
  /// Please note, if one of the set is null or both sets are null we consider
  /// them different.
  ///
  bool _isDifferent({
    required List<DependenciesType>? dependenciesSetOne,
    required List<DependenciesType>? dependenciesSetTwo,
  }) {
    if (null == dependenciesSetOne || null == dependenciesSetTwo) {
      return true;
    }

    if (dependenciesSetOne == dependenciesSetTwo) {
      return false;
    }

    if (dependenciesSetOne.length != dependenciesSetTwo.length) {
      return true;
    }

    var index = -1;
    for (final item in dependenciesSetOne) {
      index++;

      if (item != dependenciesSetTwo[index]) {
        return true;
      }
    }

    return false;
  }
}
