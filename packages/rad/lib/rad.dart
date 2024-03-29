// ignore_for_file: directives_ordering

/// Rad's Main library.
///
/// This library contain general widgets and functions.
///
library rad;

/*
|--------------------------------------------------------------------------
| runner
|--------------------------------------------------------------------------
*/

export 'src/core/run_app.dart' show runApp, AppRunner;

/*
|--------------------------------------------------------------------------
| enums
|--------------------------------------------------------------------------
*/

export 'src/core/common/enums.dart' show Axis;
export 'src/core/common/enums.dart' show LayoutType;
export 'src/core/common/enums.dart' show HitTestBehavior;

export 'src/core/common/enums.dart' show KindType;
export 'src/core/common/enums.dart' show FormEncType;
export 'src/core/common/enums.dart' show FormMethodType;
export 'src/core/common/enums.dart' show CrossOriginType;
export 'src/core/common/enums.dart' show DecodingType;
export 'src/core/common/enums.dart' show ReferrerPolicyType;

export 'src/core/common/enums.dart' show InputType;
export 'src/core/common/enums.dart' show ButtonType;
export 'src/core/common/enums.dart' show ListType;
export 'src/core/common/enums.dart' show FetchPriorityType;
export 'src/core/common/enums.dart' show LoadingType;
export 'src/core/common/enums.dart' show PreloadType;
export 'src/core/common/enums.dart' show DirectionType;
export 'src/core/common/enums.dart' show WrapType;
export 'src/core/common/enums.dart' show SpellCheckType;
export 'src/core/common/enums.dart' show ScopeType;

export 'src/core/common/enums.dart' show DomTagType;
export 'src/core/common/enums.dart' show DomEventType;
export 'src/core/common/enums.dart' show RenderEventType;

export 'src/core/common/enums.dart' show UpdateType;

/*
|--------------------------------------------------------------------------
| types
|--------------------------------------------------------------------------
*/

export 'src/core/common/types.dart' show VoidCallback;
export 'src/core/common/types.dart' show EventCallback;
export 'src/core/common/types.dart' show NativeEventCallback;
export 'src/core/common/types.dart' show ExceptionCallback;
export 'src/core/common/types.dart' show NullableElementCallback;
export 'src/core/common/types.dart' show PopStateEventCallback;
export 'src/core/common/types.dart' show NavigatorStateCallback;
export 'src/core/common/types.dart' show NavigatorRouteChangeCallback;

export 'src/core/common/types.dart' show WidgetBuilder;
export 'src/core/common/types.dart' show IndexedWidgetBuilder;
export 'src/core/common/types.dart' show AsyncOrSyncWidgetBuilder;

export 'src/core/common/types.dart' show RenderElementVisitor;
export 'src/core/common/types.dart' show RenderElementCallback;

/*
|--------------------------------------------------------------------------
| core
|--------------------------------------------------------------------------
*/

export 'src/core/interface/window/window.dart' show Window;
export 'src/core/interface/window/abstract.dart' show WindowDelegate;

export 'src/core/common/objects/key.dart' show Key;
export 'src/widgets/abstract/widget.dart' show Widget;
export 'src/core/services/events/emitted_event.dart' show EmittedEvent;
export 'src/core/common/objects/render_event.dart' show RenderEvent;
export 'src/core/common/abstract/build_context.dart' show BuildContext;
export 'src/core/common/abstract/render_element.dart' show RenderElement;
export 'src/core/common/objects/common_render_elements.dart'
    show RootRenderElement;
export 'src/core/common/abstract/watchful_render_element.dart';
export 'src/core/common/objects/dom_node_patch.dart' show DomNodePatch;
export 'src/core/common/objects/options/debug_options.dart' show DebugOptions;
export 'src/core/common/objects/options/mount_options.dart' show MountOptions;
export 'src/core/common/objects/options/router_options.dart' show RouterOptions;
export 'src/core/common/objects/meta_information.dart' show MetaInformation;

/*
|--------------------------------------------------------------------------
| hooks API
|--------------------------------------------------------------------------
*/

export 'src/core/common/abstract/hook.dart' show Hook;
export 'src/core/interface/hooks/types.dart' show HookScope;
export 'src/core/interface/hooks/types.dart' show HookEvent;
export 'src/core/interface/hooks/types.dart' show HookEventType;
export 'src/core/interface/hooks/types.dart' show HookEventCallback;
export 'src/core/interface/hooks/dispatcher.dart' show useHook, setupHook;

// framework provided hooks

export 'src/hooks/use_context.dart' show useContext;
export 'src/hooks/use_navigator.dart' show useNavigator;

/*
|--------------------------------------------------------------------------
| widgets
|--------------------------------------------------------------------------
*/

// abstract

export 'src/widgets/inherited_widget.dart' show InheritedWidget;
export 'src/widgets/stateful_widget.dart' show StatefulWidget, State;
export 'src/widgets/stateless_widget.dart' show StatelessWidget;

// navigator

export 'src/widgets/route.dart' show Route;
export 'src/widgets/async_route.dart' show AsyncRoute;
export 'src/widgets/navigator.dart' show Navigator, NavigatorState;

// functional

export 'src/widgets/rad_app.dart' show RadApp;
export 'src/widgets/text.dart' show Text;
export 'src/widgets/list_view.dart' show ListView;
export 'src/widgets/event_detector.dart' show EventDetector;

// misc

export 'src/widgets/raw_markup.dart' show RawMarkUp;
export 'src/widgets/raw_event_detector.dart' show RawEventDetector;
export 'src/widgets/gesture_detector.dart' show GestureDetector;
