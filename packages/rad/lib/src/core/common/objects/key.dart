import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/services/walker/walker_service.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A [Key] is an identifier for [Widget]s.
///
/// Keys must be unique amongst the [Widget]s with the same parent.
///
@immutable
class Key {
  /// Value that was used while creating the key.
  ///
  final String value;

  /// Create key.
  ///
  const Key(this.value);

  @override
  operator ==(Object other) {
    return other is Key && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'key($value)';
}

/// A key that is unique within a single app instance.
///
/// Widgets with global keys are registered in walker service and global key
/// can be used to find [RenderElement] associated with widget using
/// [WalkerService.getRenderElementAssociatedWithGlobalKey].
///
///
/// Note that this is the only difference between a normal Key and a GlobalKey.
/// For exampple, A widget with key equals to `Key('s')` will match with a
/// widget that has key equals to `GlobalKey('s')`.
///
class GlobalKey extends Key {
  /// Creates a global key.
  ///
  const GlobalKey(super.value);
}
