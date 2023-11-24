// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/abstract/watchful_render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/division.dart';

/// Creates a scrollable, linear array of widgets from an explicit [List].
///
class ListView extends Widget {
  /// The style attribute for inline CSS.
  ///
  final String? style;

  /// The classes attribute specifies one or more class names for dom node.
  ///
  final String? classAttribute;

  /// Scroll direction of ListView.
  ///
  final Axis scrollDirection;

  /// Child widgets(will be built all at once).
  ///
  final List<Widget> children;

  /// Type of list view layout.
  ///
  final LayoutType layoutType;

  const ListView({
    Key? key,
    this.style,
    this.classAttribute,
    this.layoutType = LayoutType.contain,
    this.scrollDirection = Axis.vertical,
    required this.children,
  })  : isListViewBuilder = false,
        itemCount = null,
        itemBuilder = null,
        super(key: key);

  /// Whether list is a Lazy builder.
  ///
  final bool isListViewBuilder;

  final int? itemCount;

  final IndexedWidgetBuilder? itemBuilder;

  /// Creates a scrollable, linear array of widgets that are created on demand.
  ///
  /// This constructor is appropriate for list views with a large (or infinite)
  /// number of children.
  ///
  const ListView.builder({
    Key? key,
    this.style,
    this.classAttribute,
    this.layoutType = LayoutType.contain,
    this.scrollDirection = Axis.vertical,
    this.itemCount,
    required this.itemBuilder,
  })  : isListViewBuilder = true,
        children = const <Widget>[],
        super(key: key);

  @nonVirtual
  @override
  DomTagType get correspondingTag => DomTagType.division;

  @nonVirtual
  @override
  bool shouldUpdateWidget(covariant ListView oldWidget) {
    if (isListViewBuilder) {
      return true;
    }

    return style != oldWidget.style ||
        layoutType != oldWidget.layoutType ||
        classAttribute != oldWidget.classAttribute ||
        scrollDirection != oldWidget.scrollDirection;
  }

  @override
  shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) =>
      !isListViewBuilder;

  @nonVirtual
  @override
  createRenderElement(parent) {
    if (isListViewBuilder) {
      return ListViewBuilderRenderElement(this, parent);
    }

    return ListViewRenderElement(this, parent);
  }
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// ListView render element.
///
class ListViewRenderElement extends RenderElement {
  ListViewRenderElement(super.widget, super.parent);

  @override
  List<Widget> get widgetChildren => (widget as ListView).children;

  @override
  render({
    required covariant ListView widget,
  }) {
    return DomNodePatch(
      attributes: _prepareAttributes(
        widget: widget,
        oldWidget: null,
      ),
    );
  }

  @override
  update({
    required updateType,
    required covariant ListView oldWidget,
    required covariant ListView newWidget,
  }) {
    return DomNodePatch(
      attributes: _prepareAttributes(
        widget: newWidget,
        oldWidget: oldWidget,
      ),
    );
  }
}

/*
|--------------------------------------------------------------------------
| render object for builder version
|--------------------------------------------------------------------------
*/

/// List view render element for builder version.
///
@internal
class ListViewBuilderRenderElement extends WatchfulRenderElement {
  /// List view builder state.
  ///
  final _ListViewBuilderState state;

  ListViewBuilderRenderElement(
    ListView widget,
    RenderElement parent,
  )   : state = _ListViewBuilderState(),
        super(widget, parent);

  @override
  List<Widget> get widgetChildren => ccImmutableEmptyListOfWidgets;

  @override
  init() {
    state
      ..frameworkUpdateLayoutTypeBinding((widget as ListView).layoutType)
      ..frameworkBindWidget(widget);
  }

  @override
  render({
    required covariant ListView widget,
  }) {
    return DomNodePatch(
      attributes: _prepareAttributes(
        widget: widget,
        oldWidget: null,
      ),
    );
  }

  @override
  afterMount() {
    state
      ..frameworkBindRenderElement(this)
      ..frameworkBindDomNode(domNode!)
      ..frameworkRender();
  }

  @override
  update({
    required updateType,
    required covariant ListView oldWidget,
    required covariant ListView newWidget,
  }) {
    state
      ..frameworkRebindWidget(newWidget)
      ..frameworkUpdate(updateType);

    if (newWidget.style != oldWidget.style ||
        newWidget.classAttribute != oldWidget.classAttribute ||
        newWidget.scrollDirection != oldWidget.scrollDirection) {
      return DomNodePatch(
        attributes: _prepareAttributes(
          widget: newWidget,
          oldWidget: oldWidget,
        ),
      );
    }

    return null;
  }

  @override
  afterUnMount() => state.frameworkDispose();
}

/*
|--------------------------------------------------------------------------
| list view builder state
|--------------------------------------------------------------------------
*/

/// List View builder state.
///
class _ListViewBuilderState with ServicesResolver {
  /*
  |--------------------------------------------------------------------------
  | internal state
  |--------------------------------------------------------------------------
  */

  RenderElement? _element;

  BuildContext get context => _element!;

  int _renderAbleUpToIndex = 3;

  HtmlElement? _observerTarget;

  IntersectionObserver? _observer;

  /// Resolve services reference.
  ///
  Services get services => resolveServices(context);

  /*
  |--------------------------------------------------------------------------
  | getters
  |--------------------------------------------------------------------------
  */

