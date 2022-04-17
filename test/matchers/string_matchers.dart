// ignore_for_file: camel_case_types

import 'package:test/expect.dart';

class RT_IsLowerCase extends Matcher {
  @override
  matches(covariant String item, void _) => item.toLowerCase() == item;

  @override
  describe(description) {
    description.add('is lowercase');

    return description;
  }

  @override
  describeMismatch(
    item,
    mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add('\'$item\' != \'${item.toLowerCase()}\'');

    return mismatchDescription;
  }
}

class RT_IsWithoutSpace extends Matcher {
  @override
  matches(covariant String item, void _) => 1 == item.split(" ").length;

  @override
  describe(description) {
    description.add('is without space');

    return description;
  }

  @override
  describeMismatch(
    item,
    mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add("'$item' != '${item.split(' ').join()}'");

    return mismatchDescription;
  }
}
