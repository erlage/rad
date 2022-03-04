import 'dart:html';

import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';

typedef OnClickCallback = Function(MouseEvent event);

typedef OnTapEventCallback = Function(Event event);

typedef ElementCallback = Function(HtmlElement element);

typedef WidgetBuilderCallback = Widget Function(BuildContext context);

typedef WidgetObjectCallback = bool Function(WidgetObject widgetObject);
