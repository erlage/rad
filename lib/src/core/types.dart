import 'dart:html';

import 'package:rad/rad.dart';

typedef OnClickCallback = Function(MouseEvent event);

typedef OnTapEventCallback = Function(Event event);

typedef ElementCallback = Function(HtmlElement element);

typedef WidgetBuilderCallback = Widget Function(BuildContext context);
