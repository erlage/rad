import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_registry.dart';
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

  @override
  List<Widget> get widgetChildren => children;

  @nonVirtual
  @override
  String get widgetType => 'ListView';

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

  @nonVirtual
  @override
  createRenderObject(context) {
    if (isListViewBuilder) {
      return ListViewBuilderRenderObject(
        context: context,
        state: _ListViewBuilderState(context),
      );
    }

    return ListViewRenderObject(context);
  }
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class ListViewRenderObject extends RenderObject {
  const ListViewRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant ListView widget,
  }) {
    return DomNodeDescription(
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
    return DomNodeDescription(
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

class ListViewBuilderRenderObject extends RenderObject {
  final _ListViewBuilderState state;

  const ListViewBuilderRenderObject({
    required this.state,
    required BuildContext context,
  }) : super(context);

  @override
  render({
    required covariant ListView widget,
  }) {
    state
      ..frameworkBindLayoutType(widget.layoutType)
      ..frameworkBindWidget(widget);

    return DomNodeDescription(
      attributes: _prepareAttributes(
        widget: widget,
        oldWidget: null,
      ),
    );
  }

  @override
  afterMount() {
    var services = ServicesRegistry.instance.getServices(context);
    var domNode = services.walker.getWidgetObject(context)!.domNode;

    if (null == domNode) {
      services.debug.exception(Constants.coreError);
    } else {
      state
        ..frameworkRebindDomNode(domNode)
        ..frameworkRender();
    }
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
      return DomNodeDescription(
        attributes: _prepareAttributes(
          widget: newWidget,
          oldWidget: oldWidget,
        ),
      );
    }

    return null;
  }

  @override
  beforeUnMount() => state.frameworkDispose();
}

/*
|--------------------------------------------------------------------------
| list view builder state
|--------------------------------------------------------------------------
*/

class _ListViewBuilderState with ServicesResolver {
  /*
  |--------------------------------------------------------------------------
  | internal state
  |--------------------------------------------------------------------------
  */

  final BuildContext context;

  int _renderableUptoIndex = 3;

  HtmlElement? _observerTarget;

  IntersectionObserver? _observer;

  /// Resolve services reference.
  ///
  Services get services => resolveServices(context);

  /*
  |--------------------------------------------------------------------------
  | constructor
  |--------------------------------------------------------------------------
  */

  _ListViewBuilderState(this.context);

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

  int get renderUptoIndex {
    var itemCount = widget.itemCount;

    if (null != itemCount && _renderableUptoIndex > itemCount) {
      return itemCount;
    }

    return _renderableUptoIndex;
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
        var currentIndex = _renderableUptoIndex;

        _renderableUptoIndex += 3;

        var itemsToGenerate = renderUptoIndex - currentIndex;

        if (itemsToGenerate > 0) {
          services.scheduler.addTask(
            WidgetsBuildTask(
              parentContext: context,
              mountAtIndex: null,
              flagCleanParentContents: false,
              widgets: List.generate(
                itemsToGenerate,
                (i) => Division(
                  key: Key('lv_item_${i + currentIndex}_${context.key.value}'),
                  classAttribute: Constants.classListViewItemContainer,
                  child: widget.itemBuilder!(context, i + currentIndex),
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
  | internals
  |--------------------------------------------------------------------------
  */

  void frameworkBindLayoutType(LayoutType layoutType) {
    _layoutType = layoutType;
  }

  void frameworkRender() {
    _initObserver();

    services.scheduler.addTask(
      WidgetsBuildTask(
        parentContext: context,
        widgets: List.generate(
          renderUptoIndex,
          (i) => Division(
            key: Key('lv_item_${i}_${context.key.value}'),
            classAttribute: Constants.classListViewItemContainer,
            child: widget.itemBuilder!(context, i),
          ),
        ),
        afterTaskCallback: _updateObserverTarget,
      ),
    );
  }

  void frameworkUpdate(UpdateType updateType) {
    services.scheduler.addTask(
      WidgetsUpdateTask(
        parentContext: context,
        updateType: updateType,
        widgets: List.generate(
          renderUptoIndex,
          (i) => Division(
            key: Key('lv_item_${i}_${context.key.value}'),
            classAttribute: Constants.classListViewItemContainer,
            child: widget.itemBuilder!(context, i),
          ),
        ),
        afterTaskCallback: _updateObserverTarget,
      ),
    );
  }

  void frameworkBindWidget(ListView widget) {
    if (null != _widget) {
      throw Exception(Constants.coreError);
    }

    _widget = widget;
  }

  void frameworkRebindWidget(ListView widget) {
    _widget = widget;
  }

  void frameworkRebindDomNode(Element domNode) {
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
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required ListView widget,
  required ListView? oldWidget,
}) {
  var attributes = <String, String?>{};

  var classAttribute = fnCommonPrepareClassAttribute(
        classAttribute: '${widget.classAttribute}',
        oldClassAttribute: null, // not required, new attribute is always set
      ) ??
      '';

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
    classAttribute += ' ${Constants.classListViewVeritcal}';
  }

  attributes[Attributes.classAttribute] = classAttribute;

  return attributes;
}
