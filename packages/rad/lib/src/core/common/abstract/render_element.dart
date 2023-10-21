// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/dart2js.dart';
import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/meta_information.dart';
import 'package:rad/src/core/common/objects/render_event.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/interface/meta/meta.dart';
import 'package:rad/src/core/renderer/renderer.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/span.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// An instantiation of a [Widget] at a particular location in the tree.
///
abstract class RenderElement implements BuildContext {
  /*
  |--------------------------------------------------------------------------
  | render element's data
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @override
  Key? get key => _key;
  final Key? _key;

  @nonVirtual
  @override
  Widget get widget => _widget!;
  Widget? _widget;

  @nonVirtual
  @override
  String get widgetRuntimeType => _widgetRuntimeType;
  final String _widgetRuntimeType;

  /// Associated DOM node.
  ///
  @nonVirtual
  Element? get domNode => _domNode;
  Element? _domNode;

  /// Whether current element has an associated dom node.
  ///
  @nonVirtual
  bool get hasDomNode => _hasDomNode;
  bool _hasDomNode = false;

  /// App's target id.
  ///
  @nonVirtual
  @override
  final String appTargetId;

  /*
  |--------------------------------------------------------------------------
  | render element's child widgets
  |--------------------------------------------------------------------------
  */

  /// Child widgets of current widget(if any).
  ///
  /// Framework will call this getter on two occasions:
  ///
  /// 1) When it finishes building current widget and as part of completing the
  /// process, it'll check whether widget has children to build and build them
  /// if so.
  ///
  /// 2) When it finishes updating current widget and as part of completing the
  /// process, it'll check whether widget has children to update and update
  /// them if so. Note that framework will not check children if widget returns
  /// false from [Widget.shouldUpdateWidgetChildren].
  ///
  List<Widget> get widgetChildren;

  /*
  |--------------------------------------------------------------------------
  | constructor
  |--------------------------------------------------------------------------
  */

  RenderElement(Widget widget, RenderElement parent)
      :

        // widget properties

        _key = widget.key,
        _widget = widget,
        _widgetRuntimeType = '${widget.runtimeType}',

        // inherit from parent

        _isRoot = false,
        _parent = parent,
        _services = parent.frameworkServices,
        appTargetId = parent.appTargetId;

  /// Create root's element.
  ///
  /// Root elements are different from regular element in that they don't have a
  /// widget associated with them.
  ///
  /// @nodoc
  @internal
  RenderElement.frameworkBigBang({
    required this.appTargetId,
    required Element appTargetDomNode,
  })  : _key = null,
        _widget = null,
        _parent = null,
        _isRoot = true,
        _hasDomNode = true,
        _domNode = appTargetDomNode,
        _widgetRuntimeType = Constants.contextTypeBigBang;

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Register hook.
  ///
  /// This is the first method that framework calls as part of rendering
  /// this widget on screen. It's safe to register event callbacks in this
  /// method using [addRenderEventListeners].
  ///
  @protected
  void register() {}

  /// Render hook.
  ///
  /// This hook gets called exactly once during lifetime of an element. This
  /// hook can optionally return a patch which will be applied on dom node
  /// associated with the current element(if there's any).
  ///
  @protected
  DomNodePatch? render({required Widget widget}) => null;

  /// Update hook.
  ///
  /// This hook gets called everytime a ancestor element rebuilds. This
  /// hook can optionally return a patch which will be applied on dom node
  /// associated with the current element(if there's any).
  ///
  @protected
  DomNodePatch? update({
    required UpdateType updateType,
    required Widget oldWidget,
    required Widget newWidget,
  }) {
    return null;
  }

  /// After widget's rebind hook.
  ///
  /// This hook gets called everytime a state change happens in the parent
  /// context of current widget.
  ///
  @protected
  void afterWidgetRebind({
    required Widget oldWidget,
    required Widget newWidget,
    required UpdateType updateType,
  }) {}

  /*
  |--------------------------------------------------------------------------
  | BuildContext APIs
  |--------------------------------------------------------------------------
  */

  @override
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    RenderElement? ancestor = _parent;

    var matchType = '$T';

    while (null != ancestor && ancestor.widgetRuntimeType != matchType) {
      ancestor = ancestor._parent;
    }

