/*
|--------------------------------------------------------------------------
| core (low-level exports)
|
| this allow external components and widget implementations
|--------------------------------------------------------------------------
*/

export 'src/core/common/constants.dart' show Constants;
export 'src/widgets/abstract/widget.dart' show WidgetConfiguration;
export 'src/core/common/objects/render_object.dart' show RenderObject;
export 'src/core/common/objects/widget_object.dart' show WidgetObject;

// services

export 'src/core/services/debug/debug.dart' show Debug;
export 'src/core/services/router/router.dart' show Router;
export 'src/core/services/router/router.dart' show Router;
export 'src/core/services/keygen/key_gen.dart' show KeyGen;
export 'src/core/services/scheduler/scheduler.dart' show Scheduler;
export 'src/core/services/abstract.dart' show Service;
export 'src/core/services/services.dart' show Services;
export 'src/core/services/services_resolver.dart' show ServicesResolver;
export 'src/core/services/services_registry.dart' show ServicesRegistry;

// tasks

export 'src/core/services/scheduler/abstract.dart';
export 'src/core/services/scheduler/events/send_next_task_event.dart';
export 'src/core/services/scheduler/tasks/widgets_build_task.dart';
export 'src/core/services/scheduler/tasks/widgets_dispose_task.dart';
export 'src/core/services/scheduler/tasks/widgets_manage_task.dart';
export 'src/core/services/scheduler/tasks/widgets_update_task.dart';
export 'src/core/services/scheduler/tasks/stimulate_listener_task.dart';
export 'src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
