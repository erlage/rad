import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/stateless_widget.dart';

/// A provider widget that can be used to provide data down the tree.
///
class StatelessProvider extends StatelessWidget {
  final Widget child;

  const StatelessProvider({
    String? id,
    required this.child,
  }) : super(id: id);

  @override
  Widget build(BuildContext context) => child;

  /// Find the nearest instance of given `T` widget.
  ///
  static T? of<T extends Widget>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<T>();
  }
}
