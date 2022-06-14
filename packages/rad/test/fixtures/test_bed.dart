// ignore_for_file: camel_case_types, avoid_classes_with_only_static_members

import '../test_imports.dart';

/// Test Bed.
///
/// Provides root context, root dom node, or anything that is required
/// for setting up tests.
///
class RT_TestBed {
  static const rootTargetId = 'root-div';

  static const rootKey = GlobalKey(rootTargetId);

  static final rootRenderElement = RootElement(
    appTargetId: rootTargetId,
    appTargetDomNode: rootDomNode,
  );

  static Element get rootDomNode => document.getElementById(rootTargetId)!;

  static DebugOptions developmentModeWithoutLogs = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    additionalChecks: true,
    suppressExceptions: false,
  );
}
