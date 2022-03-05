/*
|--------------------------------------------------------------------------
| core
|--------------------------------------------------------------------------
*/

// structures

export 'src/core/classes/abstract/widget.dart' show Widget;

export 'src/core/objects/build_context.dart' show BuildContext;

export '/src/core/objects/debug_options.dart' show DebugOptions;

// enums

export 'package:rad/src/core/enums.dart' show HitTestBehavior;

export 'package:rad/src/core/enums.dart' show Axis;
export 'package:rad/src/core/enums.dart' show FlexWrap;
export 'package:rad/src/core/enums.dart' show MainAxisAlignment;
export 'package:rad/src/core/enums.dart' show CrossAxisAlignment;

// props

export 'package:rad/src/core/props/margin.dart' show Margin;

export 'package:rad/src/core/props/padding.dart' show Padding;

export 'package:rad/src/core/props/alignment.dart' show Alignment;

/*
|--------------------------------------------------------------------------
| widgets
|--------------------------------------------------------------------------
*/

// main

export 'src/widgets/main/rad_app.dart' show RadApp;

export 'src/widgets/main/stateful_widget.dart' show StatefulWidget;
export 'src/widgets/main/stateless_widget.dart' show StatelessWidget;

// navigator

export 'src/widgets/main/navigator/route.dart' show Route;
export 'src/widgets/main/navigator/navigator.dart' show Navigator;

// elements

export 'src/widgets/elements/text.dart' show Text;
export 'src/widgets/elements/markup.dart' show MarkUp;

// misc

export 'src/widgets/misc/gesture_detector.dart' show GestureDetector;

// layout

export 'src/widgets/layout/flex.dart' show Flex;
export 'src/widgets/layout/stack.dart' show Stack;
export 'src/widgets/layout/align.dart' show Align;
export 'src/widgets/layout/center.dart' show Center;
export 'src/widgets/layout/container.dart' show Container;
export 'src/widgets/layout/positioned.dart' show Positioned;
export 'src/widgets/layout/overlay/overlay.dart' show Overlay;
export 'src/widgets/layout/overlay/overlay_entry.dart' show OverlayEntry;
