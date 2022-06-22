import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/widgets/abstract/no_child_widget.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Root render element.
///
/// Root render elements are different from normal render elements in that
/// there can be only one root render element in a single app instance and
/// second they don't have a corresponding widget associated with them.
///
class RootElement extends RenderElement {
  RootElement({
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
class RemnantElement extends RenderElement {
  /// Create a temporary render element.
  ///
  /// Temporary elements are render elements that can hold new render elements
  /// until they are mounted. This allow framework to build new widgets in
  /// memory and mount them all in single operation.
  ///
  /// We setup parent pointers on temporary render element to point to future
  /// parent(actual parent) of childs being built in order to allow new widgets
  /// use methods that requires traversing ancestors during build. for example,
  /// this enables users to call dependeOnInher* inside build or even initState
  /// method of a stateful widget.
  ///
  factory RemnantElement.create({
    required Services services,
    required RenderElement possibleParent,
  }) {
    return RemnantElement._(services, possibleParent);
  }

  /// Temporary render element constructor.
  ///
  RemnantElement._(
    Services services,
    RenderElement possibleParent,
  ) : super.temporary(
          services: services,
          possibleParent: possibleParent,
          tempWidget: const _DummyWidget(),
          tempDomNode: document.createElement('div'),
        );

  @override
  List<Widget> get childWidgets => throw Exception('Temporary render element');
}

// ----------------------------------------------------------------------
//  Private
// ----------------------------------------------------------------------

/// A dummy widget.
///
class _DummyWidget extends NoChildWidget {
  const _DummyWidget();

  @override
  String get widgetType => '_DummyWidget';

  @override
  DomTagType? get correspondingTag => null;

  @override
  bool shouldUpdateWidget(oldWidget) => false;

  @override
  bool shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) => false;
}
