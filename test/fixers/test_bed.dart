// ignore_for_file: camel_case_types

import 'dart:html';

import 'package:rad/src/core/common/objects/build_context.dart';

/// Test Bed.
///
/// Provides root context, root element, or anything that is required
/// for setting up tests.
///
class RT_TestBed {
  static const rootKey = 'root-div';

  static final rootContext = BuildContext.bigBang(rootKey);

  static Element get rootElement => document.getElementById(rootKey)!;
}
