// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Tree Walker/Registry for Dom/render elements.
///
@internal
class WalkerService extends Service {
  final WalkerOptions options;

  /// Registered global elements.
  ///
  final _globalElements = <String, RenderElement>{};

  WalkerService(RootRenderElement rootElement, this.options)
      : super(rootElement);

  @override
  startService() {
    _globalElements.clear();
  }

  @override
  stopService() {
    _globalElements.clear();
  }

  void registerElement(RenderElement renderElement) {
    var widgetKey = renderElement.key;

    if (widgetKey is GlobalKey) {
      if (services.debug.additionalChecks) {
        if (_globalElements.containsKey(widgetKey)) {
          return services.debug.exception(
            'Key $widgetKey already exists.'
            '\n\nThis usually happens in two scenarios,'
            '\n\n1. When you have duplicate keys in your code.'
            "\n\nor\n\n2. When you've two adjacent widgets of same type and one"
            ' of them is optional.\n\nCorrect way to fix (2): Use explicit keys'
            ' on one of the widgets that are of same type.',
          );
        }
      }

      _globalElements[widgetKey.value] = renderElement;
    }
  }

  void unRegisterElement(RenderElement element) {
    if (element.key is GlobalKey) {
      _globalElements.remove(element.key!.value);
    }
  }

  /// Returns associated render element of global key.
  ///
  RenderElement? getRenderElementAssociatedWithGlobalKey(GlobalKey key) {
    return _globalElements[key.value];
  }
}
