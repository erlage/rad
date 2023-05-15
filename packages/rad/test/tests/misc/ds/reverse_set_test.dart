import '../../../test_imports.dart';

import 'package:rad/src/core/common/ds/reverse_set.dart';

void main() {
  group('ReverseSet', () {
    late ReverseSet<int> reverseSet;

    setUp(() {
      reverseSet = ReverseSet<int>();
    });

    test('adding elements to ReverseSet', () {
      final reverseSet = ReverseSet<int>();
      expect(reverseSet.length, 0);

      reverseSet.add(1);
      expect(reverseSet.length, 1);
      expect(reverseSet.contains(1), true);

      reverseSet.add(2);
      expect(reverseSet.length, 2);
      expect(reverseSet.contains(2), true);

      // adding duplicate elements
      reverseSet.add(1);
      expect(reverseSet.length, 2);
      expect(reverseSet.contains(1), true);
    });

    test('removing elements from ReverseSet', () {
      final reverseSet = ReverseSet<int>();
      reverseSet.add(1);
      reverseSet.add(2);

      reverseSet.remove(1);
      expect(reverseSet.length, 1);
      expect(reverseSet.contains(1), false);
      expect(reverseSet.contains(2), true);

      // removing non-existent elements
      reverseSet.remove(3);
      expect(reverseSet.length, 1);
      expect(reverseSet.contains(1), false);
      expect(reverseSet.contains(2), true);
    });

    test('iterating through elements in ReverseSet', () {
      final reverseSet = ReverseSet<int>();
      reverseSet.add(1);
      reverseSet.add(2);
      reverseSet.add(3);

      final iterator = reverseSet.iterator;
      expect(iterator.moveNext(), true);
      expect(iterator.current, 3);
      expect(iterator.moveNext(), true);
      expect(iterator.current, 2);
      expect(iterator.moveNext(), true);
      expect(iterator.current, 1);
      expect(iterator.moveNext(), false);
    });

    test('adding and elementAt', () {
      reverseSet.add(1);
      expect(reverseSet.contains(1), isTrue);
      expect(reverseSet.length, equals(1));
      expect(reverseSet.elementAt(0), equals(1));

      reverseSet.add(2);
      expect(reverseSet.contains(2), isTrue);
      expect(reverseSet.length, equals(2));
      expect(reverseSet.elementAt(0), equals(2));
      expect(reverseSet.elementAt(1), equals(1));

      reverseSet.add(3);
      expect(reverseSet.contains(3), isTrue);
      expect(reverseSet.length, equals(3));
      expect(reverseSet.elementAt(0), equals(3));
      expect(reverseSet.elementAt(1), equals(2));
      expect(reverseSet.elementAt(2), equals(1));

      reverseSet.add(1);
      expect(reverseSet.contains(1), isTrue);
      expect(reverseSet.length, equals(3));
      expect(reverseSet.elementAt(0), equals(3));
      expect(reverseSet.elementAt(1), equals(2));
      expect(reverseSet.elementAt(2), equals(1));
    });

    test('removing and elementAt', () {
      reverseSet.add(1);
      reverseSet.add(2);
      reverseSet.add(3);

      reverseSet.remove(2);
      expect(reverseSet.contains(2), isFalse);
      expect(reverseSet.length, equals(2));
      expect(reverseSet.elementAt(0), equals(3));
      expect(reverseSet.elementAt(1), equals(1));

      reverseSet.remove(1);
      expect(reverseSet.contains(1), isFalse);
      expect(reverseSet.length, equals(1));
      expect(reverseSet.elementAt(0), equals(3));

      reverseSet.remove(3);
      expect(reverseSet.contains(3), isFalse);
      expect(reverseSet.length, equals(0));

      reverseSet.remove(1);
      expect(reverseSet.contains(1), isFalse);
      expect(reverseSet.length, equals(0));
    });

    test('removeWhere()', () {
      reverseSet.add(1);
      reverseSet.add(2);
      reverseSet.add(3);
      reverseSet.add(4);
      reverseSet.add(5);

      // remove even numbers
      reverseSet.removeWhere((element) => element % 2 == 0);

      // check that only odd numbers are left
      expect(reverseSet.toIterable(), equals([5, 3, 1]));

      // remove odd numbers
      reverseSet.removeWhere((element) => element % 2 == 1);

      // check that the set is now empty
      expect(reverseSet.toIterable(), isEmpty);
    });
  });
}
