import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/division.dart';
import 'package:rad/src/widgets/utils/common_props.dart';
import 'package:rad/src/core/common/objects/key.dart';

/// Creates a scrollable, linear array of widgets from an explicit [List].
///
class ListView extends Widget {
  /// The style attribute for inline CSS.
  ///
  final String? style;

  /// The classes attribute specifies one or more class names for an element.
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
  get widgetChildren => children;

  @nonVirtual
  @override
  get widgetType => "$ListView";

  @nonVirtual
  @override
  get correspondingTag => DomTag.division;

  @nonVirtual
  @override
  createConfiguration() {
    var configuration = _ListViewConfiguration(
      style: style,
      layoutType: layoutType,
      classAttribute: classAttribute,
      scrollDirection: scrollDirection,
    );

    if (isListViewBuilder) {
      return _ListViewBuilderConfiguration(
        itemCount: itemCount,
        itemBuilder: itemBuilder!,
        baseConfiguration: configuration,
      );
    }

    return configuration;
  }

  @nonVirtual
  @override
  isConfigurationChanged(oldConfiguration) {
    if (isListViewBuilder) {
      return true;
    }

    oldConfiguration as _ListViewConfiguration;

    return style != oldConfiguration.style ||
        layoutType != oldConfiguration.layoutType ||
        classAttribute != oldConfiguration.classAttribute ||
        scrollDirection != oldConfiguration.scrollDirection;
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
| configuration
|--------------------------------------------------------------------------
*/

class _ListViewConfiguration extends WidgetConfiguration {
  final String? style;
  final String? classAttribute;

  final LayoutType layoutType;
  final Axis scrollDirection;

  const _ListViewConfiguration({
    this.style,
    this.classAttribute,
    required this.layoutType,
    required this.scrollDirection,
  });
}

/*
|--------------------------------------------------------------------------
| configuration for builder version
|--------------------------------------------------------------------------
*/

class _ListViewBuilderConfiguration extends WidgetConfiguration {
  final _ListViewConfiguration baseConfiguration;

  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const _ListViewBuilderConfiguration({
    this.itemCount,
    required this.itemBuilder,
    required this.baseConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class ListViewRenderObject extends RenderObject {
  const ListViewRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _ListViewConfiguration configuration,
  ) {
    _ListViewProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _ListViewConfiguration oldConfiguration,
    required covariant _ListViewConfiguration newConfiguration,
  }) {
    _ListViewProps.clear(element, oldConfiguration);
    _ListViewProps.apply(element, newConfiguration);
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
  render(
    element,
    covariant _ListViewBuilderConfiguration configuration,
  ) {
    _ListViewProps.apply(element, configuration.baseConfiguration);

    var layoutType = configuration.baseConfiguration.layoutType;

    state
      ..frameworkBindLayoutType(layoutType)
      ..frameworkUpdateConfigurationBinding(configuration)
      ..frameworkUpdateElementBinding(element)
      ..frameworkRender();
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _ListViewBuilderConfiguration oldConfiguration,
    required covariant _ListViewBuilderConfiguration newConfiguration,
  }) {
    var newBaseConfig = newConfiguration.baseConfiguration;
    var oldBaseConfig = oldConfiguration.baseConfiguration;

    if (newBaseConfig.style != oldBaseConfig.style ||
        newBaseConfig.classAttribute != oldBaseConfig.classAttribute ||
        newBaseConfig.scrollDirection != oldBaseConfig.scrollDirection) {
      _ListViewProps.clear(element, oldConfiguration.baseConfiguration);
      _ListViewProps.apply(element, newConfiguration.baseConfiguration);
    }

    state
      ..frameworkUpdateConfigurationBinding(newConfiguration)
      ..frameworkUpdate(updateType);
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

  HtmlElement? _element;
  HtmlElement get element => _element!;

  LayoutType _layoutType = LayoutType.contain;

  _ListViewBuilderConfiguration? _configuration;
  _ListViewBuilderConfiguration get configuration => _configuration!;

  int get renderUptoIndex {
    var itemCount = configuration.itemCount;

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
            'root': element,
          }
        : {};

    _observer = IntersectionObserver(_intersectionHandler, options);
  }

  void _intersectionHandler(
    List entries,
    IntersectionObserver observer,
  ) {
    for (var entry in entries) {
      entry as IntersectionObserverEntry;

      if (entry.isIntersecting ?? false) {
        var currentIndex = _renderableUptoIndex;

        _renderableUptoIndex += 3;

        var itemsToGenerate = renderUptoIndex - currentIndex;

        if (itemsToGenerate > 0) {
          services.scheduler.addTask(
            WidgetsUpdateTask(
              parentContext: context,
              updateType: UpdateType.lazyBuild,
              flagAddIfNotFound: true,
              widgets: List.generate(
                itemsToGenerate,
                (i) => Division(
                  key: Key('lv_item_${i + currentIndex}_${context.key.value}'),
                  classAttribute: 'rad-list-view-item-container',
                  child: configuration.itemBuilder(context, i + currentIndex),
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

    if (element.children.length > 3) {
      lastItemContainer = element.children[element.children.length - 3];
    } else {
      lastItemContainer =
          element.children.isNotEmpty ? element.children.last : null;
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
            classAttribute: 'rad-list-view-item-container',
            child: configuration.itemBuilder(context, i),
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
            classAttribute: 'rad-list-view-item-container',
            child: configuration.itemBuilder(context, i),
          ),
        ),
        afterTaskCallback: _updateObserverTarget,
      ),
    );
  }

  void frameworkUpdateConfigurationBinding(
    _ListViewBuilderConfiguration configuration,
  ) {
    _configuration = configuration;
  }

  void frameworkUpdateElementBinding(HtmlElement element) {
    _element = element;
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

class _ListViewProps {
  static void apply(HtmlElement element, _ListViewConfiguration props) {
    CommonProps.applyClassAttribute(element, props.classAttribute);

    switch (props.layoutType) {
      case LayoutType.contain:
        element.classes.add('rad-list-view-layout-contain');

        break;
      case LayoutType.expand:
        element.classes.add('rad-list-view-layout-expand');

        break;
    }

    if (null != props.style) {
      element.setAttribute(_Attributes.style, props.style!);
    }

    if (Axis.vertical == props.scrollDirection) {
      element.style.overflowX = 'hidden';
      element.style.overflowY = 'auto';

      element.style.flexDirection = 'column';
    } else {
      element.style.overflowX = 'auto';
      element.style.overflowY = 'hidden';

      element.style.flexDirection = 'row';
    }
  }

  static void clear(HtmlElement element, _ListViewConfiguration props) {
    CommonProps.clearClassAttribute(element, props.classAttribute);

    if (null != props.style) {
      element.removeAttribute(_Attributes.style);
    }
  }
}

class _Attributes {
  static const style = "style";
}
