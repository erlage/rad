// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/widgets/abstract/no_child_widget.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Root render element.
///
/// Root render elements are different from normal render elements in that
/// there can be only one root render element in a single app instance and
/// second they don't have a corresponding widget associated with them.
///
class RootRenderElement extends RenderElement {
  RootRenderElement({
    required String appTargetId,
    required Element appTargetDomNode,
  }) : super.bigBang(
          appTargetId: appTargetId,
          appTargetDomNode: appTargetDomNode,
        );

  @override
  List<Widget> get childWidgets => ccImmutableEmptyListOfWidgets;
}

/// A temporary element.
///
/// Temporary elements act as linker render elements that holds new render
/// elements until they are mounted. This allow framework to build new widgets
/// in memory and mount them all in single operation.
///
@internal
class TemporaryElement extends RenderElement {
  /// Create a temporary render element.
  ///
  /// Temporary elements are render elements that can hold new render elements
  /// until they are mounted. This allow framework to build new widgets in
  /// memory and mount them all in single operation.
  ///
  /// We setup parent pointers on temporary render element to point to future
  /// parent(actual parent) of childs being built in order to allow new widgets
  /// use methods that requires traversing ancestors during build. for example,
  /// this enables users to call dependeOnInher* inside build or even inside
  /// initState method of a stateful widget.
  ///
  factory TemporaryElement.create({
    required Services services,
    required RenderElement possibleParent,
  }) {
    return TemporaryElement._(services, possibleParent);
  }

  /// Temporary render element constructor.
  ///
  TemporaryElement._(
    Services services,
    RenderElement possibleParent,
  ) : super.temporary(
          services: services,
          possibleParent: possibleParent,
          tempWidget: const _TemporaryWidget(),
          tempDomNode: document.createElement('div'),
        );

  @override
  List<Widget> get childWidgets => throw Exception('Temporary render element');
}

// ----------------------------------------------------------------------
//  Private
// ----------------------------------------------------------------------

/// A temporary widget.
///
class _TemporaryWidget extends NoChildWidget {
  const _TemporaryWidget();

  @override
  String get widgetType => '_DummyWidget';

  @override
  DomTagType? get correspondingTag => null;

  @override
  bool shouldUpdateWidget(oldWidget) => false;

  @override
  bool shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) => false;
}
