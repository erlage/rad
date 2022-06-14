import 'dart:async';
import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';

typedef VoidCallback = void Function();

typedef EventCallback = void Function(EmittedEvent event);

typedef ExceptionCallback = void Function(Exception event);

typedef SchedulerTaskCallback = void Function(SchedulerTask task);

typedef PopStateEventCallback = void Function(PopStateEvent event);

typedef NavigatorStateCallback = void Function(NavigatorState state);

typedef NavigatorRouteChangeCallback = void Function(String name);

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

typedef ContextualWidgetBuilder = Widget Function(BuildContext context);

typedef AsyncOrSyncWidgetBuilder = FutureOr<Widget> Function();

typedef RenderElementVisitor = bool Function(RenderElement renderElement);

typedef RenderElementCallback = void Function(RenderElement renderElement);

typedef WidgetActionsBuilder = List<WidgetAction> Function(
  RenderElement renderElement,
);
