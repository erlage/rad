/// Router options.
///
/// [path] refers to the path name where your app files are located. If
///  your files are located on main domain/sub domain then you don't have to
/// fiddle with it. But if your files are situated in a sub directory/path on a
/// domain, for example, `x.com/y_folder/index.html` then set `routingPath` to
/// `/y_folder`:
///
/// ```dart
/// RouterOptions(
///   ...
///   path: '/y_folder',
///   ...
/// )
/// ```
class RouterOptions {
  /// Routing path.
  ///
  final String path;

  /// Whether to enable hash based routing.
  ///
  final bool enableHashBasedRouting;

  const RouterOptions({
    required this.path,
    required this.enableHashBasedRouting,
  });

  static const defaultMode = developmentMode;

  static const developmentMode = RouterOptions(
    path: '',
    enableHashBasedRouting: true,
  );

  static const productionMode = RouterOptions(
    path: '',
    enableHashBasedRouting: false,
  );
}
