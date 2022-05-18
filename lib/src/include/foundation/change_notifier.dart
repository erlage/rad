// ignore_for_file: prefer_asserts_with_message

import 'package:rad/src/core/common/types.dart';

/// An object that maintains a list of listeners.
///
abstract class Listenable {
  const Listenable();

  /// Return a [Listenable] that triggers when any of the given [Listenable]s
  /// themselves trigger.
  ///
  factory Listenable.merge(List<Listenable?> listenables) = _MergingListenable;

  /// Register a closure to be called when the object notifies its listeners.
  void addListener(Callback listener);

  /// Remove a previously registered closure from the list of closures that the
  /// object notifies.
  void removeListener(Callback listener);
}

/// An interface for subclasses of [Listenable] that expose a [value].
///
abstract class ValueListenable<T> extends Listenable {
  const ValueListenable();

  T get value;
}

/// A class that can be extended or mixed in that provides a change notification
/// API using [Callback] for notifications.
///
class ChangeNotifier implements Listenable {
  int _count = 0;
  List<Callback?> _listeners = List<Callback?>.filled(0, null);
  int _notificationCallStackDepth = 0;
  int _reentrantlyRemovedListeners = 0;
  bool _debugDisposed = false;

  bool _debugAssertNotDisposed() {
    assert(
      () {
        if (_debugDisposed) {
          return false;
        }
        return true;
      }(),
    );
    return true;
  }

  /// Whether any listeners are currently registered.
  ///
  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _count > 0;
  }

  /// Register a closure to be called when the object changes.
  ///
  @override
  void addListener(Callback listener) {
    assert(_debugAssertNotDisposed());
    if (_count == _listeners.length) {
      if (_count == 0) {
        _listeners = List<Callback?>.filled(1, null);
      } else {
        final List<Callback?> newListeners =
            List<Callback?>.filled(_listeners.length * 2, null);
        for (int i = 0; i < _count; i++) {
          newListeners[i] = _listeners[i];
        }
        _listeners = newListeners;
      }
    }
    _listeners[_count++] = listener;
  }

  void _removeAt(int index) {
    _count -= 1;

    if (_count * 2 <= _listeners.length) {
      final List<Callback?> newListeners = List<Callback?>.filled(_count, null);

      // Listeners before the index are at the same place.
      for (int i = 0; i < index; i++) {
        newListeners[i] = _listeners[i];
      }

      // Listeners after the index move towards the start of the list.
      for (int i = index; i < _count; i++) {
        newListeners[i] = _listeners[i + 1];
      }

      _listeners = newListeners;
    } else {
      // When there are more listeners than half the length of the list, we only
      // shift our listeners, so that we avoid to reallocate memory for the
      // whole list.
      for (int i = index; i < _count; i++) {
        _listeners[i] = _listeners[i + 1];
      }
      _listeners[_count] = null;
    }
  }

  /// Remove a previously registered closure from the list of closures that are
  ///
  @override
  void removeListener(Callback listener) {
    assert(_debugAssertNotDisposed());
    for (int i = 0; i < _count; i++) {
      final Callback? listener = _listeners[i];
      if (listener == listener) {
        if (_notificationCallStackDepth > 0) {
          _listeners[i] = null;
          _reentrantlyRemovedListeners++;
        } else {
          _removeAt(i);
        }
        break;
      }
    }
  }

  /// Discards any resources used by the object. After this is called, the
  /// object is not in a usable state and should be discarded (calls to
  /// [addListener] and [removeListener] will throw after the object is
  /// disposed).
  ///
  void dispose() {
    assert(_debugAssertNotDisposed());
    assert(
      () {
        _debugDisposed = true;
        return true;
      }(),
    );
  }

  /// Call all the registered listeners.
  ///
  void notifyListeners() {
    assert(_debugAssertNotDisposed());
    if (_count == 0) return;

    _notificationCallStackDepth++;

    final int end = _count;
    for (int i = 0; i < end; i++) {
      try {
        _listeners[i]?.call();
      } catch (exception, stack) {
        print('Something went wrong. Stacktrace: $stack');
      }
    }

    _notificationCallStackDepth--;

    if (_notificationCallStackDepth == 0 && _reentrantlyRemovedListeners > 0) {
      // We really remove the listeners when all notifications are done.
      final int newLength = _count - _reentrantlyRemovedListeners;
      if (newLength * 2 <= _listeners.length) {
        // As in _removeAt, we only shrink the list when the real number of
        // listeners is half the length of our list.
        final List<Callback?> newListeners =
            List<Callback?>.filled(newLength, null);

        int newIndex = 0;
        for (int i = 0; i < _count; i++) {
          final Callback? listener = _listeners[i];
          if (listener != null) {
            newListeners[newIndex++] = listener;
          }
        }

        _listeners = newListeners;
      } else {
        // Otherwise we put all the null references at the end.
        for (int i = 0; i < newLength; i += 1) {
          if (_listeners[i] == null) {
            // We swap this item with the next not null item.
            int swapIndex = i + 1;
            while (_listeners[swapIndex] == null) {
              swapIndex += 1;
            }
            _listeners[i] = _listeners[swapIndex];
            _listeners[swapIndex] = null;
          }
        }
      }

      _reentrantlyRemovedListeners = 0;
      _count = newLength;
    }
  }
}

class _MergingListenable extends Listenable {
  _MergingListenable(this._children);

  final List<Listenable?> _children;

  @override
  void addListener(Callback listener) {
    for (final Listenable? child in _children) {
      child?.addListener(listener);
    }
  }

  @override
  void removeListener(Callback listener) {
    for (final Listenable? child in _children) {
      child?.removeListener(listener);
    }
  }

  @override
  String toString() {
    return 'Listenable.merge([${_children.join(", ")}])';
  }
}

/// A [ChangeNotifier] that holds a single value.
///
/// When [value] is replaced with something that is not equal to the old
/// value as evaluated by the equality operator ==, this class notifies its
/// listeners.
///
class ValueNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  /// Creates a [ChangeNotifier] that wraps this value.
  ValueNotifier(this._value);

  @override
  T get value => _value;
  T _value;
  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '$runtimeType($value)';
}
