import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';

typedef UpdateTypeCallback = bool Function(UpdateType updateType);

typedef OnTapEventCallback = void Function(Event event);

typedef NavigatorRouteChangeCallback = void Function(String name);

typedef NavigatorStateCallback = void Function(NavigatorState state);

typedef WidgetBuilderCallback = Widget Function(BuildContext context);

typedef LazyItemBuilderCallback = Widget Function(int index);

typedef WidgetActionCallback = List<WidgetAction> Function(
  WidgetObject widgetObject,
);

typedef RenderElementCallback = void Function(
  RenderObject renderObject,
  HtmlElement element,
);

// input related

typedef EventCallback = void Function(Event event);
