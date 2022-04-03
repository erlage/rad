// ignore_for_file: camel_case_types

import 'package:test/expect.dart';

class RT_IsLowerCase extends Matcher {
  @override
  bool matches(covariant String item, void _) => item.toLowerCase() == item;

  @override
  Description describe(Description description) {
    description.add('is lowercase');

    return description;
  }

  @override
  Description describeMismatch(
    item,
    Description mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add('\'$item\' != \'${item.toLowerCase()}\'');

    return mismatchDescription;
  }
}

class RT_IsWithoutSpace extends Matcher {
  @override
  bool matches(covariant String item, void _) => 1 == item.split(" ").length;

  @override
  Description describe(Description description) {
    description.add('is without space');

    return description;
  }

  @override
  Description describeMismatch(
    item,
    Description mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add("'$item' != '${item.split(' ').join()}'");

    return mismatchDescription;
  }
}
