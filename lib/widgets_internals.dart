// ignore_for_file: directives_ordering

/// Core (low-level exports).
///
/// This library contain exports that are required for implementing external
/// components and widget implementations.
///

library widgets_internals;

export 'src/core/common/constants.dart' show Constants;
export 'src/widgets/abstract/widget.dart' show WidgetConfiguration;
export 'src/core/common/objects/render_object.dart' show RenderObject;

// services

export 'src/core/services/debug/debug_service.dart' show DebugService;
export 'src/core/services/router/router_service.dart' show RouterService;
export 'src/core/services/router/router_service.dart' show RouterService;
export 'src/core/services/keygen/key_gen_service.dart' show KeyGenService;
export 'src/core/services/scheduler/scheduler_service.dart';
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
