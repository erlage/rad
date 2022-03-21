import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';

import 'package:rad/src/core/types.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/division.dart';

/// Creates a linear array of widgets that are created on demand.
///
/// This widget is appropriate for list views with a large (or infinite)
/// number of children.
///
class LazyBuilder extends Widget {
  /// Number of items to build.
  ///
  final int itemCount;

  /// Items Builder.
  ///
  final LazyItemBuilderCallback builder;

  const LazyBuilder({
    String? key,
    required this.itemCount,
    required this.builder,
  }) : super(key: key);

  @nonVirtual
  @override
  get concreteType => "$LazyBuilder";

  @nonVirtual
  @override
  get correspondingTag => DomTag.division;

  @nonVirtual
  @override
  createConfiguration() => _LazyBuilderConfiguration(itemCount, builder);

  @nonVirtual
  @override
  isConfigurationChanged(oldConfiguration) => true;

  @nonVirtual
  @override
  createRenderObject(context) => LazyBuilderRenderObject(
        context,
        _LazyBuilderState(),
      );
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _LazyBuilderConfiguration extends WidgetConfiguration {
  final int itemCount;
  final LazyItemBuilderCallback builder;

  const _LazyBuilderConfiguration(this.itemCount, this.builder);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class LazyBuilderRenderObject extends RenderObject {
  final _LazyBuilderState state;

  const LazyBuilderRenderObject(
    BuildContext context,
    this.state,
  ) : super(context);

  @override
  render(element, covariant _LazyBuilderConfiguration configuration) {
    state
      ..frameworkUpdateConfigurationBinding(configuration)
      ..frameworkUpdateContextBinding(context)
      ..frameworkUpdateElementBinding(element)
      ..frameworkRender();
  }

  @override
  update({
    required element,
    required updateType,
    required oldConfiguration,
    required covariant _LazyBuilderConfiguration newConfiguration,
  }) {
    state
      ..frameworkUpdateConfigurationBinding(newConfiguration)
      ..frameworkUpdate(updateType);
  }

  @override
  beforeUnMount() => state.frameworkDispose();
}

/*
|--------------------------------------------------------------------------
| Lazy builder state
|--------------------------------------------------------------------------
*/

class _LazyBuilderState {
  /*
  |--------------------------------------------------------------------------
  | internal state
  |--------------------------------------------------------------------------
  */

  int _renderableUptoIndex = 3;

  HtmlElement? _observerTarget;

  late final IntersectionObserver _observer;

  /*
  |--------------------------------------------------------------------------
  | getters
  |--------------------------------------------------------------------------
  */

  BuildContext? _context;
  BuildContext get context => _context!;

  HtmlElement? _element;
  HtmlElement get element => _element!;

  _LazyBuilderConfiguration? _configuration;
  _LazyBuilderConfiguration get configuration => _configuration!;

  int get renderUptoIndex {
    if (_renderableUptoIndex > configuration.itemCount) {
      return configuration.itemCount;
    }

    return _renderableUptoIndex;
  }

  /*
  |--------------------------------------------------------------------------
  | intersection utils
  |--------------------------------------------------------------------------
  */

  void _initObserver() {
    _observer = IntersectionObserver(_intersectionHandler);
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
          Framework.updateChildren(
            widgets: List.generate(
              itemsToGenerate,
              (i) => Division(
                key: 'lazy_item_${i + currentIndex}_under_${context.key}',
                style: 'display: contents',
                child: configuration.builder(i + currentIndex),
              ),
            ),
            parentContext: context,
            flagAddIfNotFound: true,
            flagAddAsAppendMode: true,
            flagHideObsoluteChildren: false,
            flagDisposeObsoluteChildren: false,
            updateType: UpdateType.lazyBuild,
          );

          _updateObserverTarget();
        }
      }
    }
  }

  void _updateObserverTarget() {
    // remove previous

    if (null != _observerTarget) {
      _observer.unobserve(_observerTarget!);

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

        _observer.observe(child);

        _observerTarget = child as HtmlElement;
      }
    }
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  void frameworkRender() {
    _initObserver();

    Framework.buildChildren(
      widgets: List.generate(
        renderUptoIndex,
        (i) => Division(
          key: 'lazy_item_${i}_under_${context.key}',
          style: 'display: contents',
          child: configuration.builder(i),
        ),
      ),
      parentContext: context,
    );

    _updateObserverTarget();
  }

  void frameworkUpdate(UpdateType updateType) {
    Framework.updateChildren(
      widgets: List.generate(
        renderUptoIndex,
        (i) => Division(
          key: 'lazy_item_${i}_under_${context.key}',
          style: 'display: contents',
          child: configuration.builder(i),
        ),
      ),
      parentContext: context,
      updateType: updateType,
    );

    _updateObserverTarget();
  }

  void frameworkUpdateConfigurationBinding(
      _LazyBuilderConfiguration configuration) {
    _configuration = configuration;
  }

  void frameworkUpdateContextBinding(BuildContext context) {
    _context = context;
  }

  void frameworkUpdateElementBinding(HtmlElement element) {
    _element = element;
  }

  void frameworkDispose() {
    if (null != _observerTarget) {
      _observer.unobserve(_observerTarget!);
    }

    _observer.disconnect();
  }
}
