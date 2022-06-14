import 'dart:html';

import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Root render element.
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

/// A stub render element.
///
/// Framework uses stub elements to hold actual elements while building
/// actual widgets.
///
class RemnantElement extends RenderElement {
  // could cache this

  /// Create a remnant render element.
  ///
  factory RemnantElement.create(Services services) {
    return RemnantElement._(
      services.rootElement.appTargetId,
      document.createElement('div'),
    )
      ..frameworkBindDomNode(domNode: document.createElement('div'))
      ..frameworkAttachServices(services: services);
  }

  RemnantElement._(String appTargetId, Element appDomNode)
      : super.bigBang(
          appTargetId: appTargetId,
          appTargetDomNode: appDomNode,
        );

  @override
  List<Widget> get childWidgets => throw Exception('Stub render element');
}
