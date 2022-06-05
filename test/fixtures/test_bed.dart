// ignore_for_file: camel_case_types, avoid_classes_with_only_static_members

import 'dart:html';

import 'package:rad/rad.dart';

/// Test Bed.
///
/// Provides root context, root dom node, or anything that is required
/// for setting up tests.
///
class RT_TestBed {
  static const rootKey = GlobalKey('root-div');

  static final rootContext = BuildContext.bigBang(rootKey);

  static Element get rootElement => document.getElementById(rootKey.value)!;

  static DebugOptions developmentModeWithoutLogs = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    additionalChecks: true,
    suppressExceptions: false,
  );
}
