import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/types.dart';

/// Window delegate.
///
abstract class WindowDelegate {
  String get locationHref;
  String get locationHash;
  String get locationPathName;

  /// Add a pop state listener and associate it with provided
  /// context.
  ///
  void addPopStateListener({
    required BuildContext context,
    required PopStateEventCallback callback,
  });

  /// Remove pop state listener that's associated with the context.
  ///
  void removePopStateListener(BuildContext context);

  /// Adds an entry to the session history stack.
  ///
  void historyPushState({
    required String title,
    required String url,
    required BuildContext context,
  });

  /// Replace last entry on the session history stack.
  ///
  void historyReplaceState({
    required String title,
    required String url,
    required BuildContext context,
  });
}
