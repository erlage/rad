// ignore_for_file: camel_case_types

// import 'dart:html';

// import 'package:rad/src/core/framework.dart';
// import 'package:rad/src/core/common/types.dart';
// import 'package:rad/src/core/common/objects/key.dart';
// import 'package:rad/src/widgets/abstract/widget.dart';
// import 'package:rad/src/core/interface/window/window.dart';
// import 'package:rad/src/core/common/objects/debug_options.dart';
// import 'package:rad/src/core/common/objects/build_context.dart';
// import 'package:rad/src/core/interface/window/delegates/browser_window.dart';

// class RT_TestAppBootstrapper {
//   final Widget app;
//   final String targetId;
//   final String routingPath;
//   final Callback? beforeMount;
//   final DebugOptions debugOptions;

//   BuildContext? _rootContext;
//   BuildContext get rootContext => _rootContext!;

//   Framework? _framework;
//   Framework get framework => _framework!;

//   RT_TestAppBootstrapper({
//     required this.app,
//     required this.targetId,
//     this.routingPath = '',
//     this.beforeMount,
//     this.debugOptions = DebugOptions.defaultMode,
//   });

//   void setupDelegates() => Window.instance.bindDelegate(BrowserWindow());

//   void createContext() {
//     var globalKey = GlobalKey(targetId);

//     _rootContext = BuildContext.bigBang(globalKey);
//   }

//   void spinFramework() => _framework = Framework(rootContext);

//   void prepareMount() {
//     // Pre-checks before mount

//     var targetElement = document.getElementById(targetId) as HtmlElement?;

//     if (null == targetElement) {
//       throw "Unable to locate target element in HTML document";
//     }

//     // Decorate target element

//     CommonProps.applyDataAttributes(targetElement, {
//       Constants.attrConcreteType: "Target",
//       Constants.attrRuntimeType: Constants.contextTypeBigBang,
//     });

//     // Insert framework's styles
//     // Components interface is not public yet.
//     Components(rootContext: rootContext).injectStyles(
//       GEN_STYLES_MAIN_CSS,
//       'Rad default styles.',
//     );

//     // Trigger hooks

//     beforeMount?.call();
//   }

//   void startServices() {
//     var services = Services(rootContext);

//     ServicesRegistry.instance.registerServices(rootContext, services);

//     services.debug.startService(debugOptions);

//     services.router.startService(routingPath);

//     services.scheduler.startService(framework.taskProcessor);
//   }

//   /// Schedule a build task.
//   ///
//   void scheduleBuildTask() {
//     var schedulerService = ServicesRegistry.instance.getScheduler(rootContext);

//     schedulerService.addTask(
//       WidgetsBuildTask(
//         widgets: [app],
//         parentContext: rootContext,
//       ),
//     );
//   }
// }
