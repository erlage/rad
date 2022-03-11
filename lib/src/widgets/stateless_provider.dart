import 'package:meta/meta.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/stateless_widget.dart';

/// A provider widget that can be used to provide data down the tree.
///
@immutable
class StatelessProvider extends StatelessWidget {
  final Widget child;

  const StatelessProvider({
    String? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => child;

  /// Find the nearest instance of given `T` widget.
  ///
  static T? of<T extends Widget>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<T>();
  }
}
