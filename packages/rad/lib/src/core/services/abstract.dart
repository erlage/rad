// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';

/// Base class for framework's service.
///
@internal
abstract class Service with ServicesResolver {
  final RootRenderElement rootElement;

  Service(this.rootElement);

  Services get services => resolveServices(rootElement);

  void startService() {}

  void stopService() {}
}
