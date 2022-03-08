import 'dart:html';

import 'package:rad/rad.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/widget_object.dart';

typedef UpdateTypeCallback = bool Function(UpdateType updateType);

typedef OnClickCallback = void Function(MouseEvent event);

typedef OnTapEventCallback = void Function(Event event);

typedef ElementCallback = void Function(HtmlElement element);

typedef NavigatorRouteChangeCallback = void Function(String name);

typedef NavigatorStateCallback = void Function(NavigatorState state);

typedef WidgetBuilderCallback = Widget Function(BuildContext context);

typedef WidgetActionCallback = List<WidgetAction> Function(
  WidgetObject widgetObject,
);

typedef RenderElementCallback = void Function(
  RenderObject renderObject,
  HtmlElement element,
);
