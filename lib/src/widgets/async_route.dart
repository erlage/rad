import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';
import 'package:rad/src/widgets/route.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// [Navigator]'s AsyncRoute.
///
/// AsyncRoute allows using async-await in page controllers which can be used
/// to do deferred imports or build widgets that requires async computation.
///
/// ### Example:
///
/// ```dart
/// import 'package:something/aPage.dart' deferred as aPage;
///
/// Navigator(
///   routes: [
///     // asynchronous route
///
///     AsyncRoute(
///       name: 'home',
///       page: () async {
///         await aPage.loadLibrary();
///
///         return aPage.SomeWidget();
///       }
///     ),
///
///     // synchronous route
//
///     Route(name: 'profile', ...),
///
///     // you can mix async routes with synchronous routes
///
///     AsyncRoute(name: 'settings', ...),
///
///     Route(name: 'info', ...),
///   ]
/// )
/// ```
/// See also:
///
///  * [Route], for synchronous routes.
///
class AsyncRoute extends Route {
  /// Name of the route to open when page loading encounters an error.
  ///
  /// This is optional, if you don't define a [errorRoute], framework will show
  /// a blank widget which you can override by providing your own widget
  /// in [errorPlaceholderWidget].
  ///
  final String? errorRoute;

  /// Name of the route to open while page is loading.
  ///
  /// This is optional, if you don't define a [waitingRoute], framework will
  /// show a blank widget which you can override by providing your own widget
  /// in [waitingPlaceholderWidget].
  ///
  final String? waitingRoute;

  /// Whether to rebind builder(page) on updates.
  ///
  final bool keepInitialBuilder;

  /// Whether to retry a failed page if user re-opens.
  ///
  final bool retryFailedBuilder;

  /// Whether to log error route in history.
  ///
  final bool enableErrorHistory;

  ///  Whether to log waiting route in history.
  ///
  final bool enableWaitingHistory;

  /// Async Page builder.
  ///
  final AsyncWidgetBuilderCallback builder;

  /// Placeholder widget to show while page is loading.
  ///
  /// Note, if [waitingRoute] is set, framework will open that route instead of
  /// showing a placeholder widget.
  ///
  final Widget waitingPlaceholderWidget;

  /// Placeholder widget to show when page loading has failed.
  ///
  /// Note, if [errorRoute] is set, framework will open that route instead of
  /// showing a placeholder widget.
  ///
  final Widget errorPlaceholderWidget;

  /// Create AsyncRoute with [name], and associate route with [page] builder.
  ///
  AsyncRoute({
    Key? key,
    this.errorRoute,
    this.waitingRoute,
    this.keepInitialBuilder = true,
    this.retryFailedBuilder = false,
    this.enableErrorHistory = false,
    this.enableWaitingHistory = false,
    this.errorPlaceholderWidget = const _AsyncRoutePlaceholder(),
    this.waitingPlaceholderWidget = const _AsyncRoutePlaceholder(),
    String? path,
    required String name,
    required AsyncWidgetBuilderCallback page,
  })  : builder = page,
        super(
          key: key,
          name: name,
          path: path,
          page: _AsyncRouteBuilder(
            name: name,
            builder: page,
            errorRoute: errorRoute,
            waitingRoute: waitingRoute,
            keepInitialBuilder: keepInitialBuilder,
            retryFailedBuilder: retryFailedBuilder,
            enableErrorHistory: enableErrorHistory,
            enableWaitingHistory: enableWaitingHistory,
            errorPlaceholderWidget: errorPlaceholderWidget,
            waitingPlaceholderWidget: waitingPlaceholderWidget,
          ),
        );
}

/// Async route internal builder.
///
class _AsyncRouteBuilder extends StatefulWidget {
  final String name;
  final String? errorRoute;
  final String? waitingRoute;

  final bool keepInitialBuilder;
  final bool retryFailedBuilder;
  final bool enableErrorHistory;
  final bool enableWaitingHistory;

  final Widget errorPlaceholderWidget;
  final Widget waitingPlaceholderWidget;

  final AsyncWidgetBuilderCallback builder;

  const _AsyncRouteBuilder({
    Key? key,
    required this.name,
    required this.builder,
    required this.errorRoute,
    required this.waitingRoute,
    required this.keepInitialBuilder,
    required this.retryFailedBuilder,
    required this.enableErrorHistory,
    required this.enableWaitingHistory,
    required this.errorPlaceholderWidget,
    required this.waitingPlaceholderWidget,
  }) : super(key: key);

  @override
  __AsyncRouteBuilderState createState() => __AsyncRouteBuilderState();
}

class __AsyncRouteBuilderState extends State<_AsyncRouteBuilder> {
  var _isBuilderDisposed = false;
  var _isBuilderFailed = false;

  Widget? _lastCreatedWidget;

  @override
  void initState() {
    _runBuilder();
  }

  @override
  void didUpdateWidget(_AsyncRouteBuilder oldWidget) {
    if (!widget.keepInitialBuilder) {
      if (widget.builder != oldWidget.builder) {
        _runBuilder();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (null != _lastCreatedWidget) {
      return _lastCreatedWidget!;
    }

    if (!_isBuilderDisposed && _isBuilderFailed) {
      if (widget.retryFailedBuilder) {
        _runBuilder();
      }

      return widget.errorPlaceholderWidget;
    }

    return widget.waitingPlaceholderWidget;
  }

  @override
  void dispose() {
    _isBuilderDisposed = true;
  }

  void _runBuilder() {
    _isBuilderFailed = false;

    var builder = widget.builder;

    try {
      var futureOrWidget = widget.builder();

      if (futureOrWidget is Widget) {
        _handleWidget(builder, futureOrWidget);
      } else {
        if (null != widget.waitingRoute) {
          Navigator.of(context).open(
            name: widget.waitingRoute!,
            values: {'': widget.name},
            updateHistory: widget.enableWaitingHistory,
          );
        }

        futureOrWidget.then(
          (createdWidget) => _handleWidget(builder, createdWidget),
          onError: _handleError,
        );
      }
    } catch (exception, stackTrace) {
      _handleError(exception, stackTrace);
    }
  }

  void _handleWidget(AsyncWidgetBuilderCallback builder, Widget createdWidget) {
    if (_isBuilderDisposed) {
      return;
    }

    if (!widget.keepInitialBuilder) {
      //
      // if builder has changed
      //
      if (builder != widget.builder) {
        return;
      }
    }

    _lastCreatedWidget = createdWidget;

    if (Navigator.of(context).currentRouteName != widget.name) {
      Navigator.of(context).open(
        updateHistory: false,
        name: widget.name,
      );
    } else {
      setState(() {});
    }
  }

  void _handleError(Object error, StackTrace? stackTrace) {
    if (_isBuilderDisposed) {
      return;
    }

    _isBuilderFailed = true;
    _lastCreatedWidget = null;

    if (null != widget.errorRoute) {
      Navigator.of(context).open(
        name: widget.errorRoute!,
        values: {'': widget.name},
        updateHistory: widget.enableErrorHistory,
      );
    } else {
      setState(() {});
    }
  }
}

/// A placeholder widget specific for async route.
///
class _AsyncRoutePlaceholder extends Widget {
  const _AsyncRoutePlaceholder() : super(key: null);

  // !WARN: careful. hardcoded & not covered by the tests for this widget
  @override
  String get widgetType => '_AsyncRoutePlaceholder';

  @override
  DomTag get correspondingTag => DomTag.division;
}
