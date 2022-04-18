import 'package:rad/src/core/window/abstract.dart';

/// Window interface.
///
class Window {
  Window._();
  static Window? _instance;
  static Window get instance => _instance ??= Window._();

  WindowDelegate? _delegate;
  static WindowDelegate get delegate => instance._delegate!;

  /// Bind delegate for window.
  ///
  void bindDelegate(WindowDelegate delegate) => _delegate = delegate;
}
