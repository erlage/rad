import 'package:meta/meta.dart';

/// @nodoc
@internal
class ReverseSet<T> {
  final _set = <T>{};
  var _cachedList = <T>[];

  int get length => _set.length;
  bool get isEmpty => _set.isEmpty;
  bool get isNotEmpty => _set.isNotEmpty;
  Iterator<T> get iterator => _cachedList.reversed.iterator;

  Iterable<T> toIterable() {
    return _cachedList.reversed;
  }

  bool contains(Object? element) {
    return _set.contains(element);
  }

  T elementAt(int index) {
    return _cachedList.reversed.elementAt(index);
  }

  void add(T element) {
    if (!_set.contains(element)) {
      _set.add(element);
      _cachedList.add(element);
    }
  }

  void remove(T element) {
    if (_set.remove(element)) {
      _resetCache();
    }
  }

  void removeWhere(bool Function(T) test) {
    var collectableItems = <T>[];
    for (final item in _cachedList.reversed) {
      if (test(item)) {
        collectableItems.add(item);
      }
    }

    collectableItems.forEach(remove);
  }

  void _resetCache() {
    _cachedList = _set.toList();
  }
}
