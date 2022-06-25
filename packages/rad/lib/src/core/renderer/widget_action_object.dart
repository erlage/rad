// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';

/// A simple object used to wrap Action entries
/// before dispatching them.
///
@internal
class WidgetActionObject {
  final RenderElement element;
  final WidgetAction widgetAction;

  WidgetActionObject(this.widgetAction, this.element);
}
