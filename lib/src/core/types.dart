import 'dart:html';

import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/main/navigator/navigator_state.dart';

typedef OnClickCallback = void Function(MouseEvent event);

typedef OnTapEventCallback = void Function(Event event);

typedef ElementCallback = void Function(HtmlElement element);

typedef NavigatorRouteChangeCallback = void Function(String name);

typedef NavigatorStateCallback = void Function(NavigatorState state);

typedef WidgetBuilderCallback = Widget Function(BuildContext context);

typedef WidgetActionCallback = List<WidgetAction> Function(
  WidgetObject widgetObject,
);
