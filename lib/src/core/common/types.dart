import 'dart:async';
import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';

typedef Callback = void Function();

typedef VoidCallback = Callback;

typedef EventCallback = void Function(EmittedEvent event);

typedef SchedulerTaskCallback = void Function(SchedulerTask task);

typedef UpdateTypeCallback = bool Function(UpdateType updateType);

typedef NavigatorRouteChangeCallback = void Function(String name);

typedef NavigatorStateCallback = void Function(NavigatorState state);

typedef AsyncWidgetBuilderCallback = FutureOr<Widget> Function();

typedef WidgetBuilderContextualCallback = Widget Function(BuildContext context);

typedef ExceptionCallback = void Function(Exception event);

typedef PopStateEventCallback = void Function(PopStateEvent event);

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

typedef WidgetActionCallback = List<WidgetAction> Function(
  WidgetObject widgetObject,
);
