// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/objects/meta_information.dart';
import 'package:rad/src/core/interface/meta/meta_store.dart';

/// Meta information manager.
///
@internal
class Meta {
  Meta._();
  static Meta? _instance;
  static Meta get instance => _instance ??= Meta._();

  /// Meta stores.
  ///
  final _metaStores = <String, MetaStore>{};

  /// Add meta information to document.
  ///
  /// If meta information is already present with same meta id, then it'll
  /// update the existing meta information tag.
  ///
  void setMetaInformation({
    required BuildContext context,
    required String informationId,
    required MetaInformation information,
  }) {
    _getStore(context).setMetaInformation(
      informationId: informationId,
      information: information,
    );
  }

  /// Remove meta information from page.
  ///
  void unsetMetaInformation({
    required BuildContext context,
    required String informationId,
  }) {
    _getStore(context).unsetMetaInformation(informationId);
  }

  /// Clean all meta information associated with context.
  ///
  void cleanAppAssociatedMetaInformation({
    required BuildContext context,
  }) {
    _metaStores.remove(context.appTargetId)?.unsetAll();
  }

  /// Get meta store instance.
  ///
  MetaStore _getStore(BuildContext context) {
    if (!_metaStores.containsKey(context.appTargetId)) {
      _metaStores[context.appTargetId] = MetaStore();
    }

    return _metaStores[context.appTargetId]!;
  }
}
