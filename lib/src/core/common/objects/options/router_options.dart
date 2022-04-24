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
  final String path;

  const RouterOptions({
    required this.path,
  });

  static const defaultMode = RouterOptions(path: '');
}