    return ancestor?.widget as T?;
  }

  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
    RenderElement? ancestor = _parent;

    while (ancestor != null) {
      if (ancestor is StatefulRenderElement && ancestor.state is T) {
        break;
      }

      ancestor = ancestor._parent;
    }

    var statefulAncestor = ancestor as StatefulRenderElement?;

    return statefulAncestor?.state as T?;
  }

  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
    RenderElement? ancestor = _parent;

    StatefulRenderElement? statefulAncestor;

    while (ancestor != null) {
      if (ancestor is StatefulRenderElement && ancestor.state is T) {
        statefulAncestor = ancestor;
      }

      ancestor = ancestor._parent;
    }

    return statefulAncestor?.state as T?;
  }

  @override
  T? findAncestorRenderElementOfExactType<T extends RenderElement>() {
    RenderElement? ancestor = _parent;

    var matchType = '$T';

    while (null != ancestor && '${ancestor.runtimeType}' != matchType) {
      ancestor = ancestor._parent;
    }

    if ('${ancestor.runtimeType}' == matchType) {
      return ancestor as T;
    }

    return null;
  }

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() {
    RenderElement? ancestor = _parent;

    var matchType = '$T';

    while (null != ancestor && ancestor.widgetRuntimeType != matchType) {
      ancestor = ancestor._parent;
    }

    if (null != ancestor && ancestor is InheritedRenderElement) {
      ancestor.addDependent(this);

      return ancestor.widget as T;
    }

    return ancestor?.widget as T?;
  }

  @override
  Element findClosestDomNode() {
    var node = domNode;

    node ??= findClosestDomNodeInDescendants();
    node ??= findClosestDomNodeInAncestors();
    node ??= frameworkServices.rootElement.domNode!;

    return node;
  }

  @override
  Element? findClosestDomNodeInAncestors() {
    var ancestor = _parent;

    while (null != ancestor && !ancestor.hasDomNode) {
      ancestor = ancestor._parent;
    }

    return ancestor?.domNode;
  }

  @override
  Element? findClosestDomNodeInDescendants() {
    var childElements = _childElements;

    while (childElements.isNotEmpty && !childElements.first.hasDomNode) {
      childElements = childElements.first._childElements;
    }

    if (childElements.isEmpty) {
      return null;
    }

    return childElements.first.domNode;
  }

  @override
  void visitAncestorElements(visitor) {
    RenderElement? ancestor = _parent;

    while (null != ancestor && !ancestor.frameworkIsRoot) {
      if (!visitor(ancestor)) break;

      ancestor = ancestor._parent;
    }
  }

  @override
  void visitChildElements(visitor) {
    for (final child in _childElements) {
      if (!visitor(child)) {
        break;
      }
    }
  }

  @override
  void traverseAncestorElements(callback) {
    RenderElement? ancestor = _parent;

    while (null != ancestor && !ancestor.frameworkIsRoot) {
      callback(ancestor);

      ancestor = ancestor._parent;
    }
  }

  @override
  void traverseChildElements(callback) {
    for (final child in _childElements) {
      callback(child);
    }
  }

  @override
  void setMetaInformation({
    required String informationId,
    required MetaInformation information,
  }) {
    Meta.instance.setMetaInformation(
      context: this,
      informationId: informationId,
      information: information,
    );
  }

  @override
  void unsetMetaInformation({required String informationId}) {
    Meta.instance.unsetMetaInformation(
      context: this,
      informationId: informationId,
    );
  }

  /// Register RenderEvent listeners.
  ///
  @protected
  void addRenderEventListeners(
    Map<RenderEventType, RenderEventCallback> listeners,
  ) {
    assert(
      _isInRegistrationPhase,
      'addRenderEventListeners should be called in register()',
    );
    assert(
      !_isEventsRegistered,
      'addRenderEventListeners should be called exactly once',
    );

    frameworkAddRenderEventListeners(listeners);

    _isEventsRegistered = true;
  }

  /*
  |--------------------------------------------------------------------------
  | Below are framework reserved objects & APIs.
  | 
  | Maybe abstract it away in a super class from which then elements can extend 
  | for now, below apis should be avoided by concrete elements.
  |--------------------------------------------------------------------------
  */

  /// Whether execution of [RenderElement.register] is pending.
  ///
  var _isInRegistrationPhase = true;

  /// Whether addRenderEventListeners has been called.
  ///
  var _isEventsRegistered = false;

  /// @nodoc
  @nonVirtual
  @internal
  bool get frameworkIsRoot => _isRoot;
  final bool _isRoot;

  /// Services instance.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  Services get frameworkServices => _services!;
  Services? _services;

  /// Parent's element.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  RenderElement? get frameworkParent => _parent;
  RenderElement? _parent;

  /// Child elements.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  List<RenderElement> get frameworkChildElements => _childElements;
  final _childElements = <RenderElement>[];

  /*
  |--------------------------------------------------------------------------
  | framework reserved | RenderEvents APIs
  |--------------------------------------------------------------------------
  */

  var _eventListeners = const <RenderEventType, RenderEventCallback>{};

  /// @nodoc
  @internal
  @nonVirtual
  Map<RenderEventType, RenderEventCallback> get frameworkRenderEventListeners {
    return _eventListeners;
  }

  /// @nodoc
  @internal
  @nonVirtual
  bool frameworkHasEventListenerOfType(RenderEventType type) {
    return _eventListeners.containsKey(type);
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAddRenderEventListeners(
    Map<RenderEventType, RenderEventCallback> listeners,
  ) {
    _eventListeners = listeners;

    if (_eventListeners.containsKey(RenderEventType.didUnMount) ||
        _eventListeners.containsKey(RenderEventType.willUnMount)) {
      frameworkAnnounceUnMountListeners();
    }
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkDispatchRenderEvent(RenderEventType renderEventType) {
    if (_eventListeners.isEmpty) {
      return;
    }

    var listener = _eventListeners[renderEventType];
    if (null != listener) {
      listener(const RenderEvent());
    }
  }

  /*
  |--------------------------------------------------------------------------
  | framework reserved | event announce APIs
  |--------------------------------------------------------------------------
  */

  /// Whether this part of tree contains any un-mount event listener.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  bool get frameworkContainsUnMountListeners => _containsUnMountListeners;
  var _containsUnMountListeners = false;

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAnnounceUnMountListeners() {
    // we aren't using traverseAncestors here because
    // it doesn't traverse the root element(the big bang one)
    // but a root element can have descendants widgets that are
    // listening for unmount events.

    var ancestor = _parent;
    while (null != ancestor) {
      if (ancestor.frameworkContainsUnMountListeners) {
        return;
      }

      ancestor._containsUnMountListeners = true;
      ancestor = ancestor._parent;
    }
  }

  /*
  |--------------------------------------------------------------------------
  | framework reserved | dom node APIs
  |--------------------------------------------------------------------------
  */

  /// Whether this [RenderElement] has any virtual dom nodes.
  ///
  /// Please note, virtual node in Rad are different from React's.
  ///
  /// A Virtual Dom Node in Rad is a node that is mounted at the location of
  /// this [RenderElement] but is created and controlled by one of widgets in
  /// the descendants of this [RenderElement].
  ///
  /// For example, a [StatefulWidget] doesn't have a corresponding dom node
  /// but you can return a [Span] widget(that has a corresponding dom node)
  /// from [State.build] and framework will mount it at [StatefulWidget]'s
  /// location. In this example, [StatefulWidget] has one virtual dom
  /// node which currently is filled by the [Span] widget.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  bool get frameworkContainsVirtualDomNodes => 0 < _virtualDomNodesCount;

  /// The number of virtual dom nodes mounted at the location of this
  /// [RenderElement].
  ///
  /// See [RenderElement.frameworkContainsVirtualDomNodes].
  ///
  /// @nodoc
  @internal
  @nonVirtual
  int get frameworkVirtualDomNodesCount => _virtualDomNodesCount;
  var _virtualDomNodesCount = 0;

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAnnounceDomNode() {
    assert(null != _domNode, 'No domNode to be announced');

    if (_parent?.hasDomNode ?? false) return;

    var ancestor = _parent;
    while (null != ancestor) {
      if (ancestor.hasDomNode) {
        return;
      }

      ancestor._virtualDomNodesCount++;
      ancestor = ancestor._parent;
    }
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkWithdrawDomNode() {
    assert(null != _domNode, 'No domNode to be withdrawn');

    if (_parent?.hasDomNode ?? false) return;

    var ancestor = _parent;
    while (null != ancestor) {
      if (ancestor.hasDomNode) {
        return;
      }

      ancestor._virtualDomNodesCount--;
      ancestor = ancestor._parent;
    }
  }

  /*
  |--------------------------------------------------------------------------
  | framework reserved | lifecycle api
  |--------------------------------------------------------------------------
  */

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAttachServices({
    required Services services,
  }) {
    assert(null == _services, 'Services are already bound');

    _services = services;
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkBindDomNode({
    required Element domNode,
  }) {
    assert(null == _domNode, 'DomNode is already bound');

    _domNode = domNode;
    _hasDomNode = true;
    frameworkAnnounceDomNode();
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkInitRenderElement() {
    assert(_isInRegistrationPhase, 'RenderElement already registered');

    register();
    _isInRegistrationPhase = false;
  }

  /// The framework calls this method before detaching this [RenderElement].
  ///
  /// Please note, this method gets called at most one time, not exactly one
  /// time. The framework might decide not to call this method when this
  /// [RenderElement] has child nodes that doesn't require any disposals.
  ///
  /// See [Renderer.disposeRenderElement] for more information.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  void frameworkDisposeRenderElement() {
    if (hasDomNode) {
      frameworkWithdrawDomNode();
    }
  }

  /// @nodoc
  @internal
  @nonVirtual
  DomNodePatch? frameworkRender({required Widget widget}) {
    return render(widget: widget);
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkRebindWidget({
    required Widget oldWidget,
    required Widget newWidget,
    required UpdateType updateType,
  }) {
    _widget = newWidget;

    afterWidgetRebind(
      oldWidget: oldWidget,
      newWidget: newWidget,
      updateType: updateType,
    );
  }

  /// @nodoc
  @internal
  @nonVirtual
  DomNodePatch? frameworkUpdate({
    required UpdateType updateType,
    required Widget oldWidget,
    required Widget newWidget,
  }) {
    return update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );
  }

  /*
  |--------------------------------------------------------------------------
  | framework reserved | tree api
  |--------------------------------------------------------------------------
  */

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkInsertAt(RenderElement element, int? index) {
    element.frameworkDetach();

    if (null != index && index > -1 && _childElements.length > index) {
      _childElements.insert(index, element);
    } else {
      _childElements.add(element);
    }

    element._parent = this;
  }

  /// @nodoc
  @internal
  @nonVirtual
  void frameworkInsertAtFreshUnsafeFastPath(RenderElement element, int index) {
    _childElements.insert(index, element);
    element._parent = this;
  }

  /// Detach render element from its parent(if any).
  ///
  /// @nodoc
  @internal
  @nonVirtual
  void frameworkDetach() {
    if (null != _parent) {
      _parent!.frameworkRemoveChild(this);
    }

    _parent = null;
  }

  /// Remove a child element.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  void frameworkRemoveChild(RenderElement element) {
    _childElements.remove(element);

    element._parent = null;
  }

  /// Fast path for appending a render element given that element is freshly
  /// created(doesn't have a dependent parent element).
  ///
  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAppendFresh(RenderElement element) {
    element._parent = this;

    _childElements.add(element);
  }

  /// Fast path for appending multiple render elements given that elements are
  /// freshly created(doesn't have a dependent parent element).
  ///
  /// @nodoc
  @internal
  @nonVirtual
  void frameworkAppendAllFresh(Iterable<RenderElement> elements) {
    for (final element in elements) {
      element._parent = this;
    }

    _childElements.addAll(elements);
  }

  /// Fast path for inserting multiple render elements given that elements are
  /// freshly created(doesn't have a dependent parent element).
  ///
  /// @nodoc
  @internal
  @nonVirtual
  void frameworkInsertAllFreshAt(Iterable<RenderElement> elements, int? index) {
    for (final element in elements) {
      element._parent = this;
    }

    if (null != index && index > -1 && _childElements.length > index) {
      _childElements.insertAll(index, elements);
    } else {
      _childElements.addAll(elements);
    }
  }

  /// Eject all child elements of current element.
  ///
  /// This process moves all child elements to a iterable and return.
  ///
  /// @nodoc
  @internal
  @nonVirtual
  @tryInline
  Iterable<RenderElement> frameworkEjectChildRenderElements() {
    if (_childElements.isEmpty) {
      return const [];
    }

    var ejectedRenderElements = <RenderElement>[];
    while (_childElements.isNotEmpty) {
      ejectedRenderElements.add(_childElements.removeLast().._parent = null);
    }

    return ejectedRenderElements.reversed;
  }

  @override
  String toString() => '$runtimeType of $widgetRuntimeType(widget)';
}
