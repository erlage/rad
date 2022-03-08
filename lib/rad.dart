/*
|--------------------------------------------------------------------------
| core
|--------------------------------------------------------------------------
*/

// structures

export 'src/core/objects/render_object.dart' show RenderObject;

export 'src/core/objects/build_context.dart' show BuildContext;

export 'src/core/objects/debug_options.dart' show DebugOptions;

export 'src/widgets/abstract/widget.dart' show Widget;

// enums

export 'src/core/enums.dart' show UpdateType;

// states

export 'src/widgets/navigator/navigator_state.dart' show NavigatorState;

/*
|--------------------------------------------------------------------------
| widgets
|--------------------------------------------------------------------------
*/

// main

export 'src/widgets/app.dart' show App;

export 'src/widgets/stateful_widget.dart' show StatefulWidget;
export 'src/widgets/stateless_widget.dart' show StatelessWidget;

// navigator

export 'src/widgets/route.dart' show Route;
export 'src/widgets/navigator.dart' show Navigator;

// gestures

export 'src/widgets/gesture_detector.dart' show GestureDetector;

// elements

export 'src/widgets/text.dart' show Text;
export 'src/widgets/raw_markup.dart' show RawMarkUp;

// html

export 'src/widgets/html/span.dart' show Span;
export 'src/widgets/html/division.dart' show Division;
export 'src/widgets/html/anchor.dart' show Anchor;
export 'src/widgets/html/blockquote.dart' show Blockquote;
export 'src/widgets/html/horizontal_rule.dart' show HorizontalRule;
export 'src/widgets/html/label.dart' show Label;
export 'src/widgets/html/iframe.dart' show IFrame;

/*
|--------------------------------------------------------------------------
| allow external components and widget implementations
|--------------------------------------------------------------------------
*/

export 'src/core/enums.dart' show DomTag;

export 'src/core/constants.dart' show System;

export 'src/widgets/props/size_props.dart' show SizeProps;

export 'src/widgets/props/class_attribute_prop.dart' show ClassAttributeProp;

export 'src/core/interface/style_component.dart' show StyleComponent;

export 'src/core/objects/render_object.dart' show RenderObject;

export 'src/core/types.dart' show RenderElementCallback;

export 'src/widgets/abstract/single_child_render_object.dart'
    show SingleChildRenderObject;

export 'src/widgets/abstract/multi_child_render_object.dart'
    show MultiChildRenderObject;
