// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_event.dart';
import 'package:rad/src/core/services/events/emitted_event.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';

typedef VoidCallback = void Function();

typedef EventCallback = void Function(EmittedEvent event);

typedef NativeEventCallback = void Function(Event event);

typedef RenderEventCallback = void Function(RenderEvent event);

typedef ExceptionCallback = void Function(Exception event);

typedef NullableElementCallback = void Function(Element? element);

typedef PopStateEventCallback = void Function(PopStateEvent event);

typedef NavigatorStateCallback = void Function(NavigatorState state);

typedef NavigatorRouteChangeCallback = void Function(String name);

typedef WidgetBuilder = Widget Function(BuildContext context);

typedef AsyncOrSyncWidgetBuilder = FutureOr<Widget> Function();

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

typedef RenderElementVisitor = bool Function(RenderElement renderElement);

typedef RenderElementCallback = void Function(RenderElement renderElement);

@internal
typedef SchedulerTaskCallback = void Function(SchedulerTask task);

@internal
typedef WidgetActionsBuilder = List<WidgetAction> Function(
  RenderElement renderElement,
);
