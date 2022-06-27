// ignore_for_file: avoid_types_on_closure_parameters, unawaited_futures

import '../../test_imports.dart' hide Text, GlobalKey;

// -----------------------------------------------------------------------
// Mannually edited file
// -----------------------------------------------------------------------

// Copyright 2014 The Flutter Authors. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// import 'package:flutter/foundation.dart';
// import 'package:flutter_test/flutter_test.dart';

class TestNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }

  bool get isListenedTo => hasListeners;
}

class HasListenersTester<T> extends ValueNotifier<T> {
  HasListenersTester(T value) : super(value);
  bool get testHasListeners => hasListeners;
}

class A {
  bool result = false;
  void test() {
    result = true;
  }
}

class B extends A with ChangeNotifier {
  @override
  void test() {
    notifyListeners();
    super.test();
  }
}

class Counter with ChangeNotifier {
  int get value => _value;
  int _value = 0;
  set value(int value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }

  void notify() {
    notifyListeners();
  }
}

void main() {
  test('ChangeNotifier with mutating listener', () {
    final TestNotifier test = TestNotifier();
    final List<String> log = <String>[];

    void listener1() {
      log.add('listener1');
    }

    void listener3() {
      log.add('listener3');
    }

    void listener4() {
      log.add('listener4');
    }

    void listener2() {
      log.add('listener2');
      test.removeListener(listener1);
      test.removeListener(listener3);
      test.addListener(listener4);
    }

    test.addListener(listener1);
    test.addListener(listener2);
    test.addListener(listener3);
    test.notify();
    expect(log, <String>['listener1', 'listener2']);
    log.clear();

    test.notify();
    expect(log, <String>['listener2', 'listener4']);
    log.clear();

    test.notify();
    expect(log, <String>['listener2', 'listener4', 'listener4']);
    log.clear();
  });

  test('During notifyListeners, a listener was added and removed immediately',
      () {
    final TestNotifier source = TestNotifier();
    final List<String> log = <String>[];

    void listener3() {
      log.add('listener3');
    }

    void listener2() {
      log.add('listener2');
    }

    void listener1() {
      log.add('listener1');
      source.addListener(listener2);
      source.removeListener(listener2);
      source.addListener(listener3);
    }

    source.addListener(listener1);

    source.notify();

    expect(log, <String>['listener1']);
  });

  test(
    'If a listener in the middle of the list of listeners removes itself, '
    'notifyListeners still notifies all listeners',
    () {
      final TestNotifier source = TestNotifier();
      final List<String> log = <String>[];

      void selfRemovingListener() {
        log.add('selfRemovingListener');
        source.removeListener(selfRemovingListener);
      }

      void listener1() {
        log.add('listener1');
      }

      source.addListener(listener1);
      source.addListener(selfRemovingListener);
      source.addListener(listener1);

      source.notify();

      expect(log, <String>['listener1', 'selfRemovingListener', 'listener1']);
    },
  );

  test(
      'If the first listener removes itself, notifyListeners still notify all listeners',
      () {
    final TestNotifier source = TestNotifier();
    final List<String> log = <String>[];

    void selfRemovingListener() {
      log.add('selfRemovingListener');
      source.removeListener(selfRemovingListener);
    }

    void listener1() {
      log.add('listener1');
    }

    source.addListener(selfRemovingListener);
    source.addListener(listener1);

    source.notifyListeners();

    expect(log, <String>['selfRemovingListener', 'listener1']);
  });

  test('Merging change notifiers', () {
    final TestNotifier source1 = TestNotifier();
    final TestNotifier source2 = TestNotifier();
    final TestNotifier source3 = TestNotifier();
    final List<String> log = <String>[];

    final Listenable merged = Listenable.merge(<Listenable>[source1, source2]);
    void listener1() {
      log.add('listener1');
    }

    void listener2() {
      log.add('listener2');
    }

    merged.addListener(listener1);
    source1.notify();
    source2.notify();
    source3.notify();
    expect(log, <String>['listener1', 'listener1']);
    log.clear();

    merged.removeListener(listener1);
    source1.notify();
    source2.notify();
    source3.notify();
    expect(log, isEmpty);
    log.clear();

    merged.addListener(listener1);
    merged.addListener(listener2);
    source1.notify();
    source2.notify();
    source3.notify();
    expect(log, <String>['listener1', 'listener2', 'listener1', 'listener2']);
    log.clear();
  });

  test('Merging change notifiers ignores null', () {
    final TestNotifier source1 = TestNotifier();
    final TestNotifier source2 = TestNotifier();
    final List<String> log = <String>[];

    final Listenable merged =
        Listenable.merge(<Listenable?>[null, source1, null, source2, null]);
    void listener() {
      log.add('listener');
    }

    merged.addListener(listener);
    source1.notify();
    source2.notify();
    expect(log, <String>['listener', 'listener']);
    log.clear();
  });

  test('Can remove from merged notifier', () {
    final TestNotifier source1 = TestNotifier();
    final TestNotifier source2 = TestNotifier();
    final List<String> log = <String>[];

    final Listenable merged = Listenable.merge(<Listenable>[source1, source2]);
    void listener() {
      log.add('listener');
    }

    merged.addListener(listener);
    source1.notify();
    source2.notify();
    expect(log, <String>['listener', 'listener']);
    log.clear();

    merged.removeListener(listener);
    source1.notify();
    source2.notify();
    expect(log, isEmpty);
  });

  test('Cannot use a disposed ChangeNotifier except for remove listener', () {
    final TestNotifier source = TestNotifier();
    source.dispose();
    expect(
      () {
        source.addListener(() {});
      },
      throwsA(
        predicate(
          (e) => '$e'.startsWith(
            'Exception: Notifier was used after being disposed',
          ),
        ),
      ),
    );
    expect(
      () {
        source.dispose();
      },
      throwsA(
        predicate(
          (e) => '$e'.startsWith(
            'Exception: Notifier was used after being disposed',
          ),
        ),
      ),
    );
    expect(
      () {
        source.notify();
      },
      throwsA(
        predicate(
          (e) => '$e'.startsWith(
            'Exception: Notifier was used after being disposed',
          ),
        ),
      ),
    );
  });

  test('Can remove listener on a disposed ChangeNotifier', () {
    final TestNotifier source = TestNotifier();
    Exception? error;
    try {
      source.dispose();
      source.removeListener(() {});
    } on Exception catch (e) {
      error = e;
    }
    expect(error, isNull);
  });

  test('Value notifier', () {
    final ValueNotifier<double> notifier = ValueNotifier<double>(2.0);

    final List<double> log = <double>[];
    void listener() {
      log.add(notifier.value);
    }

    notifier.addListener(listener);
    notifier.value = 3.0;

    expect(log, equals(<double>[3.0]));
    log.clear();

    notifier.value = 3.0;
    expect(log, isEmpty);
  });

  test('Listenable.merge toString', () {
    final TestNotifier source1 = TestNotifier();
    final TestNotifier source2 = TestNotifier();

    Listenable listenableUnderTest = Listenable.merge(<Listenable>[]);
    expect(listenableUnderTest.toString(), 'Listenable.merge([])');

    listenableUnderTest = Listenable.merge(<Listenable?>[null]);
    expect(listenableUnderTest.toString(), 'Listenable.merge([null])');

    listenableUnderTest = Listenable.merge(<Listenable>[source1]);
    expect(
      listenableUnderTest.toString(),
      "Listenable.merge([Instance of 'TestNotifier'])",
    );

    listenableUnderTest = Listenable.merge(<Listenable>[source1, source2]);
    expect(
      listenableUnderTest.toString(),
      "Listenable.merge([Instance of 'TestNotifier', Instance of 'TestNotifier'])",
    );

    listenableUnderTest = Listenable.merge(<Listenable?>[null, source2]);
    expect(
      listenableUnderTest.toString(),
      "Listenable.merge([null, Instance of 'TestNotifier'])",
    );
  });

  test('Listenable.merge does not leak', () {
    // Regression test for https://github.com/flutter/flutter/issues/25163.

    final TestNotifier source1 = TestNotifier();
    final TestNotifier source2 = TestNotifier();
    void fakeListener() {}

    final Listenable listenableUnderTest =
        Listenable.merge(<Listenable>[source1, source2]);
    expect(source1.isListenedTo, isFalse);
    expect(source2.isListenedTo, isFalse);
    listenableUnderTest.addListener(fakeListener);
    expect(source1.isListenedTo, isTrue);
    expect(source2.isListenedTo, isTrue);

    listenableUnderTest.removeListener(fakeListener);
    expect(source1.isListenedTo, isFalse);
    expect(source2.isListenedTo, isFalse);
  });

  test('hasListeners', () {
    final HasListenersTester<bool> notifier = HasListenersTester<bool>(true);
    expect(notifier.testHasListeners, isFalse);
    void test1() {}
    void test2() {}
    notifier.addListener(test1);
    expect(notifier.testHasListeners, isTrue);
    notifier.addListener(test1);
    expect(notifier.testHasListeners, isTrue);
    notifier.removeListener(test1);
    expect(notifier.testHasListeners, isTrue);
    notifier.removeListener(test1);
    expect(notifier.testHasListeners, isFalse);
    notifier.addListener(test1);
    expect(notifier.testHasListeners, isTrue);
    notifier.addListener(test2);
    expect(notifier.testHasListeners, isTrue);
    notifier.removeListener(test1);
    expect(notifier.testHasListeners, isTrue);
    notifier.removeListener(test2);
    expect(notifier.testHasListeners, isFalse);
  });

  test('ChangeNotifier as a mixin', () {
    // We document that this is a valid way to use this class.
    final B b = B();
    int notifications = 0;
    b.addListener(() {
      notifications += 1;
    });
    expect(b.result, isFalse);
    expect(notifications, 0);
    b.test();
    expect(b.result, isTrue);
    expect(notifications, 1);
  });

  test('Throws Exception when disposed and called', () {
    final TestNotifier testNotifier = TestNotifier();
    testNotifier.dispose();
    Exception? error;
    try {
      testNotifier.dispose();
    } on Exception catch (e) {
      error = e;
    }
    expect(error, isNotNull);
    expect(
      '$error'.startsWith(
        'Exception: Notifier was used after being disposed',
      ),
      equals(true),
    );
  });

  test('notifyListener can be called recursively', () {
    final Counter counter = Counter();
    final List<String> log = <String>[];

    void listener1() {
      log.add('listener1');
      if (counter.value < 0) {
        counter.value = 0;
      }
    }

    counter.addListener(listener1);
    counter.notify();
    expect(log, <String>['listener1']);
    log.clear();

    counter.value = 3;
    expect(log, <String>['listener1']);
    log.clear();

    counter.value = -2;
    expect(log, <String>['listener1', 'listener1']);
    log.clear();
  });

  test('Remove Listeners while notifying on a list which will not resize', () {
    final TestNotifier test = TestNotifier();
    final List<String> log = <String>[];
    final List<VoidCallback> listeners = <VoidCallback>[];

    void autoRemove() {
      // We remove 4 listeners.
      // We will end up with (13-4 = 9) listeners.
      test.removeListener(listeners[1]);
      test.removeListener(listeners[3]);
      test.removeListener(listeners[4]);
      test.removeListener(autoRemove);
    }

    test.addListener(autoRemove);

    // We add 12 more listeners.
    for (int i = 0; i < 12; i++) {
      void listener() {
        log.add('listener$i');
      }

      listeners.add(listener);
      test.addListener(listener);
    }

    final List<int> remainingListenerIndexes = <int>[
      0,
      2,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
    ];
    final List<String> expectedLog =
        remainingListenerIndexes.map((int i) => 'listener$i').toList();

    test.notify();
    expect(log, expectedLog);

    log.clear();
    // We expect to have the same result after the removal of previous listeners.
    test.notify();
    expect(log, expectedLog);

    // We remove all other listeners.
    for (int i = 0; i < remainingListenerIndexes.length; i++) {
      test.removeListener(listeners[remainingListenerIndexes[i]]);
    }

    log.clear();
    test.notify();
    expect(log, <String>[]);
  });
}