  Element? _domNode;
  Element get domNode => _domNode!;

  ListView? _widget;
  ListView get widget => _widget!;

  LayoutType _layoutType = LayoutType.contain;

  int get renderUpToIndex {
    var itemCount = widget.itemCount;

    if (null != itemCount && _renderAbleUpToIndex > itemCount) {
      return itemCount;
    }

    return _renderAbleUpToIndex;
  }

  /*
  |--------------------------------------------------------------------------
  | intersection utils
  |--------------------------------------------------------------------------
  */

  void _initObserver() {
    var options = LayoutType.contain == _layoutType
        ? {
            'root': domNode,
          }
        : <dynamic, dynamic>{};

    _observer = IntersectionObserver(_intersectionHandler, options);
  }

  void _intersectionHandler(
    List<dynamic> entries,
    IntersectionObserver observer,
  ) {
    for (final entry in entries) {
      entry as IntersectionObserverEntry;

      if (entry.isIntersecting ?? false) {
        var currentIndex = _renderAbleUpToIndex;

        _renderAbleUpToIndex += 3;

        var itemsToGenerate = renderUpToIndex - currentIndex;

        if (itemsToGenerate > 0) {
          services.scheduler.addTask(
            WidgetsBuildTask(
              parentRenderElement: _element!,
              mountAtIndex: null,
              flagCleanParentContents: false,
              widgets: List.generate(
                itemsToGenerate,
                (i) => Division(
                  key: Key('lv_item_${i + currentIndex}_${context.key}'),
                  className: Constants.classListViewItemContainer,
                  children: [
                    widget.itemBuilder!(context, i + currentIndex),
                  ],
                ),
              ),
              afterTaskCallback: _updateObserverTarget,
            ),
          );
        }
      }
    }
  }

  void _updateObserverTarget() {
    // remove previous

    if (null != _observerTarget) {
      _observer?.unobserve(_observerTarget!);

      _observerTarget = null;
    }

    Element? lastItemContainer;

    var childLength = domNode.children.length;

    if (childLength > 3) {
      lastItemContainer = domNode.children[childLength - 3];
    } else {
      lastItemContainer = childLength > 0 ? domNode.children.last : null;
    }

    if (null != lastItemContainer) {
      Element? child;

      if (lastItemContainer.children.isNotEmpty) {
        child = lastItemContainer.children.first;

        _observer?.observe(child);

        _observerTarget = child as HtmlElement;
      }
    }
  }

  /*
  |--------------------------------------------------------------------------
  | framework reserved api
  |--------------------------------------------------------------------------
  */

  void frameworkUpdateLayoutTypeBinding(LayoutType layoutType) {
    _layoutType = layoutType;
  }

  void frameworkRender() {
    _initObserver();

    services.scheduler.addTask(
      WidgetsBuildTask(
        parentRenderElement: _element!,
        widgets: List.generate(
          renderUpToIndex,
          (i) => Division(
            key: Key('lv_item_${i}_${context.key}'),
            className: Constants.classListViewItemContainer,
            children: [
              widget.itemBuilder!(context, i),
            ],
          ),
        ),
        afterTaskCallback: _updateObserverTarget,
      ),
    );
  }

  void frameworkUpdate(UpdateType updateType) {
    services.scheduler.addTask(
      WidgetsUpdateTask(
        parentRenderElement: _element!,
        updateType: updateType,
        widgets: List.generate(
          renderUpToIndex,
          (i) => Division(
            key: Key('lv_item_${i}_${context.key}'),
            className: Constants.classListViewItemContainer,
            children: [
              widget.itemBuilder!(context, i),
            ],
          ),
        ),
        afterTaskCallback: _updateObserverTarget,
      ),
    );
  }

  void frameworkBindWidget(Widget widget) {
    assert(null == _widget, 'Widget is already bound');

    _widget = widget as ListView;
  }

  void frameworkBindRenderElement(RenderElement element) {
    assert(null == _element, 'RenderElement is already bound');

    _element = element;
  }

  void frameworkRebindWidget(ListView widget) {
    assert(null != _widget, 'Widget is not bound yet');

    _widget = widget;
  }

  void frameworkBindDomNode(Element domNode) {
    assert(null == _domNode, 'DomNode is already bound');

    _domNode = domNode;
  }

  void frameworkDispose() {
    if (null != _observerTarget) {
      _observer?.unobserve(_observerTarget!);
    }

    _observer?.disconnect();
  }
}

/*
|--------------------------------------------------------------------------
| patch
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required ListView widget,
  required ListView? oldWidget,
}) {
  var attributes = <String, String?>{};
  var classAttribute = widget.classAttribute ?? '';

  classAttribute += ' ${Constants.classListView}';

  if (LayoutType.contain == widget.layoutType) {
    classAttribute += ' ${Constants.classListViewContained}';
  }

  if (LayoutType.expand == widget.layoutType) {
    classAttribute += ' ${Constants.classListViewExpanded}';
  }

  if (Axis.horizontal == widget.scrollDirection) {
    classAttribute += ' ${Constants.classListViewHorizontal}';
  }

  if (Axis.vertical == widget.scrollDirection) {
    classAttribute += ' ${Constants.classListViewVertical}';
  }

  attributes[Attributes.className] = classAttribute;

  return attributes;
}
