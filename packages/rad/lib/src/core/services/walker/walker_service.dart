import 'dart:html' show Node;

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Tree Walker/Registry for Dom/render elements.
///
class WalkerService extends Service {
  final WalkerOptions options;

  /// Registered elements.
  ///
  /// Dom node to widget-key-value mappings.
  ///
  final _domNodeToElementMap = <Node, RenderElement>{};

  /// Registered global elements.
  ///
  final _globalElements = <String, RenderElement>{};

  WalkerService(RootElement rootElement, this.options) : super(rootElement);

  @override
  startService() {
    _globalElements.clear();
    _domNodeToElementMap.clear();
  }

  @override
  stopService() {
    _globalElements.clear();
    _domNodeToElementMap.clear();
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

    if (renderElement.hasDomNode) {
      _domNodeToElementMap[renderElement.domNode!] = renderElement;
    }
  }

  void unRegisterElement(RenderElement element) {
    if (element.key is GlobalKey) {
      _globalElements.remove(element.key!.value);
    }

    if (element.hasDomNode) {
      _domNodeToElementMap.remove(element.domNode);
    }
  }

  /// Returns associated render element of global key.
  ///
  RenderElement? getRenderElementAssociatedWithGlobalKey(GlobalKey key) {
    return _globalElements[key.value];
  }

  /// Returns associated render element of dom node.
  ///
  RenderElement? getRenderElementAssociatedWithDomNode(Node domNode) {
    return _domNodeToElementMap[domNode];
  }

  /// Return all registered elements.
  ///
  List<RenderElement> dumpElements() {
    return _domNodeToElementMap.values.toList();
  }
}
